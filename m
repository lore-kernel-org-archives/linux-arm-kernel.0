From: broonie@kernel.org (Mark Brown)
Date: Thu,  8 Aug 2013 12:06:23 +0100
Subject: [PATCH] clk: samsung: Staticise non-exported symbols for PLLs
Message-ID: <1375959983-2690-1-git-send-email-broonie@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mark Brown <broonie@linaro.org>

These symbols are not used outside the files they are defined in so do
not need to be in the global namespace and they aren't declared so sparse
warns.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 drivers/clk/samsung/clk-exynos4.c    | 2 +-
 drivers/clk/samsung/clk-exynos5250.c | 2 +-
 drivers/clk/samsung/clk-exynos5420.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos4.c b/drivers/clk/samsung/clk-exynos4.c
index 68f9a4a..fec319d 100644
--- a/drivers/clk/samsung/clk-exynos4.c
+++ b/drivers/clk/samsung/clk-exynos4.c
@@ -984,7 +984,7 @@ static __initdata struct of_device_id ext_clk_match[] = {
 	{},
 };
 
-struct __initdata samsung_pll_clock exynos4_plls[nr_plls] = {
+static struct __initdata samsung_pll_clock exynos4_plls[nr_plls] = {
 	[apll] = PLL_A(pll_35xx, fout_apll, "fout_apll", "fin_pll", APLL_LOCK,
 		APLL_CON0, "fout_apll", NULL),
 	[mpll] = PLL_A(pll_35xx, fout_mpll, "fout_mpll", "fin_pll",
diff --git a/drivers/clk/samsung/clk-exynos5250.c b/drivers/clk/samsung/clk-exynos5250.c
index df3628c..5865cef 100644
--- a/drivers/clk/samsung/clk-exynos5250.c
+++ b/drivers/clk/samsung/clk-exynos5250.c
@@ -517,7 +517,7 @@ static __initdata struct samsung_pll_rate_table epll_24mhz_tbl[] = {
 	{ },
 };
 
-struct __initdata samsung_pll_clock exynos5250_plls[nr_plls] = {
+static struct __initdata samsung_pll_clock exynos5250_plls[nr_plls] = {
 	[apll] = PLL_A(pll_35xx, fout_apll, "fout_apll", "fin_pll", APLL_LOCK,
 		APLL_CON0, "fout_apll", NULL),
 	[mpll] = PLL_A(pll_35xx, fout_mpll, "fout_mpll", "fin_pll", MPLL_LOCK,
diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
index ca352695..872e13d 100644
--- a/drivers/clk/samsung/clk-exynos5420.c
+++ b/drivers/clk/samsung/clk-exynos5420.c
@@ -727,7 +727,7 @@ static struct samsung_gate_clock exynos5420_gate_clks[] __initdata = {
 	GATE(smmu_mscl2, "smmu_mscl2", "aclk400_mscl", GATE_IP_MSCL, 10, 0, 0),
 };
 
-struct __initdata samsung_pll_clock exynos5420_plls[nr_plls] = {
+static struct __initdata samsung_pll_clock exynos5420_plls[nr_plls] = {
 	[apll] = PLL(pll_2550, fout_apll, "fout_apll", "fin_pll", APLL_LOCK,
 		APLL_CON0, NULL),
 	[cpll] = PLL(pll_2550, fout_mpll, "fout_mpll", "fin_pll", MPLL_LOCK,
-- 
1.8.4.rc1
