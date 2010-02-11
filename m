From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 11 Feb 2010 11:18:15 -0700
Subject: [PATCH 13/13] OMAP4 clock: drop the ALWAYS_ENABLED clock flag
In-Reply-To: <20100211181236.795.56094.stgit@localhost.localdomain>
References: <20100211181236.795.56094.stgit@localhost.localdomain>
Message-ID: <20100211181810.795.68652.stgit@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Get rid of the ALWAYS_ENABLED clock flag - it doesn't actually do anything.
(The OMAP4 clock autogeneration scripts have been updated accordingly.)

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Rajendra Nayak <rnayak@ti.com>
Cc: Beno?t Cousson <b-cousson@ti.com>
---
 arch/arm/mach-omap2/clock44xx_data.c    |   11 -----------
 arch/arm/plat-omap/include/plat/clock.h |    1 -
 2 files changed, 0 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
index 022f1a7..6deca1e 100644
--- a/arch/arm/mach-omap2/clock44xx_data.c
+++ b/arch/arm/mach-omap2/clock44xx_data.c
@@ -39,42 +39,36 @@ static struct clk extalt_clkin_ck = {
 	.name		= "extalt_clkin_ck",
 	.rate		= 59000000,
 	.ops		= &clkops_null,
-	.flags		= ALWAYS_ENABLED,
 };
 
 static struct clk pad_clks_ck = {
 	.name		= "pad_clks_ck",
 	.rate		= 12000000,
 	.ops		= &clkops_null,
-	.flags		= ALWAYS_ENABLED,
 };
 
 static struct clk pad_slimbus_core_clks_ck = {
 	.name		= "pad_slimbus_core_clks_ck",
 	.rate		= 12000000,
 	.ops		= &clkops_null,
-	.flags		= ALWAYS_ENABLED,
 };
 
 static struct clk secure_32k_clk_src_ck = {
 	.name		= "secure_32k_clk_src_ck",
 	.rate		= 32768,
 	.ops		= &clkops_null,
-	.flags		= ALWAYS_ENABLED,
 };
 
 static struct clk slimbus_clk = {
 	.name		= "slimbus_clk",
 	.rate		= 12000000,
 	.ops		= &clkops_null,
-	.flags		= ALWAYS_ENABLED,
 };
 
 static struct clk sys_32k_ck = {
 	.name		= "sys_32k_ck",
 	.rate		= 32768,
 	.ops		= &clkops_null,
-	.flags		= ALWAYS_ENABLED,
 };
 
 static struct clk virt_12000000_ck = {
@@ -179,35 +173,30 @@ static struct clk sys_clkin_ck = {
 	.clksel_mask	= OMAP4430_SYS_CLKSEL_MASK,
 	.ops		= &clkops_null,
 	.recalc		= &omap2_clksel_recalc,
-	.flags		= ALWAYS_ENABLED,
 };
 
 static struct clk utmi_phy_clkout_ck = {
 	.name		= "utmi_phy_clkout_ck",
 	.rate		= 12000000,
 	.ops		= &clkops_null,
-	.flags		= ALWAYS_ENABLED,
 };
 
 static struct clk xclk60mhsp1_ck = {
 	.name		= "xclk60mhsp1_ck",
 	.rate		= 12000000,
 	.ops		= &clkops_null,
-	.flags		= ALWAYS_ENABLED,
 };
 
 static struct clk xclk60mhsp2_ck = {
 	.name		= "xclk60mhsp2_ck",
 	.rate		= 12000000,
 	.ops		= &clkops_null,
-	.flags		= ALWAYS_ENABLED,
 };
 
 static struct clk xclk60motg_ck = {
 	.name		= "xclk60motg_ck",
 	.rate		= 60000000,
 	.ops		= &clkops_null,
-	.flags		= ALWAYS_ENABLED,
 };
 
 /* Module clocks and DPLL outputs */
diff --git a/arch/arm/plat-omap/include/plat/clock.h b/arch/arm/plat-omap/include/plat/clock.h
index dcfdcd6..5e1c035 100644
--- a/arch/arm/plat-omap/include/plat/clock.h
+++ b/arch/arm/plat-omap/include/plat/clock.h
@@ -193,7 +193,6 @@ extern const struct clkops clkops_null;
 #define CLOCK_NO_IDLE_PARENT	(1 << 2)
 #define ENABLE_ON_INIT		(1 << 3)	/* Enable upon framework init */
 #define INVERT_ENABLE		(1 << 4)	/* 0 enables, 1 disables */
-#define ALWAYS_ENABLED		(1 << 5)
 
 /* Clksel_rate flags */
 #define DEFAULT_RATE		(1 << 0)
