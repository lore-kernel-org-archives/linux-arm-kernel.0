From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Fri,  9 Nov 2012 15:00:24 +0100
Subject: [PATCH 5/6] ARM i.MX: rename ssi1 clock for imx27
In-Reply-To: <1352469625-32024-1-git-send-email-s.trumtrar@pengutronix.de>
References: <1352469625-32024-1-git-send-email-s.trumtrar@pengutronix.de>
Message-ID: <1352469625-32024-6-git-send-email-s.trumtrar@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
 arch/arm/mach-imx/clk-imx27.c |    2 +-
 arch/arm/mach-imx/imx27-dt.c  |    1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/clk-imx27.c b/arch/arm/mach-imx/clk-imx27.c
index 366e5d5..d269532 100644
--- a/arch/arm/mach-imx/clk-imx27.c
+++ b/arch/arm/mach-imx/clk-imx27.c
@@ -236,7 +236,7 @@ int __init mx27_clocks_init(unsigned long fref)
 	clk_register_clkdev(clk[usb_div], "per", "mxc-ehci.2");
 	clk_register_clkdev(clk[usb_ipg_gate], "ipg", "mxc-ehci.2");
 	clk_register_clkdev(clk[usb_ahb_gate], "ahb", "mxc-ehci.2");
-	clk_register_clkdev(clk[ssi1_ipg_gate], NULL, "imx-ssi.0");
+	clk_register_clkdev(clk[ssi1_ipg_gate], NULL, "10010000.ssi");
 	clk_register_clkdev(clk[ssi2_ipg_gate], NULL, "imx-ssi.1");
 	clk_register_clkdev(clk[nfc_baud_gate], NULL, "mxc_nand.0");
 	clk_register_clkdev(clk[vpu_baud_gate], "per", "coda-imx27.0");
diff --git a/arch/arm/mach-imx/imx27-dt.c b/arch/arm/mach-imx/imx27-dt.c
index e80d523..60eed17 100644
--- a/arch/arm/mach-imx/imx27-dt.c
+++ b/arch/arm/mach-imx/imx27-dt.c
@@ -29,6 +29,7 @@ static const struct of_dev_auxdata imx27_auxdata_lookup[] __initconst = {
 	OF_DEV_AUXDATA("fsl,imx27-cspi", MX27_CSPI3_BASE_ADDR, "imx27-cspi.2", NULL),
 	OF_DEV_AUXDATA("fsl,imx27-wdt", MX27_WDOG_BASE_ADDR, "imx2-wdt.0", NULL),
 	OF_DEV_AUXDATA("fsl,imx27-nand", MX27_NFC_BASE_ADDR, "mxc_nand.0", NULL),
+	OF_DEV_AUXDATA("fsl,imx21-ssi", MX27_SSI1_BASE_ADDR, "10010000.ssi", NULL),
 	{ /* sentinel */ }
 };
 
-- 
1.7.10.4
