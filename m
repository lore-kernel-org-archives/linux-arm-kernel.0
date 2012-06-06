From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 6 Jun 2012 14:08:57 +0200
Subject: [PATCH 0/2] A couple of imx6q clock patches
In-Reply-To: <CAAQ0ZWSKFtWcrLuRCSqNXokAqmijJpyd4P_MbhKDfimH4aHCyg@mail.gmail.com>
References: <1338880603-24333-1-git-send-email-shawn.guo@linaro.org>
 <20120606101642.GX30400@pengutronix.de>
 <CAAQ0ZWSKFtWcrLuRCSqNXokAqmijJpyd4P_MbhKDfimH4aHCyg@mail.gmail.com>
Message-ID: <20120606120857.GY30400@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 06, 2012 at 07:32:04PM +0800, Shawn Guo wrote:
> On 6 June 2012 18:16, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> > Olof, what do you prefer? Is there still time to update the
> > imx-clk-common-fixes you already pulled?
> >
> Oh, I do not know Olof has already pulled imx-clk-common-fixes.  In
> that case, I can prepare another -rc fixing request for Olof to pull.

How about the following, it contains your patches plus the ones I sent
yesterday, based on imx-clk-common. It should contain all currently
pending imx clk fixes.

The following changes since commit
f8f5701bdaf9134b1f90e5044a82c66324d2073f:

  Linux 3.5-rc1 (2012-06-02 18:29:26 -0700)

are available in the git repository at:

  git://git.pengutronix.de/git/imx/linux-2.6.git imx/clk-fixes

for you to fetch changes up to 1173d5ce7fce0fcb1055412288499a4a58b428ef:

  ARM: imx6q: fix suspend regression caused by common clk migration
(2012-06-06 12:17:34 +0200)

----------------------------------------------------------------
Alex Gershgorin (1):
      ARM: i.MX35: Implement camera and keypad clocks

Richard Zhao (2):
      ARM: i.MX: change timer clock from ipg to perclk
      ARM: imx6q: prepare and enable init on clks directly instead of clk_get first

Sascha Hauer (6):
      ARM i.MX5: fix gpt peripheral clock path
      ARM i.MX: remove now unnecessary argument from mxc_timer_init
      ARM i.MX pllv2: use standard register set unconditionally
      ARM i.MX pllv2: make round_rate accurate
      ARM i.MX53: Fix PLL4 base address
      Merge tag 'imx-clk-common-fixes' into imx/imx/clk-fixes

Shawn Guo (2):
      ARM: imx6q: remove unneeded clkdev lookups
      ARM: imx6q: fix suspend regression caused by common clk migration

 arch/arm/mach-imx/clk-imx1.c            |    3 +--
 arch/arm/mach-imx/clk-imx21.c           |    4 +--
 arch/arm/mach-imx/clk-imx25.c           |    2 +-
 arch/arm/mach-imx/clk-imx27.c           |    3 +--
 arch/arm/mach-imx/clk-imx31.c           |    3 +--
 arch/arm/mach-imx/clk-imx35.c           |   17 +++++++-----
 arch/arm/mach-imx/clk-imx51-imx53.c     |   12 ++++-----
 arch/arm/mach-imx/clk-imx6q.c           |   29 +++++++-------------
 arch/arm/mach-imx/clk-pllv2.c           |   93 +++++++++++++++++++++++++++++++++++++--------------------------
 arch/arm/mach-imx/crm-regs-imx5.h       |    2 +-
 arch/arm/plat-mxc/epit.c                |   11 +++++++-
 arch/arm/plat-mxc/include/mach/common.h |    4 +--
 arch/arm/plat-mxc/time.c                |   24 ++++++++---------
 13 files changed, 111 insertions(+), 96 deletions(-)


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
