From: m.grzeschik@pengutronix.de (Michael Grzeschik)
Date: Thu, 15 Nov 2012 15:00:12 +0100
Subject: [PATCH 2/4] ARM: imx: add imx5x usbmisc clock lookups
In-Reply-To: <1352988014-14769-1-git-send-email-m.grzeschik@pengutronix.de>
References: <1352988014-14769-1-git-send-email-m.grzeschik@pengutronix.de>
Message-ID: <1352988014-14769-3-git-send-email-m.grzeschik@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
---
 arch/arm/mach-imx/clk-imx51-imx53.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/mach-imx/clk-imx51-imx53.c b/arch/arm/mach-imx/clk-imx51-imx53.c
index 3edd11c..33c3c9b 100644
--- a/arch/arm/mach-imx/clk-imx51-imx53.c
+++ b/arch/arm/mach-imx/clk-imx51-imx53.c
@@ -365,6 +365,9 @@ int __init mx51_clocks_init(unsigned long rate_ckil, unsigned long rate_osc,
 	clk_register_clkdev(clk[usboh3_per_gate], "per", "73f80000.usb");
 	clk_register_clkdev(clk[usboh3_gate], "ipg", "73f80000.usb");
 	clk_register_clkdev(clk[usboh3_gate], "ahb", "73f80000.usb");
+	clk_register_clkdev(clk[usboh3_per_gate], "per", "73f80800.usbmisc");
+	clk_register_clkdev(clk[usboh3_gate], "ipg", "73f80800.usbmisc");
+	clk_register_clkdev(clk[usboh3_gate], "ahb", "73f80800.usbmisc");
 	clk_register_clkdev(clk[usb_phy_gate], "phy", "mxc-ehci.0");
 	clk_register_clkdev(clk[esdhc1_ipg_gate], "ipg", "sdhci-esdhc-imx51.0");
 	clk_register_clkdev(clk[dummy], "ahb", "sdhci-esdhc-imx51.0");
@@ -470,6 +473,9 @@ int __init mx53_clocks_init(unsigned long rate_ckil, unsigned long rate_osc,
 	clk_register_clkdev(clk[usboh3_per_gate], "per", "53f80000.usb");
 	clk_register_clkdev(clk[usboh3_gate], "ipg", "53f80000.usb");
 	clk_register_clkdev(clk[usboh3_gate], "ahb", "53f80000.usb");
+	clk_register_clkdev(clk[usboh3_per_gate], "per", "53f80800.usbmisc");
+	clk_register_clkdev(clk[usboh3_gate], "ipg", "53f80800.usbmisc");
+	clk_register_clkdev(clk[usboh3_gate], "ahb", "53f80800.usbmisc");
 	clk_register_clkdev(clk[usb_phy1_gate], "usb_phy1", "mxc-ehci.0");
 	clk_register_clkdev(clk[esdhc1_ipg_gate], "ipg", "sdhci-esdhc-imx53.0");
 	clk_register_clkdev(clk[dummy], "ahb", "sdhci-esdhc-imx53.0");
-- 
1.7.10.4
