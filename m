From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 28 Jan 2016 20:22:37 +0100
Subject: [PATCH v3 1/2] clk: sunxi: factors: Add missing recalc pointer copy
Message-ID: <1454008958-12655-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 4a9b2abc213e ("clk: sunxi: factors: Support custom formulas") was
introducing a custom recalc function. However, the pointer was never
filled, which was making the whole thing unused.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/clk/sunxi/clk-factors.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/sunxi/clk-factors.c b/drivers/clk/sunxi/clk-factors.c
index e480a6bcf1f6..6e97f46c0c37 100644
--- a/drivers/clk/sunxi/clk-factors.c
+++ b/drivers/clk/sunxi/clk-factors.c
@@ -212,6 +212,7 @@ struct clk *sunxi_factors_register(struct device_node *node,
 	factors->reg = reg;
 	factors->config = data->table;
 	factors->get_factors = data->getter;
+	factors->recalc = data->recalc;
 	factors->lock = lock;
 
 	/* Add a gate if this factor clock can be gated */
-- 
2.6.4
