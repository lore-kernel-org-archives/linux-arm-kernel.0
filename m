From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 1 Aug 2011 11:37:59 +0200
Subject: [PATCH 0/8] ARM: getting rid of mx5/devices.c and mxc_register_device
Message-ID: <20110801093759.GD9250@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

this series is based on current Linus' master as there is no post-3.0
tag yet.

The first patch was already sent, but as this series either conflicts
with it or needs it, so I added it here, too.

Note that building the branch below currently fails for mx51_defconfig,
because Shawn's build fix for drivers/usb/host/ehci-mxc.c [1] is still
missing.

See below for diffstat and shortlog.

Best regards
Uwe

[1] http://mid.gmane.org/1311258250-22013-1-git-send-email-shawn.guo at linaro.org

The following changes since commit 3da3f872aa175f59e20766ed30aaea67fd4fa7d1:

  Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/sameo/mfd-2.6 (2011-07-31 14:31:44 -1000)

are available in the git repository at:

  git://git.pengutronix.de/git/ukl/linux-2.6.git imx-cleanup

Uwe Kleine-K?nig (8):
      ARM: mx5: fix remaining unconsistent names for irqs
      ARM: mx5: remove unused #includes of devices.h
      ARM: mx5: dynamically allocate mxc-ehci devices
      ARM: mx5: dynamically allocate fsl-usb2-udc devices
      ARM: mx5: dynamically allocate high speed i2c (imx-i2c actually)
      ARM: imx/mx1ads: dynamically allocate physmap-flash device
      ARM: imx/armadillo5x0: dynamically allocate physmap-flash device
      ARM: mxc: drop now unused function mxc_register_device

 arch/arm/mach-imx/mach-armadillo5x0.c             |   18 +--
 arch/arm/mach-imx/mach-mx1ads.c                   |   15 +--
 arch/arm/mach-mx5/Kconfig                         |    9 +-
 arch/arm/mach-mx5/Makefile                        |    2 +-
 arch/arm/mach-mx5/board-cpuimx51.c                |   17 +-
 arch/arm/mach-mx5/board-cpuimx51sd.c              |   17 +-
 arch/arm/mach-mx5/board-mx51_3ds.c                |    1 -
 arch/arm/mach-mx5/board-mx51_babbage.c            |   21 ++--
 arch/arm/mach-mx5/board-mx51_efikamx.c            |    1 -
 arch/arm/mach-mx5/board-mx51_efikasb.c            |    5 +-
 arch/arm/mach-mx5/clock-mx51-mx53.c               |    2 +-
 arch/arm/mach-mx5/devices-imx51.h                 |   13 ++
 arch/arm/mach-mx5/devices.c                       |  120 ---------------
 arch/arm/mach-mx5/devices.h                       |    5 -
 arch/arm/mach-mx5/ehci.c                          |    2 +-
 arch/arm/mach-mx5/eukrea_mbimx51-baseboard.c      |    1 -
 arch/arm/mach-mx5/eukrea_mbimxsd-baseboard.c      |    1 -
 arch/arm/mach-mx5/mm.c                            |    8 +-
 arch/arm/mach-mx5/mx51_efika.c                    |   14 +-
 arch/arm/plat-mxc/devices.c                       |   14 --
 arch/arm/plat-mxc/devices/platform-fsl-usb2-udc.c |    5 +
 arch/arm/plat-mxc/devices/platform-imx-i2c.c      |    6 +
 arch/arm/plat-mxc/devices/platform-mxc-ehci.c     |    9 +
 arch/arm/plat-mxc/include/mach/common.h           |    1 -
 arch/arm/plat-mxc/include/mach/mx51.h             |  167 +++++++++++----------
 25 files changed, 179 insertions(+), 295 deletions(-)
 delete mode 100644 arch/arm/mach-mx5/devices.c
 delete mode 100644 arch/arm/mach-mx5/devices.h

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
