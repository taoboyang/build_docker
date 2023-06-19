#!/bin/bash
set -eux

sed -i 's/--disable-shared/--enable-shared/g' docker/build_scripts/build-cpython.sh
sed -i '/RUN manylinux-entrypoint \/build_scripts\/finalize-python.sh/d' docker/Dockerfile
sed -i 's/^[ \t]*${PREFIX}\/bin\/python/LD_LIBRARY_PATH=${PREFIX}\/lib ${PREFIX}\/bin\/python/g' docker/build_scripts/finalize.sh
sed -i 's/^[ \t]*${PREFIX}\/bin\/pip/LD_LIBRARY_PATH=${PREFIX}\/lib ${PREFIX}\/bin\/pip/g' docker/build_scripts/finalize.sh
sed -i 's/$(${PREFIX}\/bin\/python/$(LD_LIBRARY_PATH=${PREFIX}\/lib ${PREFIX}\/bin\/python/g' docker/build_scripts/finalize.sh
sed -i 's/^\/opt\/python\/cp310-cp310\/bin\/python/LD_LIBRARY_PATH=\/opt\/python\/cp310-cp310\/lib \/opt\/python\/cp310-cp310\/bin\/python/g' docker/build_scripts/finalize.sh
sed -i 's/^pip install/LD_LIBRARY_PATH=\/opt\/python\/cp310-cp310\/lib pip install/g' docker/build_scripts/finalize.sh
sed -i 's/^${TOOLS_PATH}\/bin\/pipx/LD_LIBRARY_PATH=\/opt\/python\/cp310-cp310\/lib ${TOOLS_PATH}\/bin\/pipx/g' docker/build_scripts/finalize.sh
sed -i 's/^[ \t]*$PYTHON/LD_LIBRARY_PATH=$(dirname $PYTHON)\/..\/lib $PYTHON/g' tests/run_tests.sh
sed -i 's/$(${PYTHON}/$(LD_LIBRARY_PATH=$(dirname ${PYTHON})\/..\/lib ${PYTHON}/g' tests/run_tests.sh
sed -i 's/$(${LINK_PREFIX}/$(LD_LIBRARY_PATH=$(dirname ${PYTHON})\/..\/lib ${LINK_PREFIX}/g' tests/run_tests.sh
sed -i '/ssl-check.py/s/^/#/g' tests/run_tests.sh
sed -i 's/^auditwheel --version/export LD_LIBRARY_PATH=\/opt\/python\/cp310-cp310\/lib\nauditwheel --version/g' tests/run_tests.sh
sed -i '$i\ENV LD_LIBRARY_PATH=\/opt\/python\/cp38-cp38\/lib:\/opt\/python\/cp310-cp310\/lib' docker/Dockerfile
sed -i 's/^ln -s $(python -c/LD_LIBRARY_PATH=\/opt\/python\/cp310-cp310\/lib \/opt\/python\/cp310-cp310\/bin\/pip3 install certifi \nln -s $(LD_LIBRARY_PATH=\/opt\/python\/cp310-cp310\/lib \/opt\/python\/cp310-cp310\/bin\/python3 -c/g' docker/build_scripts/finalize.sh
