From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 26 Oct 2010 17:05:49 +0200
Subject: [GIT PULL] i.MX updates for 2.6.37
Message-ID: <20101026150549.GB5445@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

Please pull the remaining updates for 2.6.37.

Sascha

The following changes since commit f1de1613da54f754d5d2bbf79fcacbd5ed965537:

  eukrea_mbimxsd-baseboard: Pass the correct GPIO to gpio_free (2010-10-19 18:45:21 +0200)

are available in the git repository at:
  git://git.pengutronix.de/git/imx/linux-2.6.git for-rmk

Dinh Nguyen (3):
      ARM: imx: Add gpio-keys to plat-mxc
      ARM: mx5: Add gpio-keys to mx51 babbage board
      ARM: imx: Add wake functionality to GPIO

Rogerio Pimentel (4):
      MX27 3ds: Add SDHC1 support to mx27 3ds
      mx31_3ds: Remove unused debug board definitions
      mx31_3ds: Fix the logic for detecting the debug board
      mx31_3ds: Fix spi registration

Shawn Guo (3):
      babbage: esdhc device registration
      mx35_3ds: add mmc support
      mx25_3ds: add mmc support

Uwe Kleine-K?nig (2):
      ARM: mx3: fix build failure concerning MXC_INT_MMC_SDHC2
      imx: only select HAVE_CAN_FLEXCAN if CAN is enabled

Xiao Jiang (1):
      mx35pdk: add debug board support

Yong Shen (1):
      cpufreq for freescale mx51

 arch/arm/Kconfig                                |    6 +
 arch/arm/configs/mx51_defconfig                 |    1 +
 arch/arm/mach-imx/mach-mx27_3ds.c               |   38 ++++
 arch/arm/mach-mx25/Kconfig                      |    1 +
 arch/arm/mach-mx25/mach-mx25_3ds.c              |   10 +
 arch/arm/mach-mx3/Kconfig                       |    2 +
 arch/arm/mach-mx3/devices.c                     |   16 +-
 arch/arm/mach-mx3/mach-mx31_3ds.c               |   38 +----
 arch/arm/mach-mx3/mach-mx35_3ds.c               |   16 ++
 arch/arm/mach-mx5/Kconfig                       |    2 +
 arch/arm/mach-mx5/Makefile                      |    1 +
 arch/arm/mach-mx5/board-mx51_babbage.c          |   49 ++++++-
 arch/arm/mach-mx5/clock-mx51.c                  |   22 +++-
 arch/arm/mach-mx5/cpu_op-mx51.c                 |   29 ++++
 arch/arm/mach-mx5/cpu_op-mx51.h                 |   14 ++
 arch/arm/mach-mx5/devices-imx51.h               |    2 +
 arch/arm/plat-mxc/Makefile                      |    1 +
 arch/arm/plat-mxc/cpufreq.c                     |  206 +++++++++++++++++++++++
 arch/arm/plat-mxc/devices/Kconfig               |    6 +-
 arch/arm/plat-mxc/devices/Makefile              |    1 +
 arch/arm/plat-mxc/devices/platform-gpio_keys.c  |   27 +++
 arch/arm/plat-mxc/gpio.c                        |   32 ++++
 arch/arm/plat-mxc/include/mach/devices-common.h |    4 +
 arch/arm/plat-mxc/include/mach/iomux-mx51.h     |    2 +
 arch/arm/plat-mxc/include/mach/mx31.h           |    1 -
 arch/arm/plat-mxc/include/mach/mx35.h           |    2 -
 arch/arm/plat-mxc/include/mach/mxc.h            |   13 ++-
 27 files changed, 492 insertions(+), 50 deletions(-)
 create mode 100644 arch/arm/mach-mx5/cpu_op-mx51.c
 create mode 100644 arch/arm/mach-mx5/cpu_op-mx51.h
 create mode 100644 arch/arm/plat-mxc/cpufreq.c
 create mode 100644 arch/arm/plat-mxc/devices/platform-gpio_keys.c
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
