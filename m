From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 16 May 2012 12:50:17 +0200
Subject: i.MX common clock framework fixes
Message-ID: <1337165421-17118-1-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


The following patches fix a clk path in the i.MX5 clock code revealed
by the patch from Richard Zhao switching the timer clock from ipg
to peripheral clock. I amended the commit log from Richards patches
a bit, hence I am resending them here.

Sascha

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
