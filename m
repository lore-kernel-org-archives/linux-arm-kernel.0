From: shc_work@mail.ru (Alexander Shiyan)
Date: Sat, 17 Nov 2012 17:57:06 +0400
Subject: [PATCH v3 00/18] ARM: Patchset for CLPS711X
Message-ID: <1353160644-22446-1-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here is a v3 patchset for a CLPS711X-target.
The main direction of this patchset - approaching the platform to the
possibility of using configurations with multiple platforms in a single
kernel. Added support of the majority of the necessary kernel symbol.
Also part of the driver code used only for the platform was moved to the
board code and converted to the use of standard drivers.

Alexander Shiyan (18):
  ARM: clps711x: Using platform_driver for ethernet device
  ARM: clps711x: p720t: Using "leds-gpio" driver for LED control
  ARM: clps711x: Transform clps711x-framebuffer to platform driver and
    use it
  ARM: clps711x: p720t: Unneeded inclusion of head-sa1100.S removed
  ARM: clps711x: Always select AUTO_ZRELADDR for a platform
  ARM: clps711x: cdb89712: Special driver for handling memory is
    removed
  ARM: clps711x: Implement usage "SPARSE_IRQ" kernel option for a
    platform
  ARM: clps711x: Implement usage "MULTI_IRQ_HANDLER" kernel option for
    a platform
  ARM: clps711x: Add FIQ interrupt handling
  ARM: clps711x: Unused empty "ACK" calls for IRQ-chips removed
  ARM: clps711x: autcpu12: Special driver for handling NAND memory is
    removed
  ARM: clps711x: Moving power management of framebuffer driver to the
    board
  ARM: clps711x: p720t: Special driver for handling NAND memory is
    removed
  ARM: clps711x: Moving backlight controls of framebuffer driver to the
    board
  ARM: clps711x: edb7211: Add support for NOR-Flash
  ARM: clps711x: Rename board files to match functionality
  ARM: clps711x: Update defconfig due latest changes and new kernel
    symbols
  MAINTAINERS: Add ARM CLPS711X entry

 MAINTAINERS                                        |    6 +
 arch/arm/Kconfig                                   |    3 +
 arch/arm/boot/compressed/Makefile                  |    5 -
 arch/arm/configs/clps711x_defconfig                |   30 ++-
 arch/arm/mach-clps711x/Kconfig                     |    2 -
 arch/arm/mach-clps711x/Makefile                    |   12 +-
 arch/arm/mach-clps711x/Makefile.boot               |    1 -
 arch/arm/mach-clps711x/autcpu12.c                  |   83 ------
 arch/arm/mach-clps711x/board-autcpu12.c            |  179 +++++++++++++
 arch/arm/mach-clps711x/board-cdb89712.c            |  147 +++++++++++
 .../mach-clps711x/{clep7312.c => board-clep7312.c} |    4 +-
 arch/arm/mach-clps711x/board-edb7211.c             |  180 +++++++++++++
 .../mach-clps711x/{fortunet.c => board-fortunet.c} |    2 +
 arch/arm/mach-clps711x/board-p720t.c               |  232 ++++++++++++++++
 arch/arm/mach-clps711x/cdb89712.c                  |   63 -----
 arch/arm/mach-clps711x/common.c                    |   92 ++++++--
 arch/arm/mach-clps711x/common.h                    |    7 +-
 arch/arm/mach-clps711x/edb7211.c                   |   88 ------
 arch/arm/mach-clps711x/include/mach/autcpu12.h     |   13 -
 arch/arm/mach-clps711x/include/mach/clps711x.h     |   24 ++
 arch/arm/mach-clps711x/include/mach/entry-macro.S  |   51 ----
 arch/arm/mach-clps711x/include/mach/hardware.h     |   25 +--
 arch/arm/mach-clps711x/include/mach/irqs.h         |   46 ----
 arch/arm/mach-clps711x/p720t.c                     |  173 ------------
 drivers/mtd/maps/Kconfig                           |    7 -
 drivers/mtd/maps/Makefile                          |    1 -
 drivers/mtd/maps/cdb89712.c                        |  278 --------------------
 drivers/mtd/nand/Kconfig                           |   13 -
 drivers/mtd/nand/Makefile                          |    2 -
 drivers/mtd/nand/autcpu12.c                        |  237 -----------------
 drivers/mtd/nand/spia.c                            |  176 -------------
 drivers/video/clps711xfb.c                         |  156 ++----------
 32 files changed, 907 insertions(+), 1431 deletions(-)
 delete mode 100644 arch/arm/mach-clps711x/autcpu12.c
 create mode 100644 arch/arm/mach-clps711x/board-autcpu12.c
 create mode 100644 arch/arm/mach-clps711x/board-cdb89712.c
 rename arch/arm/mach-clps711x/{clep7312.c => board-clep7312.c} (95%)
 create mode 100644 arch/arm/mach-clps711x/board-edb7211.c
 rename arch/arm/mach-clps711x/{fortunet.c => board-fortunet.c} (96%)
 create mode 100644 arch/arm/mach-clps711x/board-p720t.c
 delete mode 100644 arch/arm/mach-clps711x/cdb89712.c
 delete mode 100644 arch/arm/mach-clps711x/edb7211.c
 delete mode 100644 arch/arm/mach-clps711x/include/mach/entry-macro.S
 delete mode 100644 arch/arm/mach-clps711x/include/mach/irqs.h
 delete mode 100644 arch/arm/mach-clps711x/p720t.c
 delete mode 100644 drivers/mtd/maps/cdb89712.c
 delete mode 100644 drivers/mtd/nand/autcpu12.c
 delete mode 100644 drivers/mtd/nand/spia.c

-- 
1.7.8.6
