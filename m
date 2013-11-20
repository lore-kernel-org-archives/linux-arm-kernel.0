From: vaibhav.bedia@gmail.com (Vaibhav Bedia)
Date: Wed, 20 Nov 2013 13:18:13 -0500
Subject: Kernel build failing randomly
Message-ID: <CANacCWyQiG_txsRuCD+pLSijc02ZThvGSRCywO7VF1R02z0yPA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I am seeing some random build errors in the final stage of
the kernel build. At times just rerunning the command is
sufficient to get a working zImage/uImage.

This is based on v3.12 with omap2plus_defconfig but i
do remember seeing this a few days back 3.12-rcX also.

I haven't seen any fixed pattern to reproduce this.

Bad case
===
$ make uImage LOADADDR=0x80008000
[...]
  LINK    vmlinux
  LD      vmlinux.o
  MODPOST vmlinux.o
  GEN     .version
  CHK     include/generated/compile.h
  UPD     include/generated/compile.h
  CC      init/version.o
  LD      init/built-in.o
scripts/link-vmlinux.sh: line 52: 28021 Killed                  ${LD}
${LDFLAGS} ${LDFLAGS_vmlinux} -o ${2} -T ${lds} ${KBUILD_VMLINUX_INIT}
--start-group ${KBUILD_VMLINUX_MAIN} --end-group ${1}
make: *** [vmlinux] Error 137

A single rerun of the make command works most of the times.

In case it helps, i am using the Linaro 4.7.3 toolchain inside a Ubuntu VM.

Regards,
Vaibhav
