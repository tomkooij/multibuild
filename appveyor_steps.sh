#!/bin/bash
# Wheel build, install, run test steps on Linux
#
# In fact the main work is to wrap up the real functions in docker commands.
# The real work is in the BUILD_SCRIPT (which builds the wheel) and
# `docker_install_run.sh`, which can be configured with `config.sh`.
#
# Must define
#  before_install
#  build_wheel
#  install_run
set -e

MANYLINUX_URL=${MANYLINUX_URL:-https://nipy.bic.berkeley.edu/manylinux}

# Get our own location on this filesystem
MULTIBUILD_DIR=$(dirname "${BASH_SOURCE[0]}")

# Allow travis Python version as proxy for multibuild Python version
MB_PYTHON_VERSION=${MB_PYTHON_VERSION:-$TRAVIS_PYTHON_VERSION}

function before_install {
    # Install a virtualenv to work in.
    virtualenv -p $PYTHON\\python.exe venv
    source venv/Scripts/activate
    python --version # just to check
    pip install --upgrade pip wheel
}
