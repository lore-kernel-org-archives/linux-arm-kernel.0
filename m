From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sat, 10 Mar 2012 02:19:06 -0800
Subject: [PATCH 2/5] ARM: EXYNOS: use static declaration on regarding clock
In-Reply-To: <1331374749-23256-1-git-send-email-kgene.kim@samsung.com>
References: <1331374749-23256-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1331374749-23256-3-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch uses static declaration struct which is not
used in other file and re-arrange with group in header
file.

Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-exynos/clock-exynos4.c |   18 +++++++++---------
 arch/arm/mach-exynos/clock-exynos4.h |   13 +------------
 2 files changed, 10 insertions(+), 21 deletions(-)

diff --git a/arch/arm/mach-exynos/clock-exynos4.c b/arch/arm/mach-exynos/clock-exynos4.c
index 1d6d64f..7dde81b 100644
--- a/arch/arm/mach-exynos/clock-exynos4.c
+++ b/arch/arm/mach-exynos/clock-exynos4.c
@@ -95,21 +95,21 @@ static struct sleep_save exynos4_clock_save[] = {
 };
 #endif
 
-struct clk clk_sclk_hdmi27m = {
+static struct clk clk_sclk_hdmi27m = {
 	.name		= "sclk_hdmi27m",
 	.rate		= 27000000,
 };
 
-struct clk clk_sclk_hdmiphy = {
+static struct clk clk_sclk_hdmiphy = {
 	.name		= "sclk_hdmiphy",
 };
 
-struct clk clk_sclk_usbphy0 = {
+static struct clk clk_sclk_usbphy0 = {
 	.name		= "sclk_usbphy0",
 	.rate		= 27000000,
 };
 
-struct clk clk_sclk_usbphy1 = {
+static struct clk clk_sclk_usbphy1 = {
 	.name		= "sclk_usbphy1",
 };
 
@@ -218,7 +218,7 @@ static struct clksrc_clk clk_mout_apll = {
 	.reg_src = { .reg = S5P_CLKSRC_CPU, .shift = 0, .size = 1 },
 };
 
-struct clksrc_clk clk_sclk_apll = {
+static struct clksrc_clk clk_sclk_apll = {
 	.clk	= {
 		.name		= "sclk_apll",
 		.parent		= &clk_mout_apll.clk,
@@ -226,7 +226,7 @@ struct clksrc_clk clk_sclk_apll = {
 	.reg_div = { .reg = S5P_CLKDIV_CPU, .shift = 24, .size = 3 },
 };
 
-struct clksrc_clk clk_mout_epll = {
+static struct clksrc_clk clk_mout_epll = {
 	.clk	= {
 		.name		= "mout_epll",
 	},
@@ -310,7 +310,7 @@ static struct clksrc_clk clk_periphclk = {
 
 /* Core list of CMU_CORE side */
 
-struct clk *clkset_corebus_list[] = {
+static struct clk *clkset_corebus_list[] = {
 	[0] = &clk_mout_mpll.clk,
 	[1] = &clk_sclk_apll.clk,
 };
@@ -375,7 +375,7 @@ struct clk *clkset_aclk_top_list[] = {
 	[1] = &clk_sclk_apll.clk,
 };
 
-struct clksrc_sources clkset_aclk = {
+static struct clksrc_sources clkset_aclk = {
 	.sources	= clkset_aclk_top_list,
 	.nr_sources	= ARRAY_SIZE(clkset_aclk_top_list),
 };
@@ -446,7 +446,7 @@ static struct clksrc_sources clkset_sclk_vpll = {
 	.nr_sources	= ARRAY_SIZE(clkset_sclk_vpll_list),
 };
 
-struct clksrc_clk clk_sclk_vpll = {
+static struct clksrc_clk clk_sclk_vpll = {
 	.clk	= {
 		.name		= "sclk_vpll",
 	},
diff --git a/arch/arm/mach-exynos/clock-exynos4.h b/arch/arm/mach-exynos/clock-exynos4.h
index f64e9f7..d2ef305 100644
--- a/arch/arm/mach-exynos/clock-exynos4.h
+++ b/arch/arm/mach-exynos/clock-exynos4.h
@@ -15,25 +15,14 @@
 
 #include <linux/clk.h>
 
-extern struct clk clk_sclk_hdmi27m;
-extern struct clk clk_sclk_usbphy0;
-extern struct clk clk_sclk_usbphy1;
-extern struct clk clk_sclk_hdmiphy;
-
-extern struct clksrc_clk clk_sclk_apll;
 extern struct clksrc_clk clk_mout_mpll;
 extern struct clksrc_clk clk_aclk_133;
-extern struct clksrc_clk clk_mout_epll;
-extern struct clksrc_clk clk_sclk_vpll;
 
-extern struct clk *clkset_corebus_list[];
 extern struct clksrc_sources clkset_mout_corebus;
+extern struct clksrc_sources clkset_group;
 
 extern struct clk *clkset_aclk_top_list[];
-extern struct clksrc_sources clkset_aclk;
-
 extern struct clk *clkset_group_list[];
-extern struct clksrc_sources clkset_group;
 
 extern int exynos4_clksrc_mask_fsys_ctrl(struct clk *clk, int enable);
 extern int exynos4_clk_ip_fsys_ctrl(struct clk *clk, int enable);
-- 
1.7.4.4
