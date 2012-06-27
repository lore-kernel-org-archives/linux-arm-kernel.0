From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 27 Jun 2012 08:43:05 +0200
Subject: [GIT PULL] i.MX cpuidle changes for 3.6
Message-ID: <20120627064305.GE24458@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Arnd,

Please pull the following i.MX cpuidle changes for 3.6. One mege
conflict inside, but that's a trivial context change.

Sascha

The following changes since commit f8f5701bdaf9134b1f90e5044a82c66324d2073f:

  Linux 3.5-rc1 (2012-06-02 18:29:26 -0700)

are available in the git repository at:

  git://git.pengutronix.de/git/imx/linux-2.6.git imx/cpuidle

for you to fetch changes up to b9d18dc3a05d59894d60d5e173ebfb89a4b91bdf:

  ARM: imx: Add imx6q cpuidle driver (2012-06-05 08:53:33 +0200)

----------------------------------------------------------------
Robert Lee (7):
      ARM: imx: Modify IMX_IO_P2V macro
      ARM: imx: Add comments to tzic_enable_waker()
      ARM: imx: clean and consolidate imx5 suspend and idle code
      ARM: imx: Enable imx53 low power idle
      ARM: imx: Add common imx cpuidle init functionality.
      ARM: imx: Add imx5 cpuidle
      ARM: imx: Add imx6q cpuidle driver

 arch/arm/mach-imx/clk-imx51-imx53.c       |    2 +-
 arch/arm/mach-imx/imx53-dt.c              |    1 +
 arch/arm/mach-imx/mach-imx6q.c            |   19 +++++
 arch/arm/mach-imx/mach-mx53_ard.c         |    1 +
 arch/arm/mach-imx/mach-mx53_evk.c         |    1 +
 arch/arm/mach-imx/mach-mx53_loco.c        |    1 +
 arch/arm/mach-imx/mach-mx53_smd.c         |    1 +
 arch/arm/mach-imx/mm-imx5.c               |   26 ++-----
 arch/arm/mach-imx/pm-imx5.c               |  111 ++++++++++++++++++++++-------
 arch/arm/plat-mxc/Makefile                |    1 +
 arch/arm/plat-mxc/cpuidle.c               |   80 +++++++++++++++++++++
 arch/arm/plat-mxc/include/mach/common.h   |    6 +-
 arch/arm/plat-mxc/include/mach/cpuidle.h  |   22 ++++++
 arch/arm/plat-mxc/include/mach/hardware.h |   25 ++++---
 arch/arm/plat-mxc/tzic.c                  |    4 ++
 15 files changed, 242 insertions(+), 59 deletions(-)
 create mode 100644 arch/arm/plat-mxc/cpuidle.c
 create mode 100644 arch/arm/plat-mxc/include/mach/cpuidle.h
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
