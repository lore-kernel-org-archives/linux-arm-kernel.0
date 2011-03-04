From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 4 Mar 2011 21:50:08 +0100
Subject: [PATCH 0/6] move mach-mx3/* to mach-imx
Message-ID: <20110304205008.GX22310@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

this series on top of Sascha's imx-for-2.6.39 branch gets rid of
mach-mx3.

It's compile tested on all in-tree mx_defconfigs + a mx25 build + a
mxc91231 build and run tested on a pcm037 machine (i.e. a i.MX31) that
is affected by the move.

Best regards
Uwe

The following changes since commit 4d2f13be1e370a670c1cae20c194d5ce961e0fa5:

  ARM: imx3x: clean up ARCH_MX3X (2011-03-03 13:17:15 +0100)

are available in the git repository at:
  git://git.pengutronix.de/git/ukl/linux-2.6.git imx-for-2.6.39

Uwe Kleine-K?nig (6):
      ARM: mxc91231: select MXC_AVIC
      ARM: mx3: dynamically allocate "mxc_rtc" devices
      ARM: mx3/pcm037: properly allocate memory for mx3-camera
      ARM: mx3/mx31moboard: properly allocate memory for mx3-camera
      [RFC] ARM: mx3: dynamically allocate "ipu-core" devices
      ARM: imx: move mx3 support to mach-imx

 arch/arm/Makefile                                  |    2 +-
 arch/arm/mach-imx/Kconfig                          |  269 ++++++++++++++++++++
 arch/arm/mach-imx/Makefile                         |   37 +++-
 arch/arm/mach-imx/Makefile.boot                    |    4 +
 arch/arm/mach-imx/cache-l2x0.c                     |   56 ++++
 arch/arm/{mach-mx3 => mach-imx}/clock-imx31.c      |    2 +-
 arch/arm/{mach-mx3 => mach-imx}/clock-imx35.c      |    0
 arch/arm/{mach-mx3/cpu.c => mach-imx/cpu-imx31.c}  |   38 +---
 arch/arm/mach-imx/cpu-imx35.c                      |   45 ++++
 .../crm_regs.h => mach-imx/crmregs-imx31.h}        |    0
 arch/arm/{mach-mx3 => mach-imx}/devices-imx31.h    |   12 +
 arch/arm/{mach-mx3 => mach-imx}/devices-imx35.h    |    8 +
 arch/arm/{mach-mx3 => mach-imx}/ehci-imx31.c       |    0
 arch/arm/{mach-mx3 => mach-imx}/ehci-imx35.c       |    0
 .../eukrea_mbimxsd35-baseboard.c}                  |   10 +-
 arch/arm/{mach-mx3 => mach-imx}/iomux-imx31.c      |    0
 .../arm/{mach-mx3 => mach-imx}/mach-armadillo5x0.c |   14 +-
 arch/arm/{mach-mx3 => mach-imx}/mach-bug.c         |    0
 arch/arm/{mach-mx3 => mach-imx}/mach-cpuimx35.c    |    1 -
 .../arm/{mach-mx3 => mach-imx}/mach-kzm_arm11_01.c |    1 -
 arch/arm/{mach-mx3 => mach-imx}/mach-mx31_3ds.c    |    1 -
 arch/arm/{mach-mx3 => mach-imx}/mach-mx31ads.c     |    1 -
 arch/arm/{mach-mx3 => mach-imx}/mach-mx31lilly.c   |    1 -
 arch/arm/{mach-mx3 => mach-imx}/mach-mx31lite.c    |    1 -
 arch/arm/{mach-mx3 => mach-imx}/mach-mx31moboard.c |   66 +++--
 arch/arm/{mach-mx3 => mach-imx}/mach-mx35_3ds.c    |    1 -
 arch/arm/{mach-mx3 => mach-imx}/mach-pcm037.c      |   65 +++---
 arch/arm/{mach-mx3 => mach-imx}/mach-pcm037_eet.c  |    1 -
 arch/arm/{mach-mx3 => mach-imx}/mach-pcm043.c      |   12 +-
 arch/arm/{mach-mx3 => mach-imx}/mach-qong.c        |    1 -
 arch/arm/{mach-mx3 => mach-imx}/mach-vpr200.c      |   12 +-
 arch/arm/mach-imx/mm-imx31.c                       |   66 +++++
 arch/arm/mach-imx/mm-imx35.c                       |   63 +++++
 arch/arm/{mach-mx3 => mach-imx}/mx31lilly-db.c     |    8 +-
 arch/arm/{mach-mx3 => mach-imx}/mx31lite-db.c      |    3 +-
 .../{mach-mx3 => mach-imx}/mx31moboard-devboard.c  |    1 -
 .../{mach-mx3 => mach-imx}/mx31moboard-marxbot.c   |    1 -
 .../{mach-mx3 => mach-imx}/mx31moboard-smartbot.c  |    1 -
 arch/arm/{mach-mx3 => mach-imx}/pcm037.h           |    0
 arch/arm/mach-mx3/Kconfig                          |  257 -------------------
 arch/arm/mach-mx3/Makefile                         |   26 --
 arch/arm/mach-mx3/Makefile.boot                    |    3 -
 arch/arm/mach-mx3/devices.c                        |  115 ---------
 arch/arm/mach-mx3/devices.h                        |    4 -
 arch/arm/mach-mx3/mm.c                             |  141 ----------
 arch/arm/plat-mxc/Kconfig                          |    2 +-
 arch/arm/plat-mxc/devices/Kconfig                  |    6 +
 arch/arm/plat-mxc/devices/Makefile                 |    2 +
 arch/arm/plat-mxc/devices/platform-ipu-core.c      |  129 ++++++++++
 arch/arm/plat-mxc/devices/platform-mxc_rtc.c       |   40 +++
 arch/arm/plat-mxc/include/mach/devices-common.h    |   27 ++
 51 files changed, 856 insertions(+), 700 deletions(-)
 create mode 100644 arch/arm/mach-imx/cache-l2x0.c
 rename arch/arm/{mach-mx3 => mach-imx}/clock-imx31.c (99%)
 rename arch/arm/{mach-mx3 => mach-imx}/clock-imx35.c (100%)
 rename arch/arm/{mach-mx3/cpu.c => mach-imx/cpu-imx31.c} (72%)
 create mode 100644 arch/arm/mach-imx/cpu-imx35.c
 rename arch/arm/{mach-mx3/crm_regs.h => mach-imx/crmregs-imx31.h} (100%)
 rename arch/arm/{mach-mx3 => mach-imx}/devices-imx31.h (86%)
 rename arch/arm/{mach-mx3 => mach-imx}/devices-imx35.h (90%)
 rename arch/arm/{mach-mx3 => mach-imx}/ehci-imx31.c (100%)
 rename arch/arm/{mach-mx3 => mach-imx}/ehci-imx35.c (100%)
 rename arch/arm/{mach-mx3/eukrea_mbimxsd-baseboard.c => mach-imx/eukrea_mbimxsd35-baseboard.c} (97%)
 rename arch/arm/{mach-mx3 => mach-imx}/iomux-imx31.c (100%)
 rename arch/arm/{mach-mx3 => mach-imx}/mach-armadillo5x0.c (97%)
 rename arch/arm/{mach-mx3 => mach-imx}/mach-bug.c (100%)
 rename arch/arm/{mach-mx3 => mach-imx}/mach-cpuimx35.c (99%)
 rename arch/arm/{mach-mx3 => mach-imx}/mach-kzm_arm11_01.c (99%)
 rename arch/arm/{mach-mx3 => mach-imx}/mach-mx31_3ds.c (99%)
 rename arch/arm/{mach-mx3 => mach-imx}/mach-mx31ads.c (99%)
 rename arch/arm/{mach-mx3 => mach-imx}/mach-mx31lilly.c (99%)
 rename arch/arm/{mach-mx3 => mach-imx}/mach-mx31lite.c (99%)
 rename arch/arm/{mach-mx3 => mach-imx}/mach-mx31moboard.c (93%)
 rename arch/arm/{mach-mx3 => mach-imx}/mach-mx35_3ds.c (99%)
 rename arch/arm/{mach-mx3 => mach-imx}/mach-pcm037.c (94%)
 rename arch/arm/{mach-mx3 => mach-imx}/mach-pcm037_eet.c (99%)
 rename arch/arm/{mach-mx3 => mach-imx}/mach-pcm043.c (97%)
 rename arch/arm/{mach-mx3 => mach-imx}/mach-qong.c (99%)
 rename arch/arm/{mach-mx3 => mach-imx}/mach-vpr200.c (96%)
 create mode 100644 arch/arm/mach-imx/mm-imx31.c
 create mode 100644 arch/arm/mach-imx/mm-imx35.c
 rename arch/arm/{mach-mx3 => mach-imx}/mx31lilly-db.c (96%)
 rename arch/arm/{mach-mx3 => mach-imx}/mx31lite-db.c (98%)
 rename arch/arm/{mach-mx3 => mach-imx}/mx31moboard-devboard.c (99%)
 rename arch/arm/{mach-mx3 => mach-imx}/mx31moboard-marxbot.c (99%)
 rename arch/arm/{mach-mx3 => mach-imx}/mx31moboard-smartbot.c (99%)
 rename arch/arm/{mach-mx3 => mach-imx}/pcm037.h (100%)
 delete mode 100644 arch/arm/mach-mx3/Kconfig
 delete mode 100644 arch/arm/mach-mx3/Makefile
 delete mode 100644 arch/arm/mach-mx3/Makefile.boot
 delete mode 100644 arch/arm/mach-mx3/devices.c
 delete mode 100644 arch/arm/mach-mx3/devices.h
 delete mode 100644 arch/arm/mach-mx3/mm.c
 create mode 100644 arch/arm/plat-mxc/devices/platform-ipu-core.c
 create mode 100644 arch/arm/plat-mxc/devices/platform-mxc_rtc.c
-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
