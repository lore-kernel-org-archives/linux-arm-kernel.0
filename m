From: t.figa@samsung.com (Tomasz Figa)
Date: Wed, 27 Mar 2013 12:02:46 +0100
Subject: [PATCH 09/21] clk: samsung: exynos4: Export mout_core clock of
 Exynos4210
In-Reply-To: <1364382178-25248-1-git-send-email-t.figa@samsung.com>
References: <1364382178-25248-1-git-send-email-t.figa@samsung.com>
Message-ID: <1364382178-25248-10-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables clock lookup registration for mout_core clock used in
Exynos4210 cpufreq driver.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/clk/samsung/clk-exynos4.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/samsung/clk-exynos4.c b/drivers/clk/samsung/clk-exynos4.c
index 5592a78..8c4cffb 100644
--- a/drivers/clk/samsung/clk-exynos4.c
+++ b/drivers/clk/samsung/clk-exynos4.c
@@ -311,7 +311,7 @@ struct samsung_mux_clock exynos4210_mux_clks[] __initdata = {
 	MUX(none, "mout_fimd1", group1_p4210, SRC_LCD1, 0, 4),
 	MUX(none, "mout_mipi1", group1_p4210, SRC_LCD1, 12, 4),
 	MUX_A(sclk_mpll, "sclk_mpll", mout_mpll_p, SRC_CPU, 8, 1, "sclk_mpll"),
-	MUX(none, "mout_core", mout_core_p4210, SRC_CPU, 16, 1),
+	MUX_A(mout_core, "mout_core", mout_core_p4210, SRC_CPU, 16, 1, "mout_core"),
 	MUX_A(sclk_vpll, "sclk_vpll", sclk_vpll_p4210,
 			SRC_TOP0, 8, 1, "sclk_vpll"),
 	MUX(none, "mout_fimc0", group1_p4210, SRC_CAM, 0, 4),
-- 
1.8.1.5
