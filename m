From: arun.kk@samsung.com (Arun Kumar K)
Date: Fri,  6 Dec 2013 15:18:03 +0530
Subject: [PATCH 2/3] clk: exynos5420: Add alias names for cpu clocks
In-Reply-To: <1386323284-15646-1-git-send-email-arun.kk@samsung.com>
References: <1386323284-15646-1-git-send-email-arun.kk@samsung.com>
Message-ID: <1386323284-15646-3-git-send-email-arun.kk@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adds alias names for cpu clocks to be used in the cpufreq driver.

Signed-off-by: Arun Kumar K <arun.kk@samsung.com>
---
 drivers/clk/samsung/clk-exynos5420.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
index 48c4a93..c65c040 100644
--- a/drivers/clk/samsung/clk-exynos5420.c
+++ b/drivers/clk/samsung/clk-exynos5420.c
@@ -316,9 +316,10 @@ static struct samsung_fixed_factor_clock exynos5420_fixed_factor_clks[] __initda
 
 static struct samsung_mux_clock exynos5420_mux_clks[] __initdata = {
 	MUX(none, "mout_mspll_kfc", mspll_cpu_p, SRC_TOP7, 8, 2),
-	MUX(none, "mout_mspll_cpu", mspll_cpu_p, SRC_TOP7, 12, 2),
-	MUX(none, "mout_apll", apll_p, SRC_CPU, 0, 1),
-	MUX(none, "mout_cpu", cpu_p, SRC_CPU, 16, 1),
+	MUX_A(none, "mout_mspll_cpu", mspll_cpu_p, SRC_TOP7, 12, 2,
+			"mout_mspll_cpu"),
+	MUX_A(none, "mout_apll", apll_p, SRC_CPU, 0, 1, "mout_apll"),
+	MUX_A(none, "mout_cpu", cpu_p, SRC_CPU, 16, 1, "mout_cpu"),
 	MUX(none, "mout_kpll", kpll_p, SRC_KFC, 0, 1),
 	MUX(none, "mout_cpu_kfc", kfc_p, SRC_KFC, 16, 1),
 
@@ -373,7 +374,7 @@ static struct samsung_mux_clock exynos5420_mux_clks[] __initdata = {
 
 	MUX(none, "sclk_mpll", mpll_p, SRC_TOP6, 0, 1),
 	MUX(none, "sclk_vpll", vpll_p, SRC_TOP6, 4, 1),
-	MUX(none, "sclk_spll", spll_p, SRC_TOP6, 8, 1),
+	MUX_A(none, "sclk_spll", spll_p, SRC_TOP6, 8, 1, "mout_spll"),
 	MUX(none, "sclk_ipll", ipll_p, SRC_TOP6, 12, 1),
 	MUX(none, "sclk_rpll", rpll_p, SRC_TOP6, 16, 1),
 	MUX(none, "sclk_epll", epll_p, SRC_TOP6, 20, 1),
-- 
1.7.9.5
