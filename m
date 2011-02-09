From: michael.williamson@criticallink.com (Michael Williamson)
Date: Wed,  9 Feb 2011 08:11:50 -0500
Subject: [PATCH v2 2/6] davinci: da850: add spi device clock definitions
In-Reply-To: <1297257114-764-1-git-send-email-michael.williamson@criticallink.com>
References: <1297257114-764-1-git-send-email-michael.williamson@criticallink.com>
Message-ID: <1297257114-764-3-git-send-email-michael.williamson@criticallink.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add spi clock information for da850.

Signed-off-by: Michael Williamson <michael.williamson@criticallink.com>
---
 arch/arm/mach-davinci/da850.c |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index 3443d97..68fe4c2 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -359,6 +359,20 @@ static struct clk usb20_clk = {
 	.gpsc		= 1,
 };
 
+static struct clk spi0_clk = {
+	.name		= "spi0",
+	.parent		= &pll0_sysclk2,
+	.lpsc		= DA8XX_LPSC0_SPI0,
+};
+
+static struct clk spi1_clk = {
+	.name		= "spi1",
+	.parent		= &pll0_sysclk2,
+	.lpsc		= DA8XX_LPSC1_SPI1,
+	.gpsc		= 1,
+	.flags		= DA850_CLK_ASYNC3,
+};
+
 static struct clk_lookup da850_clks[] = {
 	CLK(NULL,		"ref",		&ref_clk),
 	CLK(NULL,		"pll0",		&pll0_clk),
@@ -403,6 +417,8 @@ static struct clk_lookup da850_clks[] = {
 	CLK(NULL,		"aemif",	&aemif_clk),
 	CLK(NULL,		"usb11",	&usb11_clk),
 	CLK(NULL,		"usb20",	&usb20_clk),
+	CLK("spi_davinci.0",	NULL,		&spi0_clk),
+	CLK("spi_davinci.1",	NULL,		&spi1_clk),
 	CLK(NULL,		NULL,		NULL),
 };
 
-- 
1.7.0.4
