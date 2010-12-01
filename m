From: vm.rod25@gmail.com (vm.rod25 at gmail.com)
Date: Wed,  1 Dec 2010 13:32:28 -0600
Subject: [PATCH v9 5/6] davinci: USB clocks for Omapl138-Hawkboard
In-Reply-To: <1291231949-23835-1-git-send-email-vm.rod25@gmail.com>
References: <1291231949-23835-1-git-send-email-vm.rod25@gmail.com>
Message-ID: <1291231949-23835-6-git-send-email-vm.rod25@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Victor Rodriguez <victor.rodriguez@sasken.com>

This patch adds USB1.1 and USB2.0 clocks for the Hawkboard-L138 system

Signed-off-by: Victor Rodriguez <victor.rodriguez@sasken.com>
Tested-by: Rene Gonzalez <renegs.2378@gmail.com>
---
 arch/arm/mach-davinci/da850.c |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index 80803fa..93a4df4 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -345,6 +345,20 @@ static struct clk aemif_clk = {
 	.flags		= ALWAYS_ENABLED,
 };
 
+static struct clk usb11_clk = {
+	.name		= "usb11",
+	.parent		= &pll0_sysclk4,
+	.lpsc		= DA8XX_LPSC1_USB11,
+	.gpsc		= 1,
+};
+
+static struct clk usb20_clk = {
+	.name		= "usb20",
+	.parent		= &pll0_sysclk2,
+	.lpsc		= DA8XX_LPSC1_USB20,
+	.gpsc		= 1,
+};
+
 static struct clk_lookup da850_clks[] = {
 	CLK(NULL,		"ref",		&ref_clk),
 	CLK(NULL,		"pll0",		&pll0_clk),
@@ -387,6 +401,8 @@ static struct clk_lookup da850_clks[] = {
 	CLK("davinci_mmc.0",	NULL,		&mmcsd0_clk),
 	CLK("davinci_mmc.1",	NULL,		&mmcsd1_clk),
 	CLK(NULL,		"aemif",	&aemif_clk),
+	CLK(NULL,		"usb11",	&usb11_clk),
+	CLK(NULL,		"usb20",	&usb20_clk),
 	CLK(NULL,		NULL,		NULL),
 };
 
-- 
1.7.0.4
