From: david@lechnology.com (David Lechner)
Date: Wed, 26 Oct 2016 19:18:16 -0500
Subject: [PATCH v7 2/4] ARM: davinci: da8xx: Add USB device names to clock
 lookup tables
In-Reply-To: <1477527498-21930-1-git-send-email-david@lechnology.com>
References: <1477527498-21930-1-git-send-email-david@lechnology.com>
Message-ID: <1477527498-21930-3-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds device names for the SoC USB devices to the clock lookup tables
in da830.c and da850.c.

Also add the USB device names to the da850_auxdata_lookup[] table.

Signed-off-by: David Lechner <david@lechnology.com>
---

This is a new patch setting up clock lookup names that will be used in "ARM:
davinci: da8xx: add usb phy clocks"


 arch/arm/mach-davinci/da830.c    | 4 ++--
 arch/arm/mach-davinci/da850.c    | 4 ++--
 arch/arm/mach-davinci/da8xx-dt.c | 2 ++
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-davinci/da830.c b/arch/arm/mach-davinci/da830.c
index 426fd74..41459bd 100644
--- a/arch/arm/mach-davinci/da830.c
+++ b/arch/arm/mach-davinci/da830.c
@@ -412,7 +412,7 @@ static struct clk_lookup da830_clks[] = {
 	CLK("davinci-mcasp.0",	NULL,		&mcasp0_clk),
 	CLK("davinci-mcasp.1",	NULL,		&mcasp1_clk),
 	CLK("davinci-mcasp.2",	NULL,		&mcasp2_clk),
-	CLK(NULL,		"usb20",	&usb20_clk),
+	CLK("musb-da8xx",	"usb20",	&usb20_clk),
 	CLK(NULL,		"aemif",	&aemif_clk),
 	CLK(NULL,		"aintc",	&aintc_clk),
 	CLK(NULL,		"secu_mgr",	&secu_mgr_clk),
@@ -420,7 +420,7 @@ static struct clk_lookup da830_clks[] = {
 	CLK("davinci_mdio.0",   "fck",          &emac_clk),
 	CLK(NULL,		"gpio",		&gpio_clk),
 	CLK("i2c_davinci.2",	NULL,		&i2c1_clk),
-	CLK(NULL,		"usb11",	&usb11_clk),
+	CLK("ohci",		"usb11",	&usb11_clk),
 	CLK(NULL,		"emif3",	&emif3_clk),
 	CLK(NULL,		"arm",		&arm_clk),
 	CLK(NULL,		"rmii",		&rmii_clk),
diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index 6b78a8f..47084be 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -503,8 +503,8 @@ static struct clk_lookup da850_clks[] = {
 	CLK("da830-mmc.1",	NULL,		&mmcsd1_clk),
 	CLK("ti-aemif",		NULL,		&aemif_clk),
 	CLK(NULL,		"aemif",	&aemif_clk),
-	CLK(NULL,		"usb11",	&usb11_clk),
-	CLK(NULL,		"usb20",	&usb20_clk),
+	CLK("ohci",		"usb11",	&usb11_clk),
+	CLK("musb-da8xx",	"usb20",	&usb20_clk),
 	CLK("spi_davinci.0",	NULL,		&spi0_clk),
 	CLK("spi_davinci.1",	NULL,		&spi1_clk),
 	CLK("vpif",		NULL,		&vpif_clk),
diff --git a/arch/arm/mach-davinci/da8xx-dt.c b/arch/arm/mach-davinci/da8xx-dt.c
index b03ad19..aec569f9 100644
--- a/arch/arm/mach-davinci/da8xx-dt.c
+++ b/arch/arm/mach-davinci/da8xx-dt.c
@@ -39,6 +39,8 @@ static struct of_dev_auxdata da850_auxdata_lookup[] __initdata = {
 	OF_DEV_AUXDATA("ti,da830-mcasp-audio", 0x01d00000, "davinci-mcasp.0", NULL),
 	OF_DEV_AUXDATA("ti,da850-aemif", 0x68000000, "ti-aemif", NULL),
 	OF_DEV_AUXDATA("ti,da850-tilcdc", 0x01e13000, "da8xx_lcdc.0", NULL),
+	OF_DEV_AUXDATA("ti,da830-ohci", 0x01e25000, "ohci", NULL),
+	OF_DEV_AUXDATA("ti,da830-musb", 0x01e00000, "musb-da8xx", NULL),
 	{}
 };
 
-- 
2.7.4
