FROM ubuntu:20.04

ARG WORKSPACE=/workspace

ENV SHELL=/bin/bash

WORKDIR ${WORKSPACE}

#system
RUN apt-get update

RUN apt-get upgrade -y

RUN apt-get install -y vim git wget python3 python-is-python3 pip make sudo

RUN pip3 install loguru Commitizen

RUN mkdir /opt/toolchain/ \
    && wget -nv -c http://releases.linaro.org/components/toolchain/binaries/7.5-2019.12/aarch64-elf/gcc-linaro-7.5.0-2019.12-x86_64_aarch64-elf.tar.xz \
    && tar -xf gcc-linaro-7.5.0-2019.12-x86_64_aarch64-elf.tar -C /opt/toolchain \
    && rm -f gcc-linaro-7.5.0-2019.12-x86_64_aarch64-elf.tar \
    && wget -nv -c https://nucleisys.com/upload/files/toochain/gcc/nuclei_riscv_newlibc_prebuilt_linux64_2022.12.tar.bz2 \
    && tar -xjf nuclei_riscv_newlibc_prebuilt_linux64_2022.12.tar.bz2 -C /opt/toolchain \
    && rm -f nuclei_riscv_newlibc_prebuilt_linux64_2022.12.tar.bz2 \
    && mv /opt/toolchain/gcc /opt/toolchain/riscv-gcc \
    && chmod -R a+x /opt/toolchain/

ENV APU_TOOCHAIN_PATH = /opt/toolchain/gcc-linaro-7.5.0-2019.12-x86_64_aarch64-elf/bin
ENV RPU_TOOCHAIN_PATH = /opt/toolchain/riscv-gcc/bin
