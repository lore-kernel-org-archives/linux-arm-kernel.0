From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu,  8 Sep 2016 11:30:22 +0200
Subject: [PATCH 2/2] ARM: clk-imx35: annotate clk enum with number values
In-Reply-To: <1473327022-8065-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1473327022-8065-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1473327022-8065-2-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This helps to decode error messages like:

	[    0.000000] i.MX clk 82: register failed with -17

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---

Hello,

maybe it's also sensible to do:

	enum mx35_clks {
		ckih = 0,
		mpll = 1,
		...

?

Best regards
Uwe

 drivers/clk/imx/clk-imx35.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/clk/imx/clk-imx35.c b/drivers/clk/imx/clk-imx35.c
index d302ed3b8225..203cad6c9aab 100644
--- a/drivers/clk/imx/clk-imx35.c
+++ b/drivers/clk/imx/clk-imx35.c
@@ -66,20 +66,22 @@ static const char *std_sel[] = {"ppll", "arm"};
 static const char *ipg_per_sel[] = {"ahb_per_div", "arm_per_div"};
 
 enum mx35_clks {
-	ckih, mpll, ppll, mpll_075, arm, hsp, hsp_div, hsp_sel, ahb, ipg,
-	arm_per_div, ahb_per_div, ipg_per, uart_sel, uart_div, esdhc_sel,
-	esdhc1_div, esdhc2_div, esdhc3_div, spdif_sel, spdif_div_pre,
-	spdif_div_post, ssi_sel, ssi1_div_pre, ssi1_div_post, ssi2_div_pre,
-	ssi2_div_post, usb_sel, usb_div, nfc_div, asrc_gate, pata_gate,
-	audmux_gate, can1_gate, can2_gate, cspi1_gate, cspi2_gate, ect_gate,
-	edio_gate, emi_gate, epit1_gate, epit2_gate, esai_gate, esdhc1_gate,
-	esdhc2_gate, esdhc3_gate, fec_gate, gpio1_gate, gpio2_gate, gpio3_gate,
-	gpt_gate, i2c1_gate, i2c2_gate, i2c3_gate, iomuxc_gate, ipu_gate,
-	kpp_gate, mlb_gate, mshc_gate, owire_gate, pwm_gate, rngc_gate,
-	rtc_gate, rtic_gate, scc_gate, sdma_gate, spba_gate, spdif_gate,
-	ssi1_gate, ssi2_gate, uart1_gate, uart2_gate, uart3_gate, usbotg_gate,
-	wdog_gate, max_gate, admux_gate, csi_gate, csi_div, csi_sel, iim_gate,
-	gpu2d_gate, ckil, clk_max
+	/*  0 */ ckih, mpll, ppll, mpll_075, arm, hsp, hsp_div, hsp_sel, ahb,
+	/*  9 */ ipg, arm_per_div, ahb_per_div, ipg_per, uart_sel, uart_div,
+	/* 15 */ esdhc_sel, esdhc1_div, esdhc2_div, esdhc3_div, spdif_sel,
+	/* 20 */ spdif_div_pre, spdif_div_post, ssi_sel, ssi1_div_pre,
+	/* 24 */ ssi1_div_post, ssi2_div_pre, ssi2_div_post, usb_sel, usb_div,
+	/* 29 */ nfc_div, asrc_gate, pata_gate, audmux_gate, can1_gate,
+	/* 34 */ can2_gate, cspi1_gate, cspi2_gate, ect_gate, edio_gate,
+	/* 39 */ emi_gate, epit1_gate, epit2_gate, esai_gate, esdhc1_gate,
+	/* 44 */ esdhc2_gate, esdhc3_gate, fec_gate, gpio1_gate, gpio2_gate,
+	/* 49 */ gpio3_gate, gpt_gate, i2c1_gate, i2c2_gate, i2c3_gate,
+	/* 54 */ iomuxc_gate, ipu_gate, kpp_gate, mlb_gate, mshc_gate,
+	/* 59 */ owire_gate, pwm_gate, rngc_gate, rtc_gate, rtic_gate, scc_gate,
+	/* 65 */ sdma_gate, spba_gate, spdif_gate, ssi1_gate, ssi2_gate,
+	/* 70 */ uart1_gate, uart2_gate, uart3_gate, usbotg_gate, wdog_gate,
+	/* 75 */ max_gate, admux_gate, csi_gate, csi_div, csi_sel, iim_gate,
+	/* 81 */ gpu2d_gate, ckil, clk_max
 };
 
 static struct clk *clk[clk_max];
-- 
2.8.1
