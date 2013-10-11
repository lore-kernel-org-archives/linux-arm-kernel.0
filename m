From: ankit.jindal@linaro.org (Ankit Jindal)
Date: Fri, 11 Oct 2013 17:52:11 +0530
Subject: [RFC PATCH 0/4] Big Endian support for ARM64 kernel
Message-ID: <1381494135-15085-1-git-send-email-ankit.jindal@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds support for using Big Endian mode of AArch64 CPUs

All patches have been tested on APM X-Gene Storm SOC.

The Big Endian toolchain used for development can be found at:
http://cbuild.validation.linaro.org/snapshots/big_endian

We have tested both 32bit BE and 64bit BE root filesystems with these
patches.

The 64bit BE root filesystem was build manually using busybox-1.21.1 and
above mentioned toolchain.

The 32bit BE root filesystem was readily available from Linaro releases
located at: http://snapshots.linaro.org/openembedded/images

Ankit Jindal (4):
  ARM64: Add Kconfig option to enable Big Endian kernel
  ARM64: Include appropriate byteorder for Big Endian
  ARM64: Big Endian fixes for kernel booting
  ARM64: Support for 32-bit big endian userspace

 arch/arm64/Kconfig                      |    2 ++
 arch/arm64/Makefile                     |    7 +++++++
 arch/arm64/include/asm/assembler.h      |    7 +++++++
 arch/arm64/include/asm/processor.h      |    3 +++
 arch/arm64/include/uapi/asm/byteorder.h |    4 ++++
 arch/arm64/kernel/head.S                |   34 +++++++++++++++++++++++++++++++
 arch/arm64/kernel/setup.c               |   19 +++++++++++++----
 arch/arm64/kernel/signal32.c            |    4 ++++
 arch/arm64/kernel/smp_spin_table.c      |    5 +++--
 arch/arm64/mm/Kconfig                   |    7 +++++++
 arch/arm64/mm/proc.S                    |    2 +-
 11 files changed, 87 insertions(+), 7 deletions(-)
 create mode 100644 arch/arm64/mm/Kconfig

-- 
1.7.9.5
