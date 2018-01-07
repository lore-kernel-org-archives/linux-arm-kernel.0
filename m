From: david@lechnology.com (David Lechner)
Date: Sat,  6 Jan 2018 21:19:52 -0600
Subject: [PATCH 3/3] ARM: da8xx: remove con_id from USB clocks
In-Reply-To: <1515295192-17883-1-git-send-email-david@lechnology.com>
References: <1515295192-17883-1-git-send-email-david@lechnology.com>
Message-ID: <1515295192-17883-4-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is only one clock each for "musb-da8xx" and "ohci-da8xx", so we
do not the the con_id. Removing them  will also prevent needing an
unnecessary device tree property when device tree bindings are added
for clocks.

Signed-off-by: David Lechner <david@lechnology.com>
---
 arch/arm/mach-davinci/da830.c | 4 ++--
 arch/arm/mach-davinci/da850.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-davinci/da830.c b/arch/arm/mach-davinci/da830.c
index ed0b700..57ab18c 100644
--- a/arch/arm/mach-davinci/da830.c
+++ b/arch/arm/mach-davinci/da830.c
@@ -417,7 +417,7 @@ static struct clk_lookup da830_clks[] = {
 	CLK("davinci-mcasp.0",	NULL,		&mcasp0_clk),
 	CLK("davinci-mcasp.1",	NULL,		&mcasp1_clk),
 	CLK("davinci-mcasp.2",	NULL,		&mcasp2_clk),
-	CLK("musb-da8xx",	"usb20",	&usb20_clk),
+	CLK("musb-da8xx",	NULL,		&usb20_clk),
 	CLK("cppi41-dmaengine",	NULL,		&cppi41_clk),
 	CLK(NULL,		"aemif",	&aemif_clk),
 	CLK(NULL,		"aintc",	&aintc_clk),
@@ -426,7 +426,7 @@ static struct clk_lookup da830_clks[] = {
 	CLK("davinci_mdio.0",   "fck",          &emac_clk),
 	CLK(NULL,		"gpio",		&gpio_clk),
 	CLK("i2c_davinci.2",	NULL,		&i2c1_clk),
-	CLK("ohci-da8xx",	"usb11",	&usb11_clk),
+	CLK("ohci-da8xx",	NULL,	&usb11_clk),
 	CLK(NULL,		"emif3",	&emif3_clk),
 	CLK(NULL,		"arm",		&arm_clk),
 	CLK(NULL,		"rmii",		&rmii_clk),
diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index 04a58a3..aa37cbd 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -563,8 +563,8 @@ static struct clk_lookup da850_clks[] = {
 	CLK("da830-mmc.1",	NULL,		&mmcsd1_clk),
 	CLK("ti-aemif",		NULL,		&aemif_clk),
 	CLK("davinci-nand.0",	"aemif",	&aemif_nand_clk),
-	CLK("ohci-da8xx",	"usb11",	&usb11_clk),
-	CLK("musb-da8xx",	"usb20",	&usb20_clk),
+	CLK("ohci-da8xx",	NULL,		&usb11_clk),
+	CLK("musb-da8xx",	NULL,		&usb20_clk),
 	CLK("cppi41-dmaengine",	NULL,		&cppi41_clk),
 	CLK("spi_davinci.0",	NULL,		&spi0_clk),
 	CLK("spi_davinci.1",	NULL,		&spi1_clk),
-- 
2.7.4
