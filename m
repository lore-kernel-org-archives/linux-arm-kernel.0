From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Mon, 25 Nov 2013 11:31:14 +0100
Subject: [PATCH] ARM i.MX5: fix "shift" value for lp_apm_sel
Message-ID: <1385375474-15901-1-git-send-email-mkl@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to the i.MX53 Rev. 2.1 datasheet the lp_apm_sel is bit 10 in the
CCM_CCSR register not bit 9.

This patch fixes this issue.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 arch/arm/mach-imx/clk-imx51-imx53.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/clk-imx51-imx53.c b/arch/arm/mach-imx/clk-imx51-imx53.c
index 3f01df2..867d623 100644
--- a/arch/arm/mach-imx/clk-imx51-imx53.c
+++ b/arch/arm/mach-imx/clk-imx51-imx53.c
@@ -98,7 +98,7 @@ static void __init mx5_clocks_common_init(unsigned long rate_ckil,
 	clk[IMX5_CLK_CKIH1]		= imx_obtain_fixed_clock("ckih1", rate_ckih1);
 	clk[IMX5_CLK_CKIH2]		= imx_obtain_fixed_clock("ckih2", rate_ckih2);
 
-	clk[IMX5_CLK_LP_APM]		= imx_clk_mux("lp_apm", MXC_CCM_CCSR, 9, 1,
+	clk[IMX5_CLK_LP_APM]		= imx_clk_mux("lp_apm", MXC_CCM_CCSR, 10, 1,
 						lp_apm_sel, ARRAY_SIZE(lp_apm_sel));
 	clk[IMX5_CLK_PERIPH_APM]	= imx_clk_mux("periph_apm", MXC_CCM_CBCMR, 12, 2,
 						periph_apm_sel, ARRAY_SIZE(periph_apm_sel));
-- 
1.8.4.2
