From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue,  2 Feb 2016 09:47:09 +0100
Subject: [PATCH 0/5] clk: sunxi: Rework the clocks code to deal with orphans
Message-ID: <1454402834-6385-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

Here is an attempt at making the whole clk-sunxi code register the
clocks without creating any orphans by relying on CLK_OF_DECLARE.

This also has the net benefit of not having to add the SoC compatible
to the list of compatibles that trigger the clock registration, which
has started to be a pain.

I tested this on an A13 (R8 actually), everything seems to be working
just fine. I also tested it both with and without Heiko's patch to
defer clk_get if the clock is orphan, and previously broke everything.

Let me know what you think,
Maxime

Maxime Ripard (5):
  clk: sunxi: Make clocks setup functions return their clock
  clk: sunxi: Make clocks setup functions take const pointer
  clk: sunxi: convert current clocks registration to CLK_OF_DECLARE
  clk: sunxi: Remove old probe and protection code
  clk: sunxi: Remove clk_register_clkdev calls

 drivers/clk/sunxi/clk-a10-hosc.c         |   3 +-
 drivers/clk/sunxi/clk-a20-gmac.c         |   2 -
 drivers/clk/sunxi/clk-factors.c          |   7 -
 drivers/clk/sunxi/clk-factors.h          |   1 -
 drivers/clk/sunxi/clk-mod0.c             |   1 +
 drivers/clk/sunxi/clk-sun6i-apb0-gates.c |   2 -
 drivers/clk/sunxi/clk-sun9i-core.c       |   1 +
 drivers/clk/sunxi/clk-sunxi.c            | 263 ++++++++++++++++---------------
 8 files changed, 135 insertions(+), 145 deletions(-)

-- 
2.6.4
