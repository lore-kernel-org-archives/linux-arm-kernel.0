From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 23 May 2014 11:04:08 +0200
Subject: [PATCH] clk: samsung: Make of_device_id array const
Message-ID: <1400835848-26993-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Array of struct of_device_id may be be const as expected by
of_match_table field and of_find_matching_node_and_match() function.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/clk/samsung/clk-exynos4.c    | 2 +-
 drivers/clk/samsung/clk-exynos5250.c | 2 +-
 drivers/clk/samsung/clk-exynos5420.c | 2 +-
 drivers/clk/samsung/clk-exynos5440.c | 2 +-
 drivers/clk/samsung/clk.c            | 2 +-
 drivers/clk/samsung/clk.h            | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos4.c b/drivers/clk/samsung/clk-exynos4.c
index b4f967210175..3463535dcc25 100644
--- a/drivers/clk/samsung/clk-exynos4.c
+++ b/drivers/clk/samsung/clk-exynos4.c
@@ -1070,7 +1070,7 @@ static void __init exynos4_clk_register_finpll(void)
 
 }
 
-static struct of_device_id ext_clk_match[] __initdata = {
+static const struct of_device_id ext_clk_match[] __initconst = {
 	{ .compatible = "samsung,clock-xxti", .data = (void *)0, },
 	{ .compatible = "samsung,clock-xusbxti", .data = (void *)1, },
 	{},
diff --git a/drivers/clk/samsung/clk-exynos5250.c b/drivers/clk/samsung/clk-exynos5250.c
index e7ee4420da81..0d97c69fde29 100644
--- a/drivers/clk/samsung/clk-exynos5250.c
+++ b/drivers/clk/samsung/clk-exynos5250.c
@@ -678,7 +678,7 @@ static struct samsung_pll_clock exynos5250_plls[nr_plls] __initdata = {
 		VPLL_LOCK, VPLL_CON0, NULL),
 };
 
-static struct of_device_id ext_clk_match[] __initdata = {
+static const struct of_device_id ext_clk_match[] __initconst = {
 	{ .compatible = "samsung,clock-xxti", .data = (void *)0, },
 	{ },
 };
diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
index 60b26819bed5..904881493b32 100644
--- a/drivers/clk/samsung/clk-exynos5420.c
+++ b/drivers/clk/samsung/clk-exynos5420.c
@@ -770,7 +770,7 @@ static struct samsung_pll_clock exynos5420_plls[nr_plls] __initdata = {
 		KPLL_CON0, NULL),
 };
 
-static struct of_device_id ext_clk_match[] __initdata = {
+static const struct of_device_id ext_clk_match[] __initconst = {
 	{ .compatible = "samsung,exynos5420-oscclk", .data = (void *)0, },
 	{ },
 };
diff --git a/drivers/clk/samsung/clk-exynos5440.c b/drivers/clk/samsung/clk-exynos5440.c
index 2bfad5a993d0..ff70bfed5ef8 100644
--- a/drivers/clk/samsung/clk-exynos5440.c
+++ b/drivers/clk/samsung/clk-exynos5440.c
@@ -84,7 +84,7 @@ static struct samsung_gate_clock exynos5440_gate_clks[] __initdata = {
 	GATE(CLK_CS250_O, "cs250_o", "cs250", CLKEN_OV_VAL, 19, 0, 0),
 };
 
-static struct of_device_id ext_clk_match[] __initdata = {
+static const struct of_device_id ext_clk_match[] __initconst = {
 	{ .compatible = "samsung,clock-xtal", .data = (void *)0, },
 	{},
 };
diff --git a/drivers/clk/samsung/clk.c b/drivers/clk/samsung/clk.c
index 91bec3ebdc8f..f9914a8b02ae 100644
--- a/drivers/clk/samsung/clk.c
+++ b/drivers/clk/samsung/clk.c
@@ -269,7 +269,7 @@ void __init samsung_clk_register_gate(struct samsung_gate_clock *list,
 void __init samsung_clk_of_register_fixed_ext(
 			struct samsung_fixed_rate_clock *fixed_rate_clk,
 			unsigned int nr_fixed_rate_clk,
-			struct of_device_id *clk_matches)
+			const struct of_device_id *clk_matches)
 {
 	const struct of_device_id *match;
 	struct device_node *np;
diff --git a/drivers/clk/samsung/clk.h b/drivers/clk/samsung/clk.h
index c7141ba826e0..dc8f2cc6f486 100644
--- a/drivers/clk/samsung/clk.h
+++ b/drivers/clk/samsung/clk.h
@@ -317,7 +317,7 @@ extern void __init samsung_clk_init(struct device_node *np, void __iomem *base,
 extern void __init samsung_clk_of_register_fixed_ext(
 		struct samsung_fixed_rate_clock *fixed_rate_clk,
 		unsigned int nr_fixed_rate_clk,
-		struct of_device_id *clk_matches);
+		const struct of_device_id *clk_matches);
 
 extern void samsung_clk_add_lookup(struct clk *clk, unsigned int id);
 
-- 
1.9.1
