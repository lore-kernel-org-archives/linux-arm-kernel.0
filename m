From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Tue, 24 Oct 2017 19:06:16 +0200
Subject: [PATCH v2] clk: sunxi: fix build warning
Message-ID: <20171024170616.24889-1-clabbe.montjoie@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fix the following build warning:
drivers/clk/sunxi/clk-factors.c:279:14: warning: variable 'name' set but not used [-Wunused-but-set-variable]

Fixes: 4cbeaebb8af1 ("clk: sunxi: factors: Add unregister function")

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
Changes since v1:
- added Ack and fixes tags

 drivers/clk/sunxi/clk-factors.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/clk/sunxi/clk-factors.c b/drivers/clk/sunxi/clk-factors.c
index dfe5e3e32d28..856fef65433b 100644
--- a/drivers/clk/sunxi/clk-factors.c
+++ b/drivers/clk/sunxi/clk-factors.c
@@ -276,13 +276,11 @@ void sunxi_factors_unregister(struct device_node *node, struct clk *clk)
 {
 	struct clk_hw *hw = __clk_get_hw(clk);
 	struct clk_factors *factors;
-	const char *name;
 
 	if (!hw)
 		return;
 
 	factors = to_clk_factors(hw);
-	name = clk_hw_get_name(hw);
 
 	of_clk_del_provider(node);
 	/* TODO: The composite clock stuff will leak a bit here. */
-- 
2.13.6
