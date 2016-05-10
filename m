From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Tue, 10 May 2016 22:09:10 +0200
Subject: [PATCH v3 07/27] clk: samsung: exynos5410: Rename fin_pll from
 temporary to regular name
In-Reply-To: <1462910970-1812-1-git-send-email-krzk@kernel.org>
References: <1462910970-1812-1-git-send-email-krzk@kernel.org>
Message-ID: <1462910970-1812-8-git-send-email-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For smooth transition of fin_pll to clk-exynos5410.c from fixed-clock
driver, initially it was named "fin_pll_new". Fix this here.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Acked-by: Stephen Boyd <sboyd@codeaurora.org>
Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
---
 drivers/clk/samsung/clk-exynos5410.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos5410.c b/drivers/clk/samsung/clk-exynos5410.c
index 35f2cb36f7ef..a7d714435307 100644
--- a/drivers/clk/samsung/clk-exynos5410.c
+++ b/drivers/clk/samsung/clk-exynos5410.c
@@ -59,27 +59,27 @@ enum exynos5410_plls {
 };
 
 /* list of all parent clocks */
-PNAME(apll_p)		= { "fin_pll_new", "fout_apll", };
-PNAME(bpll_p)		= { "fin_pll_new", "fout_bpll", };
-PNAME(cpll_p)		= { "fin_pll_new", "fout_cpll" };
-PNAME(mpll_p)		= { "fin_pll_new", "fout_mpll", };
-PNAME(kpll_p)		= { "fin_pll_new", "fout_kpll", };
+PNAME(apll_p)		= { "fin_pll", "fout_apll", };
+PNAME(bpll_p)		= { "fin_pll", "fout_bpll", };
+PNAME(cpll_p)		= { "fin_pll", "fout_cpll" };
+PNAME(mpll_p)		= { "fin_pll", "fout_mpll", };
+PNAME(kpll_p)		= { "fin_pll", "fout_kpll", };
 
 PNAME(mout_cpu_p)	= { "mout_apll", "sclk_mpll", };
 PNAME(mout_kfc_p)	= { "mout_kpll", "sclk_mpll", };
 
-PNAME(mpll_user_p)	= { "fin_pll_new", "sclk_mpll", };
-PNAME(bpll_user_p)	= { "fin_pll_new", "sclk_bpll", };
+PNAME(mpll_user_p)	= { "fin_pll", "sclk_mpll", };
+PNAME(bpll_user_p)	= { "fin_pll", "sclk_bpll", };
 PNAME(mpll_bpll_p)	= { "sclk_mpll_muxed", "sclk_bpll_muxed", };
 
-PNAME(group2_p)		= { "fin_pll_new", "fin_pll_new", "none", "none",
+PNAME(group2_p)		= { "fin_pll", "fin_pll", "none", "none",
 			"none", "none", "sclk_mpll_bpll",
 			 "none", "none", "sclk_cpll" };
 
 /* fixed rate clocks generated outside the soc */
 static struct samsung_fixed_rate_clock
 		exynos5x_fixed_rate_ext_clks[] __initdata = {
-	FRATE(CLK_FIN_PLL, "fin_pll_new", NULL, 0, 0),
+	FRATE(CLK_FIN_PLL, "fin_pll", NULL, 0, 0),
 };
 
 static struct samsung_mux_clock exynos5410_mux_clks[] __initdata = {
@@ -174,15 +174,15 @@ static struct samsung_gate_clock exynos5410_gate_clks[] __initdata = {
 };
 
 static struct samsung_pll_clock exynos5410_plls[nr_plls] __initdata = {
-	[apll] = PLL(pll_35xx, CLK_FOUT_APLL, "fout_apll", "fin_pll_new", APLL_LOCK,
+	[apll] = PLL(pll_35xx, CLK_FOUT_APLL, "fout_apll", "fin_pll", APLL_LOCK,
 		APLL_CON0, NULL),
-	[cpll] = PLL(pll_35xx, CLK_FOUT_CPLL, "fout_cpll", "fin_pll_new", CPLL_LOCK,
+	[cpll] = PLL(pll_35xx, CLK_FOUT_CPLL, "fout_cpll", "fin_pll", CPLL_LOCK,
 		CPLL_CON0, NULL),
-	[mpll] = PLL(pll_35xx, CLK_FOUT_MPLL, "fout_mpll", "fin_pll_new", MPLL_LOCK,
+	[mpll] = PLL(pll_35xx, CLK_FOUT_MPLL, "fout_mpll", "fin_pll", MPLL_LOCK,
 		MPLL_CON0, NULL),
-	[bpll] = PLL(pll_35xx, CLK_FOUT_BPLL, "fout_bpll", "fin_pll_new", BPLL_LOCK,
+	[bpll] = PLL(pll_35xx, CLK_FOUT_BPLL, "fout_bpll", "fin_pll", BPLL_LOCK,
 		BPLL_CON0, NULL),
-	[kpll] = PLL(pll_35xx, CLK_FOUT_KPLL, "fout_kpll", "fin_pll_new", KPLL_LOCK,
+	[kpll] = PLL(pll_35xx, CLK_FOUT_KPLL, "fout_kpll", "fin_pll", KPLL_LOCK,
 		KPLL_CON0, NULL),
 };
 
-- 
2.5.0
