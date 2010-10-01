From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Fri,  1 Oct 2010 14:29:41 -0700
Subject: [PATCH 17/47] DA850: Split MMCSD clock into two to support both MMCSD
	peripherals
In-Reply-To: <1285968611-26890-1-git-send-email-khilman@deeprootsystems.com>
References: <1285968611-26890-1-git-send-email-khilman@deeprootsystems.com>
Message-ID: <1285968611-26890-18-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Juha Kuikka <juha.kuikka@elektrobit.com>

Split mmcsd_clk into mmcsd0_clk and mmcsd1_clk and add davinci_mmc.1
in preparation for adding support for MMCSD1 peripheral in DA850.

Signed-off-by: Juha Kuikka <juha.kuikka@elektrobit.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-davinci/da850.c |   14 +++++++++++---
 1 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index c2a3ce5..63916b9 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -325,12 +325,19 @@ static struct clk lcdc_clk = {
 	.gpsc		= 1,
 };
 
-static struct clk mmcsd_clk = {
-	.name		= "mmcsd",
+static struct clk mmcsd0_clk = {
+	.name		= "mmcsd0",
 	.parent		= &pll0_sysclk2,
 	.lpsc		= DA8XX_LPSC0_MMC_SD,
 };
 
+static struct clk mmcsd1_clk = {
+	.name		= "mmcsd1",
+	.parent		= &pll0_sysclk2,
+	.lpsc		= DA850_LPSC1_MMC_SD1,
+	.gpsc		= 1,
+};
+
 static struct clk aemif_clk = {
 	.name		= "aemif",
 	.parent		= &pll0_sysclk3,
@@ -377,7 +384,8 @@ static struct clk_lookup da850_clks[] = {
 	CLK("davinci_emac.1",	NULL,		&emac_clk),
 	CLK("davinci-mcasp.0",	NULL,		&mcasp_clk),
 	CLK("da8xx_lcdc.0",	NULL,		&lcdc_clk),
-	CLK("davinci_mmc.0",	NULL,		&mmcsd_clk),
+	CLK("davinci_mmc.0",	NULL,		&mmcsd0_clk),
+	CLK("davinci_mmc.1",	NULL,		&mmcsd1_clk),
 	CLK(NULL,		"aemif",	&aemif_clk),
 	CLK(NULL,		NULL,		NULL),
 };
-- 
1.7.2.1
