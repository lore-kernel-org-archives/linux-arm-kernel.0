From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 11 May 2016 14:02:06 +0200
Subject: [PATCH 10/18] clk: samsung: exynos5410: Constify all clock
 initializers
In-Reply-To: <1462968134-6085-1-git-send-email-k.kozlowski@samsung.com>
References: <1462968134-6085-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1462968134-6085-10-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All of initialization data can be made const.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/clk/samsung/clk-exynos5410.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos5410.c b/drivers/clk/samsung/clk-exynos5410.c
index d5d5dcabc4a9..8e8c7cca8c62 100644
--- a/drivers/clk/samsung/clk-exynos5410.c
+++ b/drivers/clk/samsung/clk-exynos5410.c
@@ -76,7 +76,7 @@ PNAME(group2_p)		= { "fin_pll", "fin_pll", "none", "none",
 			"none", "none", "sclk_mpll_bpll",
 			 "none", "none", "sclk_cpll" };
 
-static struct samsung_mux_clock exynos5410_mux_clks[] __initdata = {
+static const struct samsung_mux_clock exynos5410_mux_clks[] __initconst = {
 	MUX(0, "mout_apll", apll_p, SRC_CPU, 0, 1),
 	MUX(0, "mout_cpu", mout_cpu_p, SRC_CPU, 16, 1),
 
@@ -105,7 +105,7 @@ static struct samsung_mux_clock exynos5410_mux_clks[] __initdata = {
 	MUX(0, "mout_aclk400", mpll_bpll_p, SRC_TOP0, 20, 1),
 };
 
-static struct samsung_div_clock exynos5410_div_clks[] __initdata = {
+static const struct samsung_div_clock exynos5410_div_clks[] __initconst = {
 	DIV(0, "div_arm", "mout_cpu", DIV_CPU0, 0, 3),
 	DIV(0, "div_arm2", "div_arm", DIV_CPU0, 28, 3),
 
@@ -141,7 +141,7 @@ static struct samsung_div_clock exynos5410_div_clks[] __initdata = {
 	DIV(0, "aclk400", "mout_aclk400", DIV_TOP0, 24, 3),
 };
 
-static struct samsung_gate_clock exynos5410_gate_clks[] __initdata = {
+static const struct samsung_gate_clock exynos5410_gate_clks[] __initconst = {
 	GATE(CLK_MCT, "mct", "aclk66", GATE_IP_PERIS, 18, 0, 0),
 
 	GATE(CLK_SCLK_MMC0, "sclk_mmc0", "div_mmc_pre0",
@@ -167,7 +167,7 @@ static struct samsung_gate_clock exynos5410_gate_clks[] __initdata = {
 			SRC_MASK_PERIC0, 8, CLK_SET_RATE_PARENT, 0),
 };
 
-static struct samsung_pll_clock exynos5410_plls[nr_plls] __initdata = {
+static const struct samsung_pll_clock exynos5410_plls[nr_plls] __initconst = {
 	[apll] = PLL(pll_35xx, CLK_FOUT_APLL, "fout_apll", "fin_pll", APLL_LOCK,
 		APLL_CON0, NULL),
 	[cpll] = PLL(pll_35xx, CLK_FOUT_CPLL, "fout_cpll", "fin_pll", CPLL_LOCK,
-- 
1.9.1
