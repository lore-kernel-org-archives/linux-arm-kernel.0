From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Mon, 22 Aug 2016 18:48:38 +0900
Subject: [PATCH 4/5] clk: samsung: exynos5420: Fix the checkpatch warnings
In-Reply-To: <1471859319-30681-1-git-send-email-cw00.choi@samsung.com>
References: <1471859319-30681-1-git-send-email-cw00.choi@samsung.com>
Message-ID: <1471859319-30681-5-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes the following warnings by using checkpatch.pl script.
- WARNING: void function return statements are not generally useful
- ERROR: space prohibited before that ','
- ERROR: Use of __initconst requires a separate use of const

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/clk/samsung/clk-exynos5420.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
index c99d05cd37b7..16b7d160fbdf 100644
--- a/drivers/clk/samsung/clk-exynos5420.c
+++ b/drivers/clk/samsung/clk-exynos5420.c
@@ -336,7 +336,6 @@ err_soc:
 	kfree(exynos5x_save);
 	pr_warn("%s: failed to allocate sleep save data, no sleep support!\n",
 		__func__);
-	return;
 }
 #else
 static void __init exynos5420_clk_sleep_init(void) {}
@@ -345,8 +344,8 @@ static void __init exynos5420_clk_sleep_init(void) {}
 /* list of all parent clocks */
 PNAME(mout_mspll_cpu_p) = {"mout_sclk_cpll", "mout_sclk_dpll",
 				"mout_sclk_mpll", "mout_sclk_spll"};
-PNAME(mout_cpu_p) = {"mout_apll" , "mout_mspll_cpu"};
-PNAME(mout_kfc_p) = {"mout_kpll" , "mout_mspll_kfc"};
+PNAME(mout_cpu_p) = {"mout_apll", "mout_mspll_cpu"};
+PNAME(mout_kfc_p) = {"mout_kpll", "mout_mspll_kfc"};
 PNAME(mout_apll_p) = {"fin_pll", "fout_apll"};
 PNAME(mout_bpll_p) = {"fin_pll", "fout_bpll"};
 PNAME(mout_cpll_p) = {"fin_pll", "fout_cpll"};
@@ -503,14 +502,12 @@ static const struct samsung_fixed_rate_clock exynos5x_fixed_rate_clks[] __initco
 	FRATE(0, "sclk_usbh20_scan_clk", NULL, 0, 480000000),
 };
 
-static const struct samsung_fixed_factor_clock
-		exynos5x_fixed_factor_clks[] __initconst = {
+static const struct samsung_fixed_factor_clock exynos5x_fixed_factor_clks[] __initconst = {
 	FFACTOR(0, "ff_hsic_12m", "fin_pll", 1, 2, 0),
 	FFACTOR(0, "ff_sw_aclk66", "mout_sw_aclk66", 1, 2, 0),
 };
 
-static const struct samsung_fixed_factor_clock
-		exynos5800_fixed_factor_clks[] __initconst = {
+static const struct samsung_fixed_factor_clock exynos5800_fixed_factor_clks[] __initconst = {
 	FFACTOR(0, "ff_dout_epll2", "mout_sclk_epll", 1, 2, 0),
 	FFACTOR(0, "ff_dout_spll2", "mout_sclk_spll", 1, 2, 0),
 };
-- 
1.9.1
