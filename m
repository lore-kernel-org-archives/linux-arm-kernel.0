From: Barry.Song@csr.com (Barry Song)
Date: Wed, 4 Jul 2012 17:54:40 +0800
Subject: [PATCH] clk: wm831x: fix checkpatch issue for static const char *
 array
Message-ID: <1341395680-14142-1-git-send-email-Barry.Song@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Barry Song <Baohua.Song@csr.com>

static const char * array should probably be static const char * const

Signed-off-by: Barry Song <Baohua.Song@csr.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 drivers/clk/clk-wm831x.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clk-wm831x.c b/drivers/clk/clk-wm831x.c
index e7b7765..f601e61 100644
--- a/drivers/clk/clk-wm831x.c
+++ b/drivers/clk/clk-wm831x.c
@@ -177,7 +177,7 @@ static int wm831x_fll_set_rate(struct clk_hw *hw, unsigned long rate,
 			       WM831X_FLL_AUTO_FREQ_MASK, i);
 }
 
-static const char *wm831x_fll_parents[] = {
+static const char * const wm831x_fll_parents[] = {
 	"xtal",
 	"clkin",
 };
@@ -298,7 +298,7 @@ static void wm831x_clkout_unprepare(struct clk_hw *hw)
 	wm831x_reg_lock(wm831x);
 }
 
-static const char *wm831x_clkout_parents[] = {
+static const char * const wm831x_clkout_parents[] = {
 	"xtal",
 	"fll",
 };
-- 
1.7.1



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog
