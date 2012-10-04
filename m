From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu,  4 Oct 2012 15:19:08 +0530
Subject: [PATCH] clk: SPEAr: Vco-pll: Fix compilation warning
Message-ID: <670019c51d5205a7ae85ada48986303e691faa9c.1349343959.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently we are getting following warning for SPEAr clk-vco-pll.

"warning: i is used uninitialized in this function."

This is because we are getting value of i by passing its pointer to another
routine.

The variables here are really not used uninitialized.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---

Andrew,

I know this must have gone through Mike Turquette. But he is not around for a
week. As, this is a pretty small change, can you take it upstream?

drivers/clk/spear/clk-vco-pll.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/spear/clk-vco-pll.c b/drivers/clk/spear/clk-vco-pll.c
index 5f1b6ba..1b9b65b 100644
--- a/drivers/clk/spear/clk-vco-pll.c
+++ b/drivers/clk/spear/clk-vco-pll.c
@@ -147,7 +147,7 @@ static int clk_pll_set_rate(struct clk_hw *hw, unsigned long drate,
 	struct clk_pll *pll = to_clk_pll(hw);
 	struct pll_rate_tbl *rtbl = pll->vco->rtbl;
 	unsigned long flags = 0, val;
-	int i;
+	int uninitialized_var(i);
 
 	clk_pll_round_rate_index(hw, drate, NULL, &i);
 
-- 
1.7.12.rc2.18.g61b472e
