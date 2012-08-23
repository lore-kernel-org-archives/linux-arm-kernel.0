From: m.grzeschik@pengutronix.de (Michael Grzeschik)
Date: Thu, 23 Aug 2012 12:38:48 +0200
Subject: [PATCH] ARM: imx: add imx5x usb controller clock lookups
Message-ID: <1345718328-6547-1-git-send-email-m.grzeschik@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
---
 arch/arm/mach-imx/clk-imx51-imx53.c |   36 +++++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-imx/clk-imx51-imx53.c b/arch/arm/mach-imx/clk-imx51-imx53.c
index 4bdcaa9..6ce49b1 100644
--- a/arch/arm/mach-imx/clk-imx51-imx53.c
+++ b/arch/arm/mach-imx/clk-imx51-imx53.c
@@ -258,18 +258,6 @@ static void __init mx5_clocks_common_init(unsigned long rate_ckil,
 	clk_register_clkdev(clk[pwm2_ipg_gate], "pwm", "mxc_pwm.1");
 	clk_register_clkdev(clk[i2c1_gate], NULL, "imx-i2c.0");
 	clk_register_clkdev(clk[i2c2_gate], NULL, "imx-i2c.1");
-	clk_register_clkdev(clk[usboh3_per_gate], "per", "mxc-ehci.0");
-	clk_register_clkdev(clk[usboh3_gate], "ipg", "mxc-ehci.0");
-	clk_register_clkdev(clk[usboh3_gate], "ahb", "mxc-ehci.0");
-	clk_register_clkdev(clk[usboh3_per_gate], "per", "mxc-ehci.1");
-	clk_register_clkdev(clk[usboh3_gate], "ipg", "mxc-ehci.1");
-	clk_register_clkdev(clk[usboh3_gate], "ahb", "mxc-ehci.1");
-	clk_register_clkdev(clk[usboh3_per_gate], "per", "mxc-ehci.2");
-	clk_register_clkdev(clk[usboh3_gate], "ipg", "mxc-ehci.2");
-	clk_register_clkdev(clk[usboh3_gate], "ahb", "mxc-ehci.2");
-	clk_register_clkdev(clk[usboh3_per_gate], "per", "fsl-usb2-udc");
-	clk_register_clkdev(clk[usboh3_gate], "ipg", "fsl-usb2-udc");
-	clk_register_clkdev(clk[usboh3_gate], "ahb", "fsl-usb2-udc");
 	clk_register_clkdev(clk[nfc_gate], NULL, "mxc_nand");
 	clk_register_clkdev(clk[ssi1_ipg_gate], NULL, "imx-ssi.0");
 	clk_register_clkdev(clk[ssi2_ipg_gate], NULL, "imx-ssi.1");
@@ -351,6 +339,18 @@ int __init mx51_clocks_init(unsigned long rate_ckil, unsigned long rate_osc,
 	clk_register_clkdev(clk[ipu_di0_gate], "di0", "imx51-ipu");
 	clk_register_clkdev(clk[ipu_di1_gate], "di1", "imx51-ipu");
 	clk_register_clkdev(clk[ipu_gate], "hsp", "imx51-ipu");
+	clk_register_clkdev(clk[usboh3_per_gate], "per", "73f80600.usb");
+	clk_register_clkdev(clk[usboh3_gate], "ipg", "73f80600.usb");
+	clk_register_clkdev(clk[usboh3_gate], "ahb", "73f80600.usb");
+	clk_register_clkdev(clk[usboh3_per_gate], "per", "73f80400.usb");
+	clk_register_clkdev(clk[usboh3_gate], "ipg", "73f80400.usb");
+	clk_register_clkdev(clk[usboh3_gate], "ahb", "73f80400.usb");
+	clk_register_clkdev(clk[usboh3_per_gate], "per", "73f80200.usb");
+	clk_register_clkdev(clk[usboh3_gate], "ipg", "73f80200.usb");
+	clk_register_clkdev(clk[usboh3_gate], "ahb", "73f80200.usb");
+	clk_register_clkdev(clk[usboh3_per_gate], "per", "73f80000.usb");
+	clk_register_clkdev(clk[usboh3_gate], "ipg", "73f80000.usb");
+	clk_register_clkdev(clk[usboh3_gate], "ahb", "73f80000.usb");
 	clk_register_clkdev(clk[usb_phy_gate], "phy", "mxc-ehci.0");
 	clk_register_clkdev(clk[esdhc1_ipg_gate], "ipg", "sdhci-esdhc-imx51.0");
 	clk_register_clkdev(clk[dummy], "ahb", "sdhci-esdhc-imx51.0");
@@ -439,6 +439,18 @@ int __init mx53_clocks_init(unsigned long rate_ckil, unsigned long rate_osc,
 	clk_register_clkdev(clk[ipu_di0_gate], "di0", "imx53-ipu");
 	clk_register_clkdev(clk[ipu_di1_gate], "di1", "imx53-ipu");
 	clk_register_clkdev(clk[ipu_gate], "hsp", "imx53-ipu");
+	clk_register_clkdev(clk[usboh3_per_gate], "per", "53f80600.usb");
+	clk_register_clkdev(clk[usboh3_gate], "ipg", "53f80600.usb");
+	clk_register_clkdev(clk[usboh3_gate], "ahb", "53f80600.usb");
+	clk_register_clkdev(clk[usboh3_per_gate], "per", "53f80400.usb");
+	clk_register_clkdev(clk[usboh3_gate], "ipg", "53f80400.usb");
+	clk_register_clkdev(clk[usboh3_gate], "ahb", "53f80400.usb");
+	clk_register_clkdev(clk[usboh3_per_gate], "per", "53f80200.usb");
+	clk_register_clkdev(clk[usboh3_gate], "ipg", "53f80200.usb");
+	clk_register_clkdev(clk[usboh3_gate], "ahb", "53f80200.usb");
+	clk_register_clkdev(clk[usboh3_per_gate], "per", "53f80000.usb");
+	clk_register_clkdev(clk[usboh3_gate], "ipg", "53f80000.usb");
+	clk_register_clkdev(clk[usboh3_gate], "ahb", "53f80000.usb");
 	clk_register_clkdev(clk[usb_phy1_gate], "usb_phy1", "mxc-ehci.0");
 	clk_register_clkdev(clk[esdhc1_ipg_gate], "ipg", "sdhci-esdhc-imx53.0");
 	clk_register_clkdev(clk[dummy], "ahb", "sdhci-esdhc-imx53.0");
-- 
1.7.10.4
