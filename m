From: abailon@baylibre.com (Alexandre Bailon)
Date: Tue, 24 Jan 2017 11:32:26 +0100
Subject: [PATCH v2] arm: davinci: Make the usb20 clock available to PM runtime
Message-ID: <20170124103226.15377-1-abailon@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add usb20 to the list of clock supported by PM runtime.

Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
Suggested-by: Sekhar Nori <nsekhar@ti.com>
---
 arch/arm/mach-davinci/da830.c     | 2 +-
 arch/arm/mach-davinci/da850.c     | 2 +-
 arch/arm/mach-davinci/usb-da8xx.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-davinci/da830.c b/arch/arm/mach-davinci/da830.c
index 073c458..2cfd9d7 100644
--- a/arch/arm/mach-davinci/da830.c
+++ b/arch/arm/mach-davinci/da830.c
@@ -412,7 +412,7 @@ static struct clk_lookup da830_clks[] = {
 	CLK("davinci-mcasp.0",	NULL,		&mcasp0_clk),
 	CLK("davinci-mcasp.1",	NULL,		&mcasp1_clk),
 	CLK("davinci-mcasp.2",	NULL,		&mcasp2_clk),
-	CLK("musb-da8xx",	"usb20",	&usb20_clk),
+	CLK("musb-da8xx",	NULL,		&usb20_clk),
 	CLK(NULL,		"aemif",	&aemif_clk),
 	CLK(NULL,		"aintc",	&aintc_clk),
 	CLK(NULL,		"secu_mgr",	&secu_mgr_clk),
diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index 9780829..5fe32ae 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -559,7 +559,7 @@ static struct clk_lookup da850_clks[] = {
 	CLK("ti-aemif",		NULL,		&aemif_clk),
 	CLK("davinci-nand.0",	"aemif",	&aemif_nand_clk),
 	CLK("ohci-da8xx",	"usb11",	&usb11_clk),
-	CLK("musb-da8xx",	"usb20",	&usb20_clk),
+	CLK("musb-da8xx",	NULL,		&usb20_clk),
 	CLK("spi_davinci.0",	NULL,		&spi0_clk),
 	CLK("spi_davinci.1",	NULL,		&spi1_clk),
 	CLK("vpif",		NULL,		&vpif_clk),
diff --git a/arch/arm/mach-davinci/usb-da8xx.c b/arch/arm/mach-davinci/usb-da8xx.c
index 9a6af0b..9b66768 100644
--- a/arch/arm/mach-davinci/usb-da8xx.c
+++ b/arch/arm/mach-davinci/usb-da8xx.c
@@ -275,7 +275,7 @@ int __init da8xx_register_usb20_phy_clk(bool use_usb_refclkin)
 	struct clk *parent;
 	int ret;
 
-	usb20_clk = clk_get(&da8xx_usb20_dev.dev, "usb20");
+	usb20_clk = clk_get(&da8xx_usb20_dev.dev, NULL);
 	ret = PTR_ERR_OR_ZERO(usb20_clk);
 	if (ret)
 		return ret;
-- 
2.10.2
