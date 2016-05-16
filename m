From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 16 May 2016 10:26:47 +0200
Subject: [PATCH 1/2] clk: samsung: clkout: Add support for Exynos5410
Message-ID: <1463387208-9277-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add compatible for Exynos5410 so the PMU on this SoC would provide
CLKOUT.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/clk/samsung/clk-exynos-clkout.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/samsung/clk-exynos-clkout.c b/drivers/clk/samsung/clk-exynos-clkout.c
index 7cd02ff37a1f..96fab6cfb202 100644
--- a/drivers/clk/samsung/clk-exynos-clkout.c
+++ b/drivers/clk/samsung/clk-exynos-clkout.c
@@ -151,6 +151,8 @@ static void __init exynos5_clkout_init(struct device_node *node)
 }
 CLK_OF_DECLARE(exynos5250_clkout, "samsung,exynos5250-pmu",
 		exynos5_clkout_init);
+CLK_OF_DECLARE(exynos5410_clkout, "samsung,exynos5410-pmu",
+		exynos5_clkout_init);
 CLK_OF_DECLARE(exynos5420_clkout, "samsung,exynos5420-pmu",
 		exynos5_clkout_init);
 CLK_OF_DECLARE(exynos5433_clkout, "samsung,exynos5433-pmu",
-- 
1.9.1
