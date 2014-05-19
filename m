From: shawn.guo@freescale.com (Shawn Guo)
Date: Mon, 19 May 2014 14:56:42 +0800
Subject: [PATCH 0/4] ARM: imx: clean up i.MX5 files
Message-ID: <1400482606-8278-1-git-send-email-shawn.guo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

i.MX51 becomes a DT only platform.  So some non-DT support code can be
removed now.

Shawn Guo (4):
  ARM: imx: move SOC_IMX5 and SOC_IMX51 into 'Device tree only'
  ARM: imx: drop option MACH_IMX51_DT
  ARM: imx: remove imx51 non-DT support files
  ARM: imx: remove i.MX5 non-DT device registration helpers

 arch/arm/configs/imx_v6_v7_defconfig               |   2 +-
 arch/arm/configs/multi_v7_defconfig                |   2 +-
 arch/arm/mach-imx/Kconfig                          |  26 +-
 arch/arm/mach-imx/Makefile                         |   4 +-
 arch/arm/mach-imx/devices-imx51.h                  |  66 --
 arch/arm/mach-imx/devices/platform-fec.c           |  12 -
 arch/arm/mach-imx/devices/platform-fsl-usb2-udc.c  |   5 -
 arch/arm/mach-imx/devices/platform-imx-i2c.c       |  26 -
 arch/arm/mach-imx/devices/platform-imx-keypad.c    |  10 -
 arch/arm/mach-imx/devices/platform-imx-ssi.c       |  20 -
 arch/arm/mach-imx/devices/platform-imx-uart.c      |  22 -
 arch/arm/mach-imx/devices/platform-imx2-wdt.c      |  18 -
 arch/arm/mach-imx/devices/platform-mxc-ehci.c      |   9 -
 arch/arm/mach-imx/devices/platform-mxc_nand.c      |   5 -
 arch/arm/mach-imx/devices/platform-pata_imx.c      |  10 -
 .../mach-imx/devices/platform-sdhci-esdhc-imx.c    |  24 -
 arch/arm/mach-imx/devices/platform-spi_imx.c       |  27 -
 arch/arm/mach-imx/ehci-imx5.c                      | 171 -----
 arch/arm/mach-imx/iomux-mx51.h                     | 827 ---------------------
 arch/arm/mach-imx/{imx51-dt.c => mach-imx51.c}     |   0
 20 files changed, 15 insertions(+), 1271 deletions(-)
 delete mode 100644 arch/arm/mach-imx/devices-imx51.h
 delete mode 100644 arch/arm/mach-imx/ehci-imx5.c
 delete mode 100644 arch/arm/mach-imx/iomux-mx51.h
 rename arch/arm/mach-imx/{imx51-dt.c => mach-imx51.c} (100%)

-- 
1.8.3.2
