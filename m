From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 25 Sep 2013 15:32:24 +0200
Subject: [GIT PULL] delete the Shark machine for v3.13
Message-ID: <CACRpkdaRp-FYOVN+bcS73MJ6hVSVH1s0yF4Q40UQrbBVYXW2yg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC folks,

This patch set deletes the Shark sub-architecture from the ARM
tree. All patches cleaning up the subsystem trees from references
to this machine have been ACKed except a oneliner in the block
layer, which I am pretty sure Jens will not be upset about.

Please pull it in on a suitable cleanup branch.

Yours,
Linus Walleij


The following changes since commit 272b98c6455f00884f0350f775c5342358ebb73f:

  Linux 3.12-rc1 (2013-09-16 16:17:51 -0400)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git
tags/del-shark-for-v3.13

for you to fetch changes up to fc6ad619a5d29c94e3eecefa572dc1d4fefdc240:

  video: drop code for ARCH_SHARK in cyber2000fb (2013-09-25 15:25:24 +0200)

----------------------------------------------------------------
This deletes the Shark SA110-based sub-architecture from
the kernel.

----------------------------------------------------------------
Linus Walleij (6):
      ARM: delete mach-shark
      MAINTAINERS: delete Shark machine entry
      block: drop dependency on ARCH_SHARK
      ide: drop dependency on ARCH_SHARK
      input: i8042: drop dependency on ARCH_SHARK
      video: drop code for ARCH_SHARK in cyber2000fb

 MAINTAINERS                                    |   5 -
 arch/arm/Kconfig                               |  20 --
 arch/arm/Makefile                              |   1 -
 arch/arm/boot/compressed/Makefile              |   4 -
 arch/arm/boot/compressed/head-shark.S          | 140 -------------
 arch/arm/boot/compressed/ofw-shark.c           | 260 -------------------------
 arch/arm/common/Makefile                       |   1 -
 arch/arm/common/via82c505.c                    |  83 --------
 arch/arm/configs/shark_defconfig               |  80 --------
 arch/arm/include/asm/mach/pci.h                |   4 -
 arch/arm/lib/Makefile                          |   1 -
 arch/arm/lib/io-shark.c                        |  13 --
 arch/arm/mach-shark/Makefile                   |  10 -
 arch/arm/mach-shark/Makefile.boot              |   2 -
 arch/arm/mach-shark/core.c                     | 146 --------------
 arch/arm/mach-shark/dma.c                      |  23 ---
 arch/arm/mach-shark/include/mach/debug-macro.S |  34 ----
 arch/arm/mach-shark/include/mach/entry-macro.S |  36 ----
 arch/arm/mach-shark/include/mach/framebuffer.h |  16 --
 arch/arm/mach-shark/include/mach/hardware.h    |  16 --
 arch/arm/mach-shark/include/mach/irqs.h        |  13 --
 arch/arm/mach-shark/include/mach/isa-dma.h     |  13 --
 arch/arm/mach-shark/include/mach/memory.h      |  26 ---
 arch/arm/mach-shark/include/mach/timex.h       |   7 -
 arch/arm/mach-shark/include/mach/uncompress.h  |  50 -----
 arch/arm/mach-shark/irq.c                      | 108 ----------
 arch/arm/mach-shark/leds.c                     | 117 -----------
 arch/arm/mach-shark/pci.c                      |  57 ------
 drivers/block/Kconfig                          |   2 +-
 drivers/ide/Kconfig                            |   4 +-
 drivers/input/serio/Kconfig                    |   2 +-
 drivers/video/cyber2000fb.c                    |  70 -------
 32 files changed, 4 insertions(+), 1360 deletions(-)
 delete mode 100644 arch/arm/boot/compressed/head-shark.S
 delete mode 100644 arch/arm/boot/compressed/ofw-shark.c
 delete mode 100644 arch/arm/common/via82c505.c
 delete mode 100644 arch/arm/configs/shark_defconfig
 delete mode 100644 arch/arm/lib/io-shark.c
 delete mode 100644 arch/arm/mach-shark/Makefile
 delete mode 100644 arch/arm/mach-shark/Makefile.boot
 delete mode 100644 arch/arm/mach-shark/core.c
 delete mode 100644 arch/arm/mach-shark/dma.c
 delete mode 100644 arch/arm/mach-shark/include/mach/debug-macro.S
 delete mode 100644 arch/arm/mach-shark/include/mach/entry-macro.S
 delete mode 100644 arch/arm/mach-shark/include/mach/framebuffer.h
 delete mode 100644 arch/arm/mach-shark/include/mach/hardware.h
 delete mode 100644 arch/arm/mach-shark/include/mach/irqs.h
 delete mode 100644 arch/arm/mach-shark/include/mach/isa-dma.h
 delete mode 100644 arch/arm/mach-shark/include/mach/memory.h
 delete mode 100644 arch/arm/mach-shark/include/mach/timex.h
 delete mode 100644 arch/arm/mach-shark/include/mach/uncompress.h
 delete mode 100644 arch/arm/mach-shark/irq.c
 delete mode 100644 arch/arm/mach-shark/leds.c
 delete mode 100644 arch/arm/mach-shark/pci.c
