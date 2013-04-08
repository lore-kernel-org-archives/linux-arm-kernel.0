From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Mon,  8 Apr 2013 16:46:19 +0200
Subject: [PATCH 1/5] ARM i.MX5: Remove tve_sel clock from i.MX53 clock tree
In-Reply-To: <1365432383-7787-1-git-send-email-p.zabel@pengutronix.de>
References: <1365432383-7787-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <1365432383-7787-2-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On i.MX53, there is only tve_ext_sel.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 arch/arm/mach-imx/clk-imx51-imx53.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-imx/clk-imx51-imx53.c b/arch/arm/mach-imx/clk-imx51-imx53.c
index 1be5078..9daef9d 100644
--- a/arch/arm/mach-imx/clk-imx51-imx53.c
+++ b/arch/arm/mach-imx/clk-imx51-imx53.c
@@ -45,7 +45,7 @@ static const char *mx53_ipu_di1_sel[] = { "di_pred", "osc", "ckih1", "tve_di", "
 static const char *mx53_ldb_di1_sel[] = { "pll3_sw", "pll4_sw", };
 static const char *mx51_tve_ext_sel[] = { "osc", "ckih1", };
 static const char *mx53_tve_ext_sel[] = { "pll4_sw", "ckih1", };
-static const char *tve_sel[] = { "tve_pred", "tve_ext_sel", };
+static const char *mx51_tve_sel[] = { "tve_pred", "tve_ext_sel", };
 static const char *ipu_sel[] = { "axi_a", "axi_b", "emi_slow_gate", "ahb", };
 static const char *gpu3d_sel[] = { "axi_a", "axi_b", "emi_slow_gate", "ahb" };
 static const char *gpu2d_sel[] = { "axi_a", "axi_b", "emi_slow_gate", "ahb" };
@@ -188,7 +188,6 @@ static void __init mx5_clocks_common_init(unsigned long rate_ckil,
 	clk[cpu_podf] = imx_clk_divider("cpu_podf", "pll1_sw", MXC_CCM_CACRR, 0, 3);
 	clk[di_pred] = imx_clk_divider("di_pred", "pll3_sw", MXC_CCM_CDCDR, 6, 3);
 	clk[tve_di] = imx_clk_fixed("tve_di", 65000000); /* FIXME */
-	clk[tve_s] = imx_clk_mux("tve_sel", MXC_CCM_CSCMR1, 7, 1, tve_sel, ARRAY_SIZE(tve_sel));
 	clk[iim_gate] = imx_clk_gate2("iim_gate", "ipg", MXC_CCM_CCGR0, 30);
 	clk[uart1_ipg_gate] = imx_clk_gate2("uart1_ipg_gate", "ipg", MXC_CCM_CCGR1, 6);
 	clk[uart1_per_gate] = imx_clk_gate2("uart1_per_gate", "uart_root", MXC_CCM_CCGR1, 8);
@@ -367,6 +366,8 @@ int __init mx51_clocks_init(unsigned long rate_ckil, unsigned long rate_osc,
 				mx51_ipu_di1_sel, ARRAY_SIZE(mx51_ipu_di1_sel));
 	clk[tve_ext_sel] = imx_clk_mux("tve_ext_sel", MXC_CCM_CSCMR1, 6, 1,
 				mx51_tve_ext_sel, ARRAY_SIZE(mx51_tve_ext_sel));
+	clk[tve_s] = imx_clk_mux("tve_sel", MXC_CCM_CSCMR1, 7, 1,
+				mx51_tve_sel, ARRAY_SIZE(mx51_tve_sel));
 	clk[tve_gate] = imx_clk_gate2("tve_gate", "tve_sel", MXC_CCM_CCGR2, 30);
 	clk[tve_pred] = imx_clk_divider("tve_pred", "pll3_sw", MXC_CCM_CDCDR, 28, 3);
 	clk[esdhc1_per_gate] = imx_clk_gate2("esdhc1_per_gate", "esdhc_a_podf", MXC_CCM_CCGR3, 2);
-- 
1.8.2.rc2
