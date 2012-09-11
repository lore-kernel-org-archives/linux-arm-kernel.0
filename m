From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 11 Sep 2012 15:54:56 +0800
Subject: [GIT PULL 1/4] mxs device tree changes for 3.7
In-Reply-To: <1347350100-4674-1-git-send-email-shawn.guo@linaro.org>
References: <1347350100-4674-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1347350100-4674-2-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit d9875690d9b89a866022ff49e3fcea892345ad92:

  Linux 3.6-rc2 (2012-08-16 14:51:24 -0700)

are available in the git repository at:

  git://git.linaro.org/people/shawnguo/linux-2.6.git tags/mxs-dt-3.7

for you to fetch changes up to 13b4569bbbcf58891727138b84b8db5ea4178d32:

  ARM: dts: cfa10049: Add the 74HC595 gpio expanders (2012-09-11 09:51:30 +0800)

----------------------------------------------------------------
mxs-dt-3.7

- Remove all board files and make mach-mxs a DT-only platform
- Some dts file formatting and style fixing
- DTS update for additional boards and devices

----------------------------------------------------------------
Dong Aisheng (1):
      ARM: mx28evk: add missed clkmux select for saif

Fabio Estevam (8):
      ARM: imx23-olinuxino.dts: Add AUART0 support
      ARM: mach-mxs: Remove board entries in dt_board_compat
      ARM: mxs: Rename 'hog-gpios'
      ARM: mxs: Let mmc0 pin detect be generic
      ARM: olinuxino: Add gpio-led support
      ARM: mx28evk: Add SPI flash support
      ARM: mx28evk: Add LRADC support
      ARM: mx28evk: Add I2C EEPROM support

Marek Vasut (5):
      ARM: dts: imx28: Add compatible and interrupt for LRADC
      ARM: mx28: Add SPI 2 pinmux into imx28.dtsi
      ARM: mx28: Add USB PHY overcurrent pinmux
      ARM: mxs: Update DENX M28 machine and dts file
      ARM: dts: m28evk: Fix MMC WP pin being inverted

Maxime Ripard (8):
      ARM: dts: mxs: Add alternative I2C muxing options for imx28
      ARM: dts: mxs: Add pwm4 muxing options for imx28
      ARM: dts: mxs: Add I2C1 muxing options for imx28
      ARM: dts: mxs: Add the second I2C adapter to the CFA10049 expansion board
      ARM: dts: mxs: Enable USB1 Host on the CFA-10049 expansion board
      ARM: dts: mxs: Add missing address and size cells in SSP nodes
      ARM: dts: cfa10049: Add SSP3 to the 10049 board
      ARM: dts: cfa10049: Add the 74HC595 gpio expanders

Shawn Guo (6):
      ARM: mxs: tx28: reset fec phy for device tree boot
      ARM: mxs: use auxdata to pass flexcan_switch function hook
      ARM: mxs: remove board files
      ARM: mxs: remove non-DT core functions
      ARM: mxs: remove platform device codes
      ARM: mxs: remove iomux driver

 arch/arm/boot/dts/imx23-evk.dts                   |    3 [32m+[m[31m-[m
 arch/arm/boot/dts/imx23-olinuxino.dts             |   31 [32m++[m
 arch/arm/boot/dts/imx23-stmp378x_devb.dts         |    2 [32m+[m[31m-[m
 arch/arm/boot/dts/imx23.dtsi                      |   12 [32m+[m[31m-[m
 arch/arm/boot/dts/imx28-apx4devkit.dts            |    2 [32m+[m[31m-[m
 arch/arm/boot/dts/imx28-cfa10049.dts              |   99 [32m++++[m
 arch/arm/boot/dts/imx28-evk.dts                   |   29 [32m+[m[31m-[m
 arch/arm/boot/dts/imx28-m28evk.dts                |   83 [32m+++[m[31m-[m
 arch/arm/boot/dts/imx28-tx28.dts                  |   23 [32m+[m[31m-[m
 arch/arm/boot/dts/imx28.dtsi                      |   86 [32m++++[m
 arch/arm/configs/mxs_defconfig                    |    6 [31m-[m
 arch/arm/mach-mxs/Kconfig                         |   89 [31m----[m
 arch/arm/mach-mxs/Makefile                        |   11 [32m+[m[31m-[m
 arch/arm/mach-mxs/Makefile.boot                   |    1 [32m+[m
 arch/arm/mach-mxs/devices-mx23.h                  |   43 [31m--[m
 arch/arm/mach-mxs/devices-mx28.h                  |   63 [31m---[m
 arch/arm/mach-mxs/devices.c                       |   87 [31m----[m
 arch/arm/mach-mxs/devices/Kconfig                 |   33 [31m--[m
 arch/arm/mach-mxs/devices/Makefile                |   12 [31m-[m
 arch/arm/mach-mxs/devices/platform-auart.c        |   65 [31m---[m
 arch/arm/mach-mxs/devices/platform-dma.c          |   31 [31m--[m
 arch/arm/mach-mxs/devices/platform-fec.c          |   52 [31m--[m
 arch/arm/mach-mxs/devices/platform-flexcan.c      |   51 [31m--[m
 arch/arm/mach-mxs/devices/platform-gpio-mxs.c     |   33 [31m--[m
 arch/arm/mach-mxs/devices/platform-gpmi-nand.c    |   81 [31m----[m
 arch/arm/mach-mxs/devices/platform-mxs-i2c.c      |   52 [31m--[m
 arch/arm/mach-mxs/devices/platform-mxs-mmc.c      |   76 [31m---[m
 arch/arm/mach-mxs/devices/platform-mxs-pwm.c      |   22 [31m-[m
 arch/arm/mach-mxs/devices/platform-mxs-saif.c     |   61 [31m---[m
 arch/arm/mach-mxs/devices/platform-mxsfb.c        |   47 [31m--[m
 arch/arm/mach-mxs/devices/platform-rtc-stmp3xxx.c |   51 [31m--[m
 arch/arm/mach-mxs/include/mach/common.h           |    9 [31m-[m
 arch/arm/mach-mxs/include/mach/devices-common.h   |  114 [31m-----[m
 arch/arm/mach-mxs/include/mach/iomux-mx23.h       |  355 [31m--------------[m
 arch/arm/mach-mxs/include/mach/iomux-mx28.h       |  537 [31m---------------------[m
 arch/arm/mach-mxs/include/mach/iomux.h            |  168 [31m-------[m
 arch/arm/mach-mxs/iomux.c                         |  101 [31m----[m
 arch/arm/mach-mxs/mach-apx4devkit.c               |  273 [31m-----------[m
 arch/arm/mach-mxs/mach-m28evk.c                   |  366 [31m--------------[m
 arch/arm/mach-mxs/mach-mx23evk.c                  |  190 [31m--------[m
 arch/arm/mach-mxs/mach-mx28evk.c                  |  477 [31m------------------[m
 arch/arm/mach-mxs/mach-mxs.c                      |  138 [32m+++++[m[31m-[m
 arch/arm/mach-mxs/mach-stmp378x_devb.c            |  123 [31m-----[m
 arch/arm/mach-mxs/mach-tx28.c                     |  184 [31m-------[m
 arch/arm/mach-mxs/mm.c                            |   39 [31m--[m
 arch/arm/mach-mxs/module-tx28.c                   |  160 [31m------[m
 arch/arm/mach-mxs/module-tx28.h                   |   10 [31m-[m
 47 files changed, 485 insertions(+), 4096 deletions(-)
 create mode 100644 arch/arm/boot/dts/imx28-cfa10049.dts
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
