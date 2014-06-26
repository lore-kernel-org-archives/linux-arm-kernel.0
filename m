From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 26 Jun 2014 14:00:06 +0200
Subject: [PATCH RESEND] clk: samsung: Make of_device_id array const
Message-ID: <1403784006-17605-1-git-send-email-k.kozlowski@samsung.com>
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
index 4f150c9dd38c..ca6688483390 100644
--- a/drivers/clk/samsung/clk-exynos4.c
+++ b/drivers/clk/samsung/clk-exynos4.c
@@ -1070,7 +1070,7 @@ static void __init exynos4_clk_register_finpll(struct samsung_clk_provider *ctx)
 
 }
 
-static struct of_device_id ext_clk_match[] __initdata = {
+static const struct of_device_id ext_clk_match[] __initconst = {
 	{ .compatible = "samsung,clock-xxti", .data = (void *)0, },
 	{ .compatible = "samsung,clock-xusbxti", .data = (void *)1, },
 	{},
diff --git a/drivers/clk/samsung/clk-exynos5250.c b/drivers/clk/samsung/clk-exynos5250.c
index 1fad4c5e3f5d..0af3e4ff0eb5 100644
--- a/drivers/clk/samsung/clk-exynos5250.c
+++ b/drivers/clk/samsung/clk-exynos5250.c
@@ -748,7 +748,7 @@ static struct samsung_pll_clock exynos5250_plls[nr_plls] __initdata = {
 		VPLL_LOCK, VPLL_CON0, NULL),
 };
 
-static struct of_device_id ext_clk_match[] __initdata = {
+static const struct of_device_id ext_clk_match[] __initconst = {
 	{ .compatible = "samsung,clock-xxti", .data = (void *)0, },
 	{ },
 };
diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
index 9d7d7eed03fd..007b5ef8bc1c 100644
--- a/drivers/clk/samsung/clk-exynos5420.c
+++ b/drivers/clk/samsung/clk-exynos5420.c
@@ -1167,7 +1167,7 @@ static struct samsung_pll_clock exynos5x_plls[nr_plls] __initdata = {
 		KPLL_CON0, NULL),
 };
 
-static struct of_device_id ext_clk_match[] __initdata = {
+static const struct of_device_id ext_clk_match[] __initconst = {
 	{ .compatible = "samsung,exynos5420-oscclk", .data = (void *)0, },
 	{ },
 };
diff --git a/drivers/clk/samsung/clk-exynos5440.c b/drivers/clk/samsung/clk-exynos5440.c
index 647f1440aa6a..6e8b40a3b143 100644
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
index 49629c71c9e7..2413677b42fe 100644
--- a/drivers/clk/samsung/clk.c
+++ b/drivers/clk/samsung/clk.c
@@ -284,7 +284,7 @@ void __init samsung_clk_register_gate(struct samsung_clk_provider *ctx,
 void __init samsung_clk_of_register_fixed_ext(struct samsung_clk_provider *ctx,
 			struct samsung_fixed_rate_clock *fixed_rate_clk,
 			unsigned int nr_fixed_rate_clk,
-			struct of_device_id *clk_matches)
+			const struct of_device_id *clk_matches)
 {
 	const struct of_device_id *match;
 	struct device_node *clk_np;
diff --git a/drivers/clk/samsung/clk.h b/drivers/clk/samsung/clk.h
index 9693b80d924f..150a9ebc0266 100644
--- a/drivers/clk/samsung/clk.h
+++ b/drivers/clk/samsung/clk.h
@@ -331,7 +331,7 @@ extern void __init samsung_clk_of_register_fixed_ext(
 			struct samsung_clk_provider *ctx,
 			struct samsung_fixed_rate_clock *fixed_rate_clk,
 			unsigned int nr_fixed_rate_clk,
-			struct of_device_id *clk_matches);
+			const struct of_device_id *clk_matches);
 
 extern void samsung_clk_add_lookup(struct samsung_clk_provider *ctx,
 			struct clk *clk, unsigned int id);
-- 
1.9.1
