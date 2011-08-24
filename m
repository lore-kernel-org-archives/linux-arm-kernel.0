From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 24 Aug 2011 10:03:03 +0200
Subject: i.MX multi SoC patches
Message-ID: <1314172987-10349-1-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is hopefully the last iteration of the patches for compiling
all ARMv4/v5 based i.MXs together. CONFIG_ARM_PATCH_PHYS_VIRT
lost its experimental status and we can still build uImages
even with CONFIG_AUTO_ZRELADDR enabled. This series selects
these options and makes a multi SoC image the default.
Also, we can now build all i.MX5 SoCs into a single image.
This series also updates the defconfigs.

Sascha Hauer (4):
      ARM i.MX: allow to compile together ARMv4 and ARMv5 based SoCs
      ARM i.MX: allow to compile together all i.MX5 based SoCs
      ARM i.MX5: update defconfig
      ARM i.MX defconfigs: use one defconfig for all ARMv4/v5 SoCs

 arch/arm/Makefile                                  |    4 +-
 .../{mx27_defconfig => imx_v4_v5_defconfig}        |   68 +++++++++++---
 arch/arm/configs/mx1_defconfig                     |   91 ------------------
 arch/arm/configs/mx21_defconfig                    |   97 --------------------
 arch/arm/configs/{mx51_defconfig => mx5_defconfig} |   65 ++++++-------
 arch/arm/mach-imx/Kconfig                          |   50 ++++-------
 arch/arm/mach-mx5/Kconfig                          |   18 +---
 arch/arm/plat-mxc/Kconfig                          |   39 ++------
 arch/arm/plat-mxc/include/mach/memory.h            |   16 +---
 9 files changed, 118 insertions(+), 330 deletions(-)
 rename arch/arm/configs/{mx27_defconfig => imx_v4_v5_defconfig} (69%)
 delete mode 100644 arch/arm/configs/mx1_defconfig
 delete mode 100644 arch/arm/configs/mx21_defconfig
 rename arch/arm/configs/{mx51_defconfig => mx5_defconfig} (81%)
