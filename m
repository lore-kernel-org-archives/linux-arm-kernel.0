From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 20 Feb 2018 22:59:47 +0100
Subject: [PATCH 0/7] ARM: hacks for link-time optimization
Message-ID: <20180220215954.4092811-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nico, all,

I was playing with ARM link-time optimization handling earlier this
month, and eventually got it to build cleanly with randconfig kernels,
but ended up with a lot of ugly hacks to actually pull it off.

Here are the ones that I don't think we actually want to merge,
but it may be helpful to have these for reference for the next
person that tries to make it work.

      Arnd

Arnd Bergmann (7):
  ARM: disallow combining XIP and LTO
  ARM: LTO: avoid THUMB2_KERNEL+LTO
  [HACK] pass endianess flag to LTO linker
  ARM: io-acorn: fix LTO linking without CONFIG_PRINTK
  ARM: fix __inflate_kernel_data stack warning for LTO
  ARM: mark assembler-referenced symbols as __visible
  efi: disable LTO for EFI stub

 arch/arm/Kconfig                      |  4 +++-
 arch/arm/Makefile                     |  2 ++
 arch/arm/kernel/Makefile              |  3 ---
 arch/arm/kernel/head-inflate-data.c   |  3 ++-
 arch/arm/kernel/process.c             |  2 +-
 arch/arm/kernel/suspend.c             |  2 ++
 arch/arm/kernel/unwind.c              |  1 +
 arch/arm/lib/io-acorn.S               |  4 ++++
 arch/arm/probes/kprobes/core.c        |  2 +-
 arch/arm/probes/kprobes/test-core.c   | 11 ++++++-----
 arch/arm/vdso/vgettimeofday.c         |  2 ++
 drivers/bus/arm-cci.c                 |  6 +++---
 drivers/firmware/efi/libstub/Makefile |  4 +++-
 drivers/soc/bcm/brcmstb/pm/pm-arm.c   |  2 +-
 lib/clz_ctz.c                         | 20 ++++++++++----------
 15 files changed, 41 insertions(+), 27 deletions(-)

-- 
2.9.0
