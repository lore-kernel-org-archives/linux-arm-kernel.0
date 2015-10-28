From: fcooper@ti.com (Franklin S Cooper Jr)
Date: Wed, 28 Oct 2015 16:02:17 -0500
Subject: [PATCH 2/2] ARM: omap4: hwmod: Remove elm address space from hwmod
 data
In-Reply-To: <1446066137-11527-1-git-send-email-fcooper@ti.com>
References: <1446066137-11527-1-git-send-email-fcooper@ti.com>
Message-ID: <1446066137-11527-3-git-send-email-fcooper@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ELM address information is provided by device tree. No longer need
to include this information within hwmod.

This patch has only been boot tested.

Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c | 10 ----------
 1 file changed, 10 deletions(-)

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
 
-- 
2.6.1
