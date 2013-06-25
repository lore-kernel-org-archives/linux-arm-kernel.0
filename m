From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Tue, 25 Jun 2013 10:59:59 -0300
Subject: [PATCH 1/3] clk: mxs: clk-imx28: Provide a dummy clock
Message-ID: <1372168801-4221-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sometimes it is useful to be able to pass a dummy clock for a driver.

Add support for a dummy clock.

Cc: Mike Turquette <mturquette@linaro.org>
Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 Documentation/devicetree/bindings/clock/imx28-clock.txt | 1 +
 drivers/clk/mxs/clk-imx28.c                             | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/clock/imx28-clock.txt b/Documentation/devicetree/bindings/clock/imx28-clock.txt
index e6587af..5a153ef 100644
--- a/Documentation/devicetree/bindings/clock/imx28-clock.txt
+++ b/Documentation/devicetree/bindings/clock/imx28-clock.txt
@@ -76,6 +76,7 @@ clocks and IDs.
 	usb0_phy	62
 	usb1_phy	63
 	enet_out	64
+	dummy		65
 
 Examples:
 
diff --git a/drivers/clk/mxs/clk-imx28.c b/drivers/clk/mxs/clk-imx28.c
index 4faf0af..6b55211 100644
--- a/drivers/clk/mxs/clk-imx28.c
+++ b/drivers/clk/mxs/clk-imx28.c
@@ -143,7 +143,7 @@ enum imx28_clk {
 	emi_xtal, lcdif_div, etm_div, ptp, saif0_div, saif1_div,
 	clk32k_div, rtc, lradc, spdif_div, clk32k, pwm, uart, ssp0,
 	ssp1, ssp2, ssp3, gpmi, spdif, emi, saif0, saif1, lcdif, etm,
-	fec, can0, can1, usb0, usb1, usb0_phy, usb1_phy, enet_out,
+	fec, can0, can1, usb0, usb1, usb0_phy, usb1_phy, enet_out, dummy,
 	clk_max
 };
 
@@ -234,6 +234,7 @@ int __init mx28_clocks_init(void)
 	clks[usb0_phy] = clk_register_gate(NULL, "usb0_phy", "pll0", 0, PLL0CTRL0, 18, 0, &mxs_lock);
 	clks[usb1_phy] = clk_register_gate(NULL, "usb1_phy", "pll1", 0, PLL1CTRL0, 18, 0, &mxs_lock);
 	clks[enet_out] = clk_register_gate(NULL, "enet_out", "pll2", 0, ENET, 18, 0, &mxs_lock);
+	clks[dummy] = mxs_clk_fixed("dummy", 0);
 
 	for (i = 0; i < ARRAY_SIZE(clks); i++)
 		if (IS_ERR(clks[i])) {
-- 
1.8.1.2
