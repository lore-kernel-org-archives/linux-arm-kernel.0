From: wens@csie.org (Chen-Yu Tsai)
Date: Sat, 24 Jan 2015 16:36:50 +0800
Subject: [PATCH] clk: sunxi: fix sun6i PLL1 recalc result
Message-ID: <1422088610-23107-1-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc: <stable@vger.kernel.org> # 3.12 9a5e6c7eb5cc clk: sunxi: Support factor
Cc: <stable@vger.kernel.org> # 3.12
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/clk/sunxi/clk-sunxi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
index 24c7cc12e9e1..699458e0f9b2 100644
--- a/drivers/clk/sunxi/clk-sunxi.c
+++ b/drivers/clk/sunxi/clk-sunxi.c
@@ -584,6 +584,7 @@ static struct clk_factors_config sun6i_a31_pll1_config = {
 	.kwidth = 2,
 	.mshift = 0,
 	.mwidth = 2,
+	.n_start = 1,
 };
 
 static struct clk_factors_config sun8i_a23_pll1_config = {
-- 
2.1.4
