From: bhumirks@gmail.com (Bhumika Goyal)
Date: Tue, 22 Aug 2017 18:48:29 +0530
Subject: [PATCH] clk: imx: make clk_ops const
Message-ID: <1503407909-15469-1-git-send-email-bhumirks@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make these const as they are only stored in the const field of a
clk_init_data structure.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 drivers/clk/imx/clk-busy.c  | 4 ++--
 drivers/clk/imx/clk-gate2.c | 2 +-
 drivers/clk/imx/clk-pllv1.c | 2 +-
 drivers/clk/imx/clk-pllv2.c | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/imx/clk-busy.c b/drivers/clk/imx/clk-busy.c
index 5cc9959..6df3389 100644
--- a/drivers/clk/imx/clk-busy.c
+++ b/drivers/clk/imx/clk-busy.c
@@ -72,7 +72,7 @@ static int clk_busy_divider_set_rate(struct clk_hw *hw, unsigned long rate,
 	return ret;
 }
 
-static struct clk_ops clk_busy_divider_ops = {
+static const struct clk_ops clk_busy_divider_ops = {
 	.recalc_rate = clk_busy_divider_recalc_rate,
 	.round_rate = clk_busy_divider_round_rate,
 	.set_rate = clk_busy_divider_set_rate,
@@ -147,7 +147,7 @@ static int clk_busy_mux_set_parent(struct clk_hw *hw, u8 index)
 	return ret;
 }
 
-static struct clk_ops clk_busy_mux_ops = {
+static const struct clk_ops clk_busy_mux_ops = {
 	.get_parent = clk_busy_mux_get_parent,
 	.set_parent = clk_busy_mux_set_parent,
 };
diff --git a/drivers/clk/imx/clk-gate2.c b/drivers/clk/imx/clk-gate2.c
index db44a19..60fc9d7 100644
--- a/drivers/clk/imx/clk-gate2.c
+++ b/drivers/clk/imx/clk-gate2.c
@@ -118,7 +118,7 @@ static void clk_gate2_disable_unused(struct clk_hw *hw)
 	spin_unlock_irqrestore(gate->lock, flags);
 }
 
-static struct clk_ops clk_gate2_ops = {
+static const struct clk_ops clk_gate2_ops = {
 	.enable = clk_gate2_enable,
 	.disable = clk_gate2_disable,
 	.disable_unused = clk_gate2_disable_unused,
diff --git a/drivers/clk/imx/clk-pllv1.c b/drivers/clk/imx/clk-pllv1.c
index 82fe366..703818e 100644
--- a/drivers/clk/imx/clk-pllv1.c
+++ b/drivers/clk/imx/clk-pllv1.c
@@ -106,7 +106,7 @@ static unsigned long clk_pllv1_recalc_rate(struct clk_hw *hw,
 	return ull;
 }
 
-static struct clk_ops clk_pllv1_ops = {
+static const struct clk_ops clk_pllv1_ops = {
 	.recalc_rate = clk_pllv1_recalc_rate,
 };
 
diff --git a/drivers/clk/imx/clk-pllv2.c b/drivers/clk/imx/clk-pllv2.c
index 4aeda56..c845b8c 100644
--- a/drivers/clk/imx/clk-pllv2.c
+++ b/drivers/clk/imx/clk-pllv2.c
@@ -226,7 +226,7 @@ static void clk_pllv2_unprepare(struct clk_hw *hw)
 	__raw_writel(reg, pllbase + MXC_PLL_DP_CTL);
 }
 
-static struct clk_ops clk_pllv2_ops = {
+static const struct clk_ops clk_pllv2_ops = {
 	.prepare = clk_pllv2_prepare,
 	.unprepare = clk_pllv2_unprepare,
 	.recalc_rate = clk_pllv2_recalc_rate,
-- 
1.9.1
