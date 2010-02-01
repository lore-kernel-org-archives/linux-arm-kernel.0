From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 1 Feb 2010 16:56:25 +0100
Subject: my imx changes for 2.6.34
Message-ID: <20100201155625.GA22413@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I have made a few more patches based on Sascha's mxc-master branch for
2.6.34.

As usual I'll send them as reply to this mail and they are available via
git.  Diffstat and shortlog are below.

Best regards
Uwe

The following changes since commit 1eaa4f2762899d2f3c54ba7a4fee564e255ad0a5:
  Baruch Siach (1):
        mx25pdk: platform code for the DryIce RTC module

are available in the git repository at:

  git://git.pengutronix.de/git/ukl/linux-2.6.git imx/master

Uwe Kleine-K?nig (8):
      mx1: prefix SOC specific defines with MX1_ and deprecate old names
      mx25: deprecate UART1_BASE_ADDR and UART2_BASE_ADDR
      imx: BUG in clk_disable if the clock isn't enabled
      mxc91231: use MXC91231_IO_ADDRESS instead of MXC91231_AIPS1_IO_ADDRESS
      mxc91231: redefine MXC91231_IO_ADDRESS using IMX_IO_ADDRESS
      imx2x: convert serial.c to use soc-prefixed constants
      imx: define per SOC ..._PHYS_OFFSET and use these in favour of PHYS_OFFSET
      imx/mx25: rename files defining a machine to mach-$mach.c

 arch/arm/mach-mx1/Makefile                       |    1 +
 arch/arm/mach-mx1/mach-mx1ads.c                  |    4 +-
 arch/arm/mach-mx2/Makefile                       |    1 -
 arch/arm/mach-mx2/mach-cpuimx27.c                |    2 +-
 arch/arm/mach-mx2/mach-imx27lite.c               |    2 +-
 arch/arm/mach-mx2/mach-mx21ads.c                 |    2 +-
 arch/arm/mach-mx2/mach-mx27_3ds.c                |    2 +-
 arch/arm/mach-mx2/mach-mx27ads.c                 |    2 +-
 arch/arm/mach-mx2/mach-mxt_td60.c                |    2 +-
 arch/arm/mach-mx2/mach-pca100.c                  |    2 +-
 arch/arm/mach-mx2/mach-pcm038.c                  |    2 +-
 arch/arm/mach-mx2/serial.c                       |   48 ++--
 arch/arm/mach-mx25/Makefile                      |    2 +-
 arch/arm/mach-mx25/{mx25pdk.c => mach-mx25pdk.c} |    2 +-
 arch/arm/mach-mx3/mach-armadillo5x0.c            |    2 +-
 arch/arm/mach-mx3/mach-kzm_arm11_01.c            |    2 +-
 arch/arm/mach-mx3/mach-mx31_3ds.c                |    2 +-
 arch/arm/mach-mx3/mach-mx31ads.c                 |    2 +-
 arch/arm/mach-mx3/mach-mx31lilly.c               |    2 +-
 arch/arm/mach-mx3/mach-mx31lite.c                |    2 +-
 arch/arm/mach-mx3/mach-mx31moboard.c             |    2 +-
 arch/arm/mach-mx3/mach-mx35pdk.c                 |    2 +-
 arch/arm/mach-mx3/mach-pcm037.c                  |    2 +-
 arch/arm/mach-mx3/mach-pcm043.c                  |    2 +-
 arch/arm/mach-mx3/mach-qong.c                    |    2 +-
 arch/arm/mach-mxc91231/magx-zn5.c                |    2 +-
 arch/arm/plat-mxc/clock.c                        |    1 +
 arch/arm/plat-mxc/include/mach/debug-macro.S     |    2 +-
 arch/arm/plat-mxc/include/mach/memory.h          |   36 ++-
 arch/arm/plat-mxc/include/mach/mx1.h             |  387 +++++++++++++++-------
 arch/arm/plat-mxc/include/mach/mx25.h            |    9 +-
 arch/arm/plat-mxc/include/mach/mxc91231.h        |   58 +---
 32 files changed, 349 insertions(+), 242 deletions(-)
 rename arch/arm/mach-mx25/{mx25pdk.c => mach-mx25pdk.c} (98%)

-- 
Pengutronix e.K.                              | Uwe Kleine-K?nig            |
Industrial Linux Solutions                    | http://www.pengutronix.de/  |
