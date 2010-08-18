From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 18 Aug 2010 23:01:13 +0900
Subject: [PATCH 03/14] ARM: S5PV310: Adds clkset_aclk for removing
	clkset_aclk_xxx
In-Reply-To: <1282140084-10265-1-git-send-email-kgene.kim@samsung.com>
References: <1282140084-10265-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1282140084-10265-4-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds 'clkset_aclk' to use commonly. And removed struct
clksrc_sources clkset_aclk_200, clkset_aclk_100, clkset_aclk_160,
and clkset_aclk_133.

Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s5pv310/clock.c |   25 +++++--------------------
 1 files changed, 5 insertions(+), 20 deletions(-)

diff --git a/arch/arm/mach-s5pv310/clock.c b/arch/arm/mach-s5pv310/clock.c
index e3098d5..d909515 100644
--- a/arch/arm/mach-s5pv310/clock.c
+++ b/arch/arm/mach-s5pv310/clock.c
@@ -133,7 +133,7 @@ static struct clk *clkset_aclk_top_list[] = {
 	[1] = &clk_mout_apll.clk,
 };
 
-static struct clksrc_sources clkset_aclk_200 = {
+static struct clksrc_sources clkset_aclk = {
 	.sources	= clkset_aclk_top_list,
 	.nr_sources	= ARRAY_SIZE(clkset_aclk_top_list),
 };
@@ -143,52 +143,37 @@ static struct clksrc_clk clk_aclk_200 = {
 		.name		= "aclk_200",
 		.id		= -1,
 	},
-	.sources	= &clkset_aclk_200,
+	.sources	= &clkset_aclk,
 	.reg_src	= { .reg = S5P_CLKSRC_TOP0, .shift = 12, .size = 1 },
 	.reg_div	= { .reg = S5P_CLKDIV_TOP, .shift = 0, .size = 3 },
 };
 
-static struct clksrc_sources clkset_aclk_100 = {
-	.sources	= clkset_aclk_top_list,
-	.nr_sources	= ARRAY_SIZE(clkset_aclk_top_list),
-};
-
 static struct clksrc_clk clk_aclk_100 = {
 	.clk	= {
 		.name		= "aclk_100",
 		.id		= -1,
 	},
-	.sources	= &clkset_aclk_100,
+	.sources	= &clkset_aclk,
 	.reg_src	= { .reg = S5P_CLKSRC_TOP0, .shift = 16, .size = 1 },
 	.reg_div	= { .reg = S5P_CLKDIV_TOP, .shift = 4, .size = 4 },
 };
 
-static struct clksrc_sources clkset_aclk_160 = {
-	.sources	= clkset_aclk_top_list,
-	.nr_sources	= ARRAY_SIZE(clkset_aclk_top_list),
-};
-
 static struct clksrc_clk clk_aclk_160 = {
 	.clk	= {
 		.name		= "aclk_160",
 		.id		= -1,
 	},
-	.sources	= &clkset_aclk_160,
+	.sources	= &clkset_aclk,
 	.reg_src	= { .reg = S5P_CLKSRC_TOP0, .shift = 20, .size = 1 },
 	.reg_div	= { .reg = S5P_CLKDIV_TOP, .shift = 8, .size = 3 },
 };
 
-static struct clksrc_sources clkset_aclk_133 = {
-	.sources	= clkset_aclk_top_list,
-	.nr_sources	= ARRAY_SIZE(clkset_aclk_top_list),
-};
-
 static struct clksrc_clk clk_aclk_133 = {
 	.clk	= {
 		.name		= "aclk_133",
 		.id		= -1,
 	},
-	.sources	= &clkset_aclk_133,
+	.sources	= &clkset_aclk,
 	.reg_src	= { .reg = S5P_CLKSRC_TOP0, .shift = 24, .size = 1 },
 	.reg_div	= { .reg = S5P_CLKDIV_TOP, .shift = 12, .size = 3 },
 };
-- 
1.6.2.5
