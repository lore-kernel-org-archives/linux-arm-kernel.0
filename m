From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Thu, 11 Jul 2013 14:32:10 +0530
Subject: [PATCH 2/6] clk: exynos4: Remove unused function
In-Reply-To: <1373533334-5169-1-git-send-email-sachin.kamat@linaro.org>
References: <1373533334-5169-1-git-send-email-sachin.kamat@linaro.org>
Message-ID: <1373533334-5169-3-git-send-email-sachin.kamat@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Subsequent to the cleanup in commit 3c70348c7c ("ARM: EXYNOS:
Remove legacy timer initialization code"), this function has no more
users. Hence remove it.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/clk/samsung/clk-exynos4.c |   14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos4.c b/drivers/clk/samsung/clk-exynos4.c
index 18eadc4..75635eb 100644
--- a/drivers/clk/samsung/clk-exynos4.c
+++ b/drivers/clk/samsung/clk-exynos4.c
@@ -969,20 +969,6 @@ static void __init exynos4_clk_register_finpll(unsigned long xom)
 
 }
 
-/*
- * This function allows non-dt platforms to specify the clock speed of the
- * xxti and xusbxti clocks. These clocks are then registered with the specified
- * clock speed.
- */
-void __init exynos4_clk_register_fixed_ext(unsigned long xxti_f,
-						  unsigned long xusbxti_f)
-{
-	exynos4_fixed_rate_ext_clks[0].fixed_rate = xxti_f;
-	exynos4_fixed_rate_ext_clks[1].fixed_rate = xusbxti_f;
-	samsung_clk_register_fixed_rate(exynos4_fixed_rate_ext_clks,
-			ARRAY_SIZE(exynos4_fixed_rate_ext_clks));
-}
-
 static __initdata struct of_device_id ext_clk_match[] = {
 	{ .compatible = "samsung,clock-xxti", .data = (void *)0, },
 	{ .compatible = "samsung,clock-xusbxti", .data = (void *)1, },
-- 
1.7.9.5
