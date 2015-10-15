From: fcooper@ti.com (Franklin S Cooper Jr)
Date: Thu, 15 Oct 2015 11:27:40 -0500
Subject: [PATCH 1/2 v2] ARM: DRA7/335x/437x/OMAP4: hwmod: Remove elm address
 space from hwmod data
Message-ID: <1444926461-16092-1-git-send-email-fcooper@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ELM address information is provided by device tree. No longer need
to include this information within hwmod.

Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
---
Version 2 changes:
Removing elm addr entries also for 335x,437x and omap4 hwmod

 arch/arm/mach-omap2/omap_hwmod_33xx_43xx_interconnect_data.c | 10 ----------
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c                   | 10 ----------
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c                    | 10 ----------
 3 files changed, 30 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_interconnect_data.c b/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_interconnect_data.c
index 8f5989d..9ba431c 100644
--- a/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_interconnect_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_interconnect_data.c
@@ -152,20 +152,10 @@ struct omap_hwmod_ocp_if am33xx_cpgmac0__mdio = {
 	.user		= OCP_USER_MPU,
 };
 
-static struct omap_hwmod_addr_space am33xx_elm_addr_space[] = {
-	{
-		.pa_start	= 0x48080000,
-		.pa_end		= 0x48080000 + SZ_8K - 1,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
-
 struct omap_hwmod_ocp_if am33xx_l4_ls__elm = {
 	.master		= &am33xx_l4_ls_hwmod,
 	.slave		= &am33xx_elm_hwmod,
 	.clk		= "l4ls_gclk",
-	.addr		= am33xx_elm_addr_space,
 	.user		= OCP_USER_MPU,
 };
 
diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 43eebf2..8f13f4a 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -3915,21 +3915,11 @@ static struct omap_hwmod_ocp_if omap44xx_l4_per__dss_venc = {
 	.user		= OCP_USER_MPU,
 };
 
-static struct omap_hwmod_addr_space omap44xx_elm_addrs[] = {
-	{
-		.pa_start	= 0x48078000,
-		.pa_end		= 0x48078fff,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
-
 /* l4_per -> elm */
 static struct omap_hwmod_ocp_if omap44xx_l4_per__elm = {
 	.master		= &omap44xx_l4_per_hwmod,
 	.slave		= &omap44xx_elm_hwmod,
 	.clk		= "l4_div_ck",
-	.addr		= omap44xx_elm_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
diff --git a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
index 562247b..ad2cc7a 100644
--- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
@@ -2566,21 +2566,11 @@ static struct omap_hwmod_ocp_if dra7xx_l3_main_1__hdmi = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-static struct omap_hwmod_addr_space dra7xx_elm_addrs[] = {
-	{
-		.pa_start	= 0x48078000,
-		.pa_end		= 0x48078fff,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
-
 /* l4_per1 -> elm */
 static struct omap_hwmod_ocp_if dra7xx_l4_per1__elm = {
 	.master		= &dra7xx_l4_per1_hwmod,
 	.slave		= &dra7xx_elm_hwmod,
 	.clk		= "l3_iclk_div",
-	.addr		= dra7xx_elm_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-- 
2.6.1
