From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 17 May 2012 11:41:21 +0200
Subject: [GIT PULL] i.MX common clock fixes
Message-ID: <20120517094121.GY30400@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Please pull the following fixes to the i.MX common clock conversion
based on the imx/clock branch in arm-soc.

Thanks
 Sascha

The following changes since commit 4f5a9fd341e8ffd825ecf56155df6fe6c3d732b1:

  Merge branch 'imx/pinctrl' into imx/clock (2012-05-14 15:30:52 +0200)

are available in the git repository at:


  git://git.pengutronix.de/git/imx/linux-2.6.git tags/imx-clk-common-fixes

for you to fetch changes up to b0286f20c36d0c1e7537489daddaf574abf403dd:

  ARM: imx6q: prepare and enable init on clks directly instead of clk_get first (2012-05-16 12:46:23 +0200)

----------------------------------------------------------------
Some fixes for the fresh i.MX common clock support

----------------------------------------------------------------
Richard Zhao (2):
      ARM: i.MX: change timer clock from ipg to perclk
      ARM: imx6q: prepare and enable init on clks directly instead of clk_get first

Sascha Hauer (2):
      ARM i.MX5: fix gpt peripheral clock path
      ARM i.MX: remove now unnecessary argument from mxc_timer_init

 arch/arm/mach-imx/clk-imx1.c            |    3 +--
 arch/arm/mach-imx/clk-imx21.c           |    4 ++--
 arch/arm/mach-imx/clk-imx25.c           |    2 +-
 arch/arm/mach-imx/clk-imx27.c           |    3 +--
 arch/arm/mach-imx/clk-imx31.c           |    3 +--
 arch/arm/mach-imx/clk-imx35.c           |    6 ++----
 arch/arm/mach-imx/clk-imx51-imx53.c     |   12 +++++-------
 arch/arm/mach-imx/clk-imx6q.c           |   22 +++++++---------------
 arch/arm/plat-mxc/epit.c                |   11 ++++++++++-
 arch/arm/plat-mxc/include/mach/common.h |    4 ++--
 arch/arm/plat-mxc/time.c                |   24 ++++++++++++------------
 11 files changed, 44 insertions(+), 50 deletions(-)
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
