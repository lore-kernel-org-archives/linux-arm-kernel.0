From: m.grzeschik@pengutronix.de (Michael Grzeschik)
Date: Thu, 23 Aug 2012 13:01:36 +0200
Subject: [PATCH v2] ARM: imx: add imx5x usb controller clock lookups
In-Reply-To: <1345718328-6547-1-git-send-email-m.grzeschik@pengutronix.de>
References: <1345718328-6547-1-git-send-email-m.grzeschik@pengutronix.de>
Message-ID: <1345719696-25738-1-git-send-email-m.grzeschik@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
---
 arch/arm/mach-imx/clk-imx51-imx53.c |   24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/mach-imx/clk-imx51-imx53.c b/arch/arm/mach-imx/clk-imx51-imx53.c
index 4bdcaa9..7eba6ab 100644
--- a/arch/arm/mach-imx/clk-imx51-imx53.c
+++ b/arch/arm/mach-imx/clk-imx51-imx53.c
@@ -351,6 +351,18 @@ int __init mx51_clocks_init(unsigned long rate_ckil, unsigned long rate_osc,
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
@@ -439,6 +451,18 @@ int __init mx53_clocks_init(unsigned long rate_ckil, unsigned long rate_osc,
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
