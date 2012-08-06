From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 6 Aug 2012 23:42:43 +0800
Subject: [PATCH 0/6] ARM: mxs: remove board files
Message-ID: <1344267769-31166-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The first two patches hack out the board oddness in DT boot for TX28
and MX28EVK, so that they do not block the whole progress of coverting
mxs platform over to DT.

The rest of the series removes board files and the codes only used in
non-DT boot, and make mxs a DT-only platform.

Shawn Guo (6):
  ARM: mxs: tx28: reset fec phy for device tree boot
  ARM: mxs: use auxdata to pass flexcan_switch function hook
  ARM: mxs: remove board files
  ARM: mxs: remove non-DT core functions
  ARM: mxs: remove platform device codes
  ARM: mxs: remove iomux driver

 arch/arm/boot/dts/imx28-tx28.dts                  |   21 +-
 arch/arm/configs/mxs_defconfig                    |    6 -
 arch/arm/mach-mxs/Kconfig                         |   89 ----
 arch/arm/mach-mxs/Makefile                        |   11 +-
 arch/arm/mach-mxs/devices-mx23.h                  |   43 --
 arch/arm/mach-mxs/devices-mx28.h                  |   63 ---
 arch/arm/mach-mxs/devices.c                       |   87 ----
 arch/arm/mach-mxs/devices/Kconfig                 |   33 --
 arch/arm/mach-mxs/devices/Makefile                |   12 -
 arch/arm/mach-mxs/devices/platform-auart.c        |   65 ---
 arch/arm/mach-mxs/devices/platform-dma.c          |   31 --
 arch/arm/mach-mxs/devices/platform-fec.c          |   52 --
 arch/arm/mach-mxs/devices/platform-flexcan.c      |   51 --
 arch/arm/mach-mxs/devices/platform-gpio-mxs.c     |   33 --
 arch/arm/mach-mxs/devices/platform-gpmi-nand.c    |   81 ---
 arch/arm/mach-mxs/devices/platform-mxs-i2c.c      |   52 --
 arch/arm/mach-mxs/devices/platform-mxs-mmc.c      |   76 ---
 arch/arm/mach-mxs/devices/platform-mxs-pwm.c      |   22 -
 arch/arm/mach-mxs/devices/platform-mxs-saif.c     |   61 ---
 arch/arm/mach-mxs/devices/platform-mxsfb.c        |   47 --
 arch/arm/mach-mxs/devices/platform-rtc-stmp3xxx.c |   51 --
 arch/arm/mach-mxs/include/mach/common.h           |    9 -
 arch/arm/mach-mxs/include/mach/devices-common.h   |  114 -----
 arch/arm/mach-mxs/include/mach/iomux-mx23.h       |  355 --------------
 arch/arm/mach-mxs/include/mach/iomux-mx28.h       |  537 ---------------------
 arch/arm/mach-mxs/include/mach/iomux.h            |  168 -------
 arch/arm/mach-mxs/iomux.c                         |  101 ----
 arch/arm/mach-mxs/mach-apx4devkit.c               |  273 -----------
 arch/arm/mach-mxs/mach-m28evk.c                   |  366 --------------
 arch/arm/mach-mxs/mach-mx23evk.c                  |  190 --------
 arch/arm/mach-mxs/mach-mx28evk.c                  |  477 ------------------
 arch/arm/mach-mxs/mach-mxs.c                      |  126 +++++-
 arch/arm/mach-mxs/mach-stmp378x_devb.c            |  123 -----
 arch/arm/mach-mxs/mach-tx28.c                     |  184 -------
 arch/arm/mach-mxs/mm.c                            |   39 --
 arch/arm/mach-mxs/module-tx28.c                   |  160 ------
 arch/arm/mach-mxs/module-tx28.h                   |   10 -
 37 files changed, 146 insertions(+), 4073 deletions(-)
 delete mode 100644 arch/arm/mach-mxs/devices-mx23.h
 delete mode 100644 arch/arm/mach-mxs/devices-mx28.h
 delete mode 100644 arch/arm/mach-mxs/devices.c
 delete mode 100644 arch/arm/mach-mxs/devices/Kconfig
 delete mode 100644 arch/arm/mach-mxs/devices/Makefile
 delete mode 100644 arch/arm/mach-mxs/devices/platform-auart.c
 delete mode 100644 arch/arm/mach-mxs/devices/platform-dma.c
 delete mode 100644 arch/arm/mach-mxs/devices/platform-fec.c
 delete mode 100644 arch/arm/mach-mxs/devices/platform-flexcan.c
 delete mode 100644 arch/arm/mach-mxs/devices/platform-gpio-mxs.c
 delete mode 100644 arch/arm/mach-mxs/devices/platform-gpmi-nand.c
 delete mode 100644 arch/arm/mach-mxs/devices/platform-mxs-i2c.c
 delete mode 100644 arch/arm/mach-mxs/devices/platform-mxs-mmc.c
 delete mode 100644 arch/arm/mach-mxs/devices/platform-mxs-pwm.c
 delete mode 100644 arch/arm/mach-mxs/devices/platform-mxs-saif.c
 delete mode 100644 arch/arm/mach-mxs/devices/platform-mxsfb.c
 delete mode 100644 arch/arm/mach-mxs/devices/platform-rtc-stmp3xxx.c
 delete mode 100644 arch/arm/mach-mxs/include/mach/devices-common.h
 delete mode 100644 arch/arm/mach-mxs/include/mach/iomux-mx23.h
 delete mode 100644 arch/arm/mach-mxs/include/mach/iomux-mx28.h
 delete mode 100644 arch/arm/mach-mxs/include/mach/iomux.h
 delete mode 100644 arch/arm/mach-mxs/iomux.c
 delete mode 100644 arch/arm/mach-mxs/mach-apx4devkit.c
 delete mode 100644 arch/arm/mach-mxs/mach-m28evk.c
 delete mode 100644 arch/arm/mach-mxs/mach-mx23evk.c
 delete mode 100644 arch/arm/mach-mxs/mach-mx28evk.c
 delete mode 100644 arch/arm/mach-mxs/mach-stmp378x_devb.c
 delete mode 100644 arch/arm/mach-mxs/mach-tx28.c
 delete mode 100644 arch/arm/mach-mxs/module-tx28.c
 delete mode 100644 arch/arm/mach-mxs/module-tx28.h

-- 
1.7.5.4
