From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 24 Feb 2011 22:03:53 +0100
Subject: [PATCH 0/5] my imx patches for 2.6.39
In-Reply-To: <20110218213022.GJ22310@pengutronix.de>
References: <20110218213022.GJ22310@pengutronix.de>
Message-ID: <20110224210353.GA22310@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Sascha,

there is now yet another patch, and as you didn't pull yet (maybe you
expected that?) here comes an updated request:

The following changes since commit b807afe41ceefef11a0d965cd9970142afc53d25:

  ARM: imx50: correct iomux-mx50.h wrong daisy chain settings (2011-02-18 11:01:34 +0100)

are available in the git repository at:
  git://git.pengutronix.de/git/ukl/linux-2.6.git imx-for-2.6.39

Lothar Wa?mann (3):
      ARM: mxs: free dma_mask in error path
      ARM: mxs: add a dma mask to fec devices
      ARM: mxs: Initial support for Ka-Ro TX28

Sascha Hauer (2):
      ARM: mxs: Add pwm clocks and device registration
      ARM: mxs: Add missing EXPORT_SYMBOL for mxs_reset_block

Uwe Kleine-K?nig (3):
      ARM: mxc: free dma_mask in error path
      ARM: mxc: add a dma mask to fec devices
      ARM: mx51_defconfig: enable various options

 arch/arm/configs/mx51_defconfig                 |   53 ++++++--
 arch/arm/mach-mxs/Kconfig                       |   14 ++
 arch/arm/mach-mxs/Makefile                      |    2 +
 arch/arm/mach-mxs/clock-mx23.c                  |    6 +-
 arch/arm/mach-mxs/clock-mx28.c                  |    9 +-
 arch/arm/mach-mxs/devices-mx23.h                |    2 +
 arch/arm/mach-mxs/devices-mx28.h                |    2 +
 arch/arm/mach-mxs/devices.c                     |    2 +
 arch/arm/mach-mxs/devices/Kconfig               |    3 +
 arch/arm/mach-mxs/devices/Makefile              |    1 +
 arch/arm/mach-mxs/devices/platform-fec.c        |    5 +-
 arch/arm/mach-mxs/devices/platform-mxs-pwm.c    |   22 +++
 arch/arm/mach-mxs/include/mach/devices-common.h |    4 +
 arch/arm/mach-mxs/include/mach/mxs.h            |    9 +-
 arch/arm/mach-mxs/include/mach/uncompress.h     |    1 +
 arch/arm/mach-mxs/mach-tx28.c                   |  175 +++++++++++++++++++++++
 arch/arm/mach-mxs/module-tx28.c                 |  131 +++++++++++++++++
 arch/arm/mach-mxs/module-tx28.h                 |    9 ++
 arch/arm/mach-mxs/system.c                      |    2 +
 arch/arm/plat-mxc/devices.c                     |    2 +
 arch/arm/plat-mxc/devices/platform-fec.c        |    4 +-
 21 files changed, 441 insertions(+), 17 deletions(-)
 create mode 100644 arch/arm/mach-mxs/devices/platform-mxs-pwm.c
 create mode 100644 arch/arm/mach-mxs/mach-tx28.c
 create mode 100644 arch/arm/mach-mxs/module-tx28.c
 create mode 100644 arch/arm/mach-mxs/module-tx28.h

Thanks
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
