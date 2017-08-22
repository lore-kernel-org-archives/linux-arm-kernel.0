From: bhumirks@gmail.com (Bhumika Goyal)
Date: Tue, 22 Aug 2017 19:32:21 +0530
Subject: [PATCH] clk: sirf: make clk_ops const
Message-ID: <1503410541-25461-1-git-send-email-bhumirks@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make these const as they are only stored in the const field of a
clk_init_data structure.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
To compile-test clk-common.c, I compiled clk-atlas6.c and clk-prima2.c
as it gets included in these two files.

 drivers/clk/sirf/clk-common.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/sirf/clk-common.c b/drivers/clk/sirf/clk-common.c
index 77e1e24..f9ef6fa 100644
--- a/drivers/clk/sirf/clk-common.c
+++ b/drivers/clk/sirf/clk-common.c
@@ -184,7 +184,7 @@ static unsigned long cpu_clk_recalc_rate(struct clk_hw *hw,
 	return clk_hw_get_rate(parent_clk);
 }
 
-static struct clk_ops std_pll_ops = {
+static const struct clk_ops std_pll_ops = {
 	.recalc_rate = pll_clk_recalc_rate,
 	.round_rate = pll_clk_round_rate,
 	.set_rate = pll_clk_set_rate,
@@ -265,7 +265,7 @@ static unsigned long usb_pll_clk_recalc_rate(struct clk_hw *hw, unsigned long pa
 	return (reg & SIRFSOC_USBPHY_PLL_BYPASS) ? parent_rate : 48*MHZ;
 }
 
-static struct clk_ops usb_pll_ops = {
+static const struct clk_ops usb_pll_ops = {
 	.enable = usb_pll_clk_enable,
 	.disable = usb_pll_clk_disable,
 	.recalc_rate = usb_pll_clk_recalc_rate,
@@ -437,7 +437,7 @@ static int cpu_clk_set_rate(struct clk_hw *hw, unsigned long rate,
 	return ret2 ? ret2 : ret1;
 }
 
-static struct clk_ops msi_ops = {
+static const struct clk_ops msi_ops = {
 	.set_rate = dmn_clk_set_rate,
 	.round_rate = dmn_clk_round_rate,
 	.recalc_rate = dmn_clk_recalc_rate,
@@ -488,7 +488,7 @@ static int cpu_clk_set_rate(struct clk_hw *hw, unsigned long rate,
 	},
 };
 
-static struct clk_ops cpu_ops = {
+static const struct clk_ops cpu_ops = {
 	.set_parent = dmn_clk_set_parent,
 	.get_parent = dmn_clk_get_parent,
 	.set_rate = cpu_clk_set_rate,
@@ -511,7 +511,7 @@ static int cpu_clk_set_rate(struct clk_hw *hw, unsigned long rate,
 	},
 };
 
-static struct clk_ops dmn_ops = {
+static const struct clk_ops dmn_ops = {
 	.is_enabled = std_clk_is_enabled,
 	.enable = std_clk_enable,
 	.disable = std_clk_disable,
@@ -679,7 +679,7 @@ static void std_clk_disable(struct clk_hw *hw)
 	"io",
 };
 
-static struct clk_ops ios_ops = {
+static const struct clk_ops ios_ops = {
 	.is_enabled = std_clk_is_enabled,
 	.enable = std_clk_enable,
 	.disable = std_clk_disable,
-- 
1.9.1
