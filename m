From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 1 Feb 2012 16:54:04 +0100
Subject: [GIT PULL] cs89x0 platform support
In-Reply-To: <20120201150909.GB2203@S2101-09.ap.freescale.net>
References: <20120201134415.GU1990@pengutronix.de>
 <20120201150909.GB2203@S2101-09.ap.freescale.net>
Message-ID: <20120201155404.GW1990@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 01, 2012 at 11:09:13PM +0800, Shawn Guo wrote:
> On Wed, Feb 01, 2012 at 02:44:15PM +0100, Sascha Hauer wrote:
> > Hi Olof,
> > 
> > Please pull the following for next. It contains cs89x0 platform
> > support. David has acked the base patch and is fine with this
> > patch going via the Arm tree.
> > 
> > Sascha
> > 
> > The following changes since commit dcd6c92267155e70a94b3927bce681ce74b80d1f:
> > 
> >   Linux 3.3-rc1 (2012-01-19 15:04:48 -0800)
> > 
> > are available in the git repository at:
> >   git://git.pengutronix.de/git/imx/linux-2.6.git features/cs89x0
> > 
> > Jaccon Bastiaansen (4):
> >       CS89x0 : add platform driver support
> >       CS89x0 : add CS89x0 platform device to the iMX21ADS board
> >       CS89x0 : remove QQ2440 board support from the CS89x0 driver
> >       CS89x0 : add CS89x0 platform device to the iMX31ADS board
> > 
> >  arch/arm/configs/imx_v4_v5_defconfig           |    2 +
> >  arch/arm/configs/mx3_defconfig                 |    2 +
> 
> The mx3_defconfig has been deleted from mainline.  We may need to
> rebase the series to 3.3-rc2.  Otherwise, we will eventually have
> conflict?

Oops, yes. Just did that.

Sascha

The following changes since commit 62aa2b537c6f5957afd98e29f96897419ed5ebab:

  Linux 3.3-rc2 (2012-01-31 13:31:54 -0800)

are available in the git repository at:
  git://git.pengutronix.de/git/imx/linux-2.6.git features/cs89x0

Jaccon Bastiaansen (4):
      CS89x0 : add platform driver support
      CS89x0 : add CS89x0 platform device to the iMX21ADS board
      CS89x0 : remove QQ2440 board support from the CS89x0 driver
      CS89x0 : add CS89x0 platform device to the iMX31ADS board

 arch/arm/configs/imx_v4_v5_defconfig           |    2 +
 arch/arm/configs/imx_v6_v7_defconfig           |    4 +-
 arch/arm/mach-imx/mach-mx21ads.c               |   16 +++-
 arch/arm/mach-imx/mach-mx31ads.c               |   35 +++++-
 arch/arm/plat-mxc/include/mach/board-mx31ads.h |   33 ------
 drivers/net/Space.c                            |    2 +
 drivers/net/ethernet/cirrus/Kconfig            |   19 ++--
 drivers/net/ethernet/cirrus/cs89x0.c           |  148 +++++++++++++++++++----
 8 files changed, 186 insertions(+), 73 deletions(-)
 delete mode 100644 arch/arm/plat-mxc/include/mach/board-mx31ads.h


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
