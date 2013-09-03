From: chander.kashyap@linaro.org (Chander Kashyap)
Date: Tue,  3 Sep 2013 17:04:31 +0530
Subject: [RFC Patch v2 3/3] clk: samsung: Exynos5250: Add alternate parent
 name for mout_cpu
In-Reply-To: <1378208072-10173-1-git-send-email-chander.kashyap@linaro.org>
References: <1378208072-10173-1-git-send-email-chander.kashyap@linaro.org>
Message-ID: <1378208072-10173-4-git-send-email-chander.kashyap@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Temporary parent migration is required during cpu frequency scaling. Hence
this patch adds support to supply alternate parent name for cpu clock i.e.
"mout_cpu".

Signed-off-by: Chander Kashyap <chander.kashyap@linaro.org>
---
 drivers/clk/samsung/clk-exynos5250.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/samsung/clk-exynos5250.c b/drivers/clk/samsung/clk-exynos5250.c
index d90e593..aec2e09 100644
--- a/drivers/clk/samsung/clk-exynos5250.c
+++ b/drivers/clk/samsung/clk-exynos5250.c
@@ -239,7 +239,9 @@ static struct samsung_mux_clock exynos5250_pll_pmux_clks[] __initdata = {
 
 static struct samsung_mux_clock exynos5250_mux_clks[] __initdata = {
 	MUX_A(none, "mout_apll", mout_apll_p, SRC_CPU, 0, 1, "mout_apll"),
-	MUX_A(none, "mout_cpu", mout_cpu_p, SRC_CPU, 16, 1, "mout_cpu"),
+	MUX_FA(none, "mout_cpu", mout_cpu_p, SRC_CPU, 16, 1,
+			CLK_SET_RATE_PARENT | CLK_SET_RATE_TEMP_PARENT,
+			0, "mout_cpu", "sclk_mpll"),
 	MUX(none, "mout_mpll_fout", mout_mpll_fout_p, PLL_DIV2_SEL, 4, 1),
 	MUX_A(none, "sclk_mpll", mout_mpll_p, SRC_CORE1, 8, 1, "mout_mpll"),
 	MUX(none, "mout_bpll_fout", mout_bpll_fout_p, PLL_DIV2_SEL, 0, 1),
-- 
1.7.9.5
