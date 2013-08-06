From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Tue,  6 Aug 2013 17:01:15 +0530
Subject: [PATCH 3/3] clk: exynos5420: Make exynos5420_plls static
In-Reply-To: <1375788675-2638-1-git-send-email-sachin.kamat@linaro.org>
References: <1375788675-2638-1-git-send-email-sachin.kamat@linaro.org>
Message-ID: <1375788675-2638-3-git-send-email-sachin.kamat@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

'exynos5420_plls' is used only in this file. Make is static.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/clk/samsung/clk-exynos5420.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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
1.7.9.5
