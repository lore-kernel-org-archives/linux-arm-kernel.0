From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 17 Jun 2014 22:52:43 +0800
Subject: [PATCH v2 06/20] clk: sunxi: Fix rate_recalc for sun6i PLL1
In-Reply-To: <1403016777-15121-1-git-send-email-wens@csie.org>
References: <1403016777-15121-1-git-send-email-wens@csie.org>
Message-ID: <1403016777-15121-7-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PLL1 on sun6i is a factor clock with the N multiplier factor starting
from 1. Set the .n_from_one field in the clock data to match.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/clk/sunxi/clk-sunxi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
index a38c799..dc2176f 100644
--- a/drivers/clk/sunxi/clk-sunxi.c
+++ b/drivers/clk/sunxi/clk-sunxi.c
@@ -420,6 +420,7 @@ static struct clk_factors_config sun6i_a31_pll1_config = {
 	.kwidth = 2,
 	.mshift = 0,
 	.mwidth = 2,
+	.n_from_one = 1,
 };
 
 static struct clk_factors_config sun4i_pll5_config = {
-- 
2.0.0
