From: shc_work@mail.ru (Alexander Shiyan)
Date: Tue, 10 Jul 2012 22:54:29 +0400
Subject: [PATCH 3/3] ARM: i.MX5x clocks: Fix GPT clocks
In-Reply-To: <20120709082700.GM24458@pengutronix.de>
References: <20120709082700.GM24458@pengutronix.de>
Message-ID: <1341946469-25984-3-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fix incorrect defined bits for GPT clocks according to
datasheet.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/mach-imx/clk-imx51-imx53.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-imx/clk-imx51-imx53.c b/arch/arm/mach-imx/clk-imx51-imx53.c
index 50e6043..628e940 100644
--- a/arch/arm/mach-imx/clk-imx51-imx53.c
+++ b/arch/arm/mach-imx/clk-imx51-imx53.c
@@ -58,7 +58,7 @@ enum imx5_clks {
 	tve_s, uart1_ipg_gate, uart1_per_gate, uart2_ipg_gate,
 	uart2_per_gate, uart3_ipg_gate, uart3_per_gate, i2c1_gate, i2c2_gate,
 	gpt_ipg_gate, pwm1_ipg_gate, pwm1_per_gate, pwm2_ipg_gate, pwm2_per_gate,
-	gpt_gate, fec_gate, usboh3_per_gate, esdhc1_ipg_gate, esdhc2_ipg_gate,
+	gpt_per_gate, fec_gate, usboh3_per_gate, esdhc1_ipg_gate, esdhc2_ipg_gate,
 	esdhc3_ipg_gate, esdhc4_ipg_gate, ssi1_ipg_gate, ssi2_ipg_gate,
 	ssi3_ipg_gate, ecspi1_ipg_gate, ecspi1_per_gate, ecspi2_ipg_gate,
 	ecspi2_per_gate, cspi_ipg_gate, sdma_gate, emi_slow_gate, ipu_s,
@@ -168,12 +168,12 @@ static void __init mx5_clocks_common_init(unsigned long rate_ckil,
 	clk[uart3_per_gate] = imx_clk_gate2("uart3_per_gate", "uart_root", MXC_CCM_CCGR1, 16);
 	clk[i2c1_gate] = imx_clk_gate2("i2c1_gate", "per_root", MXC_CCM_CCGR1, 18);
 	clk[i2c2_gate] = imx_clk_gate2("i2c2_gate", "per_root", MXC_CCM_CCGR1, 20);
-	clk[gpt_ipg_gate] = imx_clk_gate2("gpt_ipg_gate", "ipg", MXC_CCM_CCGR2, 20);
 	clk[pwm1_ipg_gate] = imx_clk_gate2("pwm1_ipg_gate", "ipg", MXC_CCM_CCGR2, 10);
 	clk[pwm1_per_gate] = imx_clk_gate2("pwm1_per_gate", "per_root", MXC_CCM_CCGR2, 12);
 	clk[pwm2_ipg_gate] = imx_clk_gate2("pwm2_ipg_gate", "ipg", MXC_CCM_CCGR2, 14);
 	clk[pwm2_per_gate] = imx_clk_gate2("pwm2_per_gate", "per_root", MXC_CCM_CCGR2, 16);
-	clk[gpt_gate] = imx_clk_gate2("gpt_gate", "per_root", MXC_CCM_CCGR2, 18);
+	clk[gpt_ipg_gate] = imx_clk_gate2("gpt_ipg_gate", "ipg", MXC_CCM_CCGR2, 18);
+	clk[gpt_per_gate] = imx_clk_gate2("gpt_per_gate", "per_root", MXC_CCM_CCGR2, 20);
 	clk[fec_gate] = imx_clk_gate2("fec_gate", "ipg", MXC_CCM_CCGR2, 24);
 	clk[usboh3_gate] = imx_clk_gate2("usboh3_gate", "ipg", MXC_CCM_CCGR2, 26);
 	clk[usboh3_per_gate] = imx_clk_gate2("usboh3_per_gate", "usboh3_podf", MXC_CCM_CCGR2, 28);
@@ -237,7 +237,7 @@ static void __init mx5_clocks_common_init(unsigned long rate_ckil,
 			pr_err("i.MX5 clk %d: register failed with %ld\n",
 				i, PTR_ERR(clk[i]));
 	
-	clk_register_clkdev(clk[gpt_gate], "per", "imx-gpt.0");
+	clk_register_clkdev(clk[gpt_per_gate], "per", "imx-gpt.0");
 	clk_register_clkdev(clk[gpt_ipg_gate], "ipg", "imx-gpt.0");
 	clk_register_clkdev(clk[uart1_per_gate], "per", "imx21-uart.0");
 	clk_register_clkdev(clk[uart1_ipg_gate], "ipg", "imx21-uart.0");
-- 
1.7.3.4
