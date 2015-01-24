From: wens@csie.org (Chen-Yu Tsai)
Date: Sat, 24 Jan 2015 16:42:39 +0800
Subject: [PATCH v2] clk: sunxi: fix sun6i PLL1 .recalc_rate() result
Message-ID: <1422088959-23365-1-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PLL1 on sun6i has its N factor start from 1 (N = register value + 1).
Make the factors clk driver aware of this so clk_factors_recalc_rate()
gives the correct result.

Cc: <stable@vger.kernel.org> # 3.12 9a5e6c7eb5cc clk: sunxi: Support factor
Cc: <stable@vger.kernel.org> # 3.12
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---

Somehow I remember doing this during the A23 bring-up, but never sent it,
and the patch was lost.

Changes in v2:

    Added better commit message.

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
