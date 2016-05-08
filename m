From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Sun,  8 May 2016 11:24:56 +0200
Subject: [PATCH] clk: samsung: exynos5420: Remove useless check for return
 value of samsung_clk_init
Message-ID: <1462699496-16646-1-git-send-email-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The samsung_clk_init() cannot return NULL. Either it returns allocated
memory or it panics.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/clk/samsung/clk-exynos5420.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
index 92382cef9f90..770c0f007c6b 100644
--- a/drivers/clk/samsung/clk-exynos5420.c
+++ b/drivers/clk/samsung/clk-exynos5420.c
@@ -1356,8 +1356,6 @@ static void __init exynos5x_clk_init(struct device_node *np,
 	exynos5x_soc = soc;
 
 	ctx = samsung_clk_init(np, reg_base, CLK_NR_CLKS);
-	if (!ctx)
-		panic("%s: unable to allocate context.\n", __func__);
 
 	samsung_clk_of_register_fixed_ext(ctx, exynos5x_fixed_rate_ext_clks,
 			ARRAY_SIZE(exynos5x_fixed_rate_ext_clks),
-- 
2.5.0
