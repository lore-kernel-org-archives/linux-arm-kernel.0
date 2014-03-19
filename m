From: l.stach@pengutronix.de (Lucas Stach)
Date: Wed, 19 Mar 2014 15:49:22 +0100
Subject: [PATCH 1/3] ARM: dts: i.MX5: Remove outdated VPU clock lookups
Message-ID: <1395240564-25940-1-git-send-email-l.stach@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Philipp Zabel <p.zabel@pengutronix.de>

CODA7 clock lookups are now defined in the device tree.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 arch/arm/mach-imx/clk-imx51-imx53.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/mach-imx/clk-imx51-imx53.c b/arch/arm/mach-imx/clk-imx51-imx53.c
index 19fca1fdc6fe..b53c5ca7650a 100644
--- a/arch/arm/mach-imx/clk-imx51-imx53.c
+++ b/arch/arm/mach-imx/clk-imx51-imx53.c
@@ -438,7 +438,6 @@ int __init mx51_clocks_init(unsigned long rate_ckil, unsigned long rate_osc,
 
 	clk_register_clkdev(clk[IMX5_CLK_HSI2C_GATE], NULL, "imx21-i2c.2");
 	clk_register_clkdev(clk[IMX5_CLK_MX51_MIPI], "mipi_hsp", NULL);
-	clk_register_clkdev(clk[IMX5_CLK_VPU_GATE], NULL, "imx51-vpu.0");
 	clk_register_clkdev(clk[IMX5_CLK_FEC_GATE], NULL, "imx27-fec.0");
 	clk_register_clkdev(clk[IMX5_CLK_USB_PHY_GATE], "phy", "mxc-ehci.0");
 	clk_register_clkdev(clk[IMX5_CLK_ESDHC1_IPG_GATE], "ipg", "sdhci-esdhc-imx51.0");
@@ -563,7 +562,6 @@ static void __init mx53_clocks_init(struct device_node *np)
 
 	mx5_clocks_common_init(0, 0, 0, 0);
 
-	clk_register_clkdev(clk[IMX5_CLK_VPU_GATE], NULL, "imx53-vpu.0");
 	clk_register_clkdev(clk[IMX5_CLK_I2C3_GATE], NULL, "imx21-i2c.2");
 	clk_register_clkdev(clk[IMX5_CLK_FEC_GATE], NULL, "imx25-fec.0");
 	clk_register_clkdev(clk[IMX5_CLK_USB_PHY1_GATE], "usb_phy1", "mxc-ehci.0");
-- 
1.9.0
