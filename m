From: b.van.den.berg.nl@gmail.com (Bas van den Berg)
Date: Fri, 13 Jan 2012 13:48:13 +0100
Subject: [PATCH] ARM: mach-davinci: removed un-existing pll1_sysclk4-7
 clock domains
Message-ID: <20120113124811.GA9223@altenpts-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

sysclk4-7 only exist for pll0. for pll1 sysclk1-3 exist.

Signed-off-by: Bas van den Berg <b.van.den.berg.nl@gmail.com>
---
 arch/arm/mach-davinci/da850.c |   32 --------------------------------
 1 files changed, 0 insertions(+), 32 deletions(-)

diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index 0ed7fdb..992c4c4 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -153,34 +153,6 @@ static struct clk pll1_sysclk3 = {
 	.div_reg	= PLLDIV3,
 };
 
-static struct clk pll1_sysclk4 = {
-	.name		= "pll1_sysclk4",
-	.parent		= &pll1_clk,
-	.flags		= CLK_PLL,
-	.div_reg	= PLLDIV4,
-};
-
-static struct clk pll1_sysclk5 = {
-	.name		= "pll1_sysclk5",
-	.parent		= &pll1_clk,
-	.flags		= CLK_PLL,
-	.div_reg	= PLLDIV5,
-};
-
-static struct clk pll1_sysclk6 = {
-	.name		= "pll0_sysclk6",
-	.parent		= &pll0_clk,
-	.flags		= CLK_PLL,
-	.div_reg	= PLLDIV6,
-};
-
-static struct clk pll1_sysclk7 = {
-	.name		= "pll1_sysclk7",
-	.parent		= &pll1_clk,
-	.flags		= CLK_PLL,
-	.div_reg	= PLLDIV7,
-};
-
 static struct clk i2c0_clk = {
 	.name		= "i2c0",
 	.parent		= &pll0_aux_clk,
@@ -397,10 +369,6 @@ static struct clk_lookup da850_clks[] = {
 	CLK(NULL,		"pll1_aux",	&pll1_aux_clk),
 	CLK(NULL,		"pll1_sysclk2",	&pll1_sysclk2),
 	CLK(NULL,		"pll1_sysclk3",	&pll1_sysclk3),
-	CLK(NULL,		"pll1_sysclk4",	&pll1_sysclk4),
-	CLK(NULL,		"pll1_sysclk5",	&pll1_sysclk5),
-	CLK(NULL,		"pll1_sysclk6",	&pll1_sysclk6),
-	CLK(NULL,		"pll1_sysclk7",	&pll1_sysclk7),
 	CLK("i2c_davinci.1",	NULL,		&i2c0_clk),
 	CLK(NULL,		"timer0",	&timerp64_0_clk),
 	CLK("watchdog",		NULL,		&timerp64_1_clk),
-- 
1.7.0.4
