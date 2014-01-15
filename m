From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Wed, 15 Jan 2014 15:31:09 +0530
Subject: [PATCH 1/2] clk: samsung: pll: Fix checkpatch errors
Message-ID: <1389780070-4959-1-git-send-email-sachin.kamat@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fixes the following type of checkpatch errors:
ERROR: return is not a function, parentheses are not required

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/clk/samsung/clk-pll.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/samsung/clk-pll.c b/drivers/clk/samsung/clk-pll.c
index 529e11dc2c6b..f2372fca0136 100644
--- a/drivers/clk/samsung/clk-pll.c
+++ b/drivers/clk/samsung/clk-pll.c
@@ -99,7 +99,7 @@ static inline bool samsung_pll35xx_mp_change(
 	old_mdiv = (pll_con >> PLL35XX_MDIV_SHIFT) & PLL35XX_MDIV_MASK;
 	old_pdiv = (pll_con >> PLL35XX_PDIV_SHIFT) & PLL35XX_PDIV_MASK;
 
-	return (rate->mdiv != old_mdiv || rate->pdiv != old_pdiv);
+	return rate->mdiv != old_mdiv || rate->pdiv != old_pdiv;
 }
 
 static int samsung_pll35xx_set_rate(struct clk_hw *hw, unsigned long drate,
@@ -207,8 +207,8 @@ static inline bool samsung_pll36xx_mpk_change(
 	old_pdiv = (pll_con0 >> PLL36XX_PDIV_SHIFT) & PLL36XX_PDIV_MASK;
 	old_kdiv = (pll_con1 >> PLL36XX_KDIV_SHIFT) & PLL36XX_KDIV_MASK;
 
-	return (rate->mdiv != old_mdiv || rate->pdiv != old_pdiv ||
-		rate->kdiv != old_kdiv);
+	return rate->mdiv != old_mdiv || rate->pdiv != old_pdiv ||
+		rate->kdiv != old_kdiv;
 }
 
 static int samsung_pll36xx_set_rate(struct clk_hw *hw, unsigned long drate,
@@ -320,8 +320,8 @@ static bool samsung_pll45xx_mp_change(u32 pll_con0, u32 pll_con1,
 	old_pdiv = (pll_con0 >> PLL45XX_PDIV_SHIFT) & PLL45XX_PDIV_MASK;
 	old_afc = (pll_con1 >> PLL45XX_AFC_SHIFT) & PLL45XX_AFC_MASK;
 
-	return (old_mdiv != rate->mdiv || old_pdiv != rate->pdiv
-		|| old_afc != rate->afc);
+	return old_mdiv != rate->mdiv || old_pdiv != rate->pdiv
+		|| old_afc != rate->afc;
 }
 
 static int samsung_pll45xx_set_rate(struct clk_hw *hw, unsigned long drate,
@@ -467,8 +467,8 @@ static bool samsung_pll46xx_mpk_change(u32 pll_con0, u32 pll_con1,
 	old_pdiv = (pll_con0 >> PLL46XX_PDIV_SHIFT) & PLL46XX_PDIV_MASK;
 	old_kdiv = (pll_con1 >> PLL46XX_KDIV_SHIFT) & PLL46XX_KDIV_MASK;
 
-	return (old_mdiv != rate->mdiv || old_pdiv != rate->pdiv
-		|| old_kdiv != rate->kdiv);
+	return old_mdiv != rate->mdiv || old_pdiv != rate->pdiv
+		|| old_kdiv != rate->kdiv;
 }
 
 static int samsung_pll46xx_set_rate(struct clk_hw *hw, unsigned long drate,
-- 
1.7.9.5
