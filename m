From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 19 May 2011 18:47:20 +0200
Subject: i.MX consolidation patches
Message-ID: <1305823648-2428-1-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following series cleans up some ifdeffery and in the end
allows to compile all armv4 and armv5 based i.MXs together in a
single kernel. The corresponding defconfigs are merged into one.

This series breaks XIP support for these i.MXs. It should be possible
to keep it, but it would require another level of Kconfig indirection
which I wanted to avoid.

Sascha

Sascha Hauer (7):
      ARM i.MX: fix last user of iomux.h and remove it
      ARM i.MX: define CLOCK_TICK_RATE to bogus value
      ARM i.MX: remove SoC defines around header includes
      ARM i.MX: dmav1: kill SoC ifdefs
      ARM i.MX Allow to compile together i.MX1/21/25/27
      ARM i.MX mxc.h: use CONFIG_SOC_* instead of CONFIG_ARCH_*
      ARM i.MX debug macro: use CONFIG_SOC_* instead of CONFIG_ARCH_*

Uwe Kleine-K?nig (1):
      ARM: mxc: update defconfigs

 .../{mx27_defconfig => imx_armv4_armv5_defconfig}  |   59 ++++++++++--
 arch/arm/configs/mx1_defconfig                     |   91 ------------------
 arch/arm/configs/mx21_defconfig                    |   97 --------------------
 arch/arm/configs/mx3_defconfig                     |   43 +++++++--
 arch/arm/configs/mx51_defconfig                    |   55 +++++++++--
 arch/arm/mach-imx/Kconfig                          |   51 ++++-------
 arch/arm/mach-imx/Makefile                         |   10 +-
 arch/arm/mach-imx/Makefile.boot                    |   16 ---
 arch/arm/mach-imx/dma-v1.c                         |   25 +-----
 arch/arm/mach-imx/mach-imx27_visstrim_m10.c        |    2 +-
 arch/arm/plat-mxc/Kconfig                          |   18 +---
 arch/arm/plat-mxc/devices/platform-imx-dma.c       |    2 +-
 arch/arm/plat-mxc/include/mach/debug-macro.S       |   10 +-
 arch/arm/plat-mxc/include/mach/hardware.h          |   28 +-----
 arch/arm/plat-mxc/include/mach/iomux.h             |   26 -----
 arch/arm/plat-mxc/include/mach/mxc.h               |    8 +-
 arch/arm/plat-mxc/include/mach/timex.h             |   13 +--
 17 files changed, 177 insertions(+), 377 deletions(-)
 rename arch/arm/configs/{mx27_defconfig => imx_armv4_armv5_defconfig} (72%)
 delete mode 100644 arch/arm/configs/mx1_defconfig
 delete mode 100644 arch/arm/configs/mx21_defconfig
 delete mode 100644 arch/arm/plat-mxc/include/mach/iomux.h
