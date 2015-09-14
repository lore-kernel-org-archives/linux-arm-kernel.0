From: s-anna@ti.com (Suman Anna)
Date: Mon, 14 Sep 2015 15:49:20 -0500
Subject: [PATCH 1/2] ARM: OMAP4: hwmod data: Remove spinlock hwmod addrs
In-Reply-To: <1442263761-16757-1-git-send-email-s-anna@ti.com>
References: <1442263761-16757-1-git-send-email-s-anna@ti.com>
Message-ID: <1442263761-16757-2-git-send-email-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The legacy-style device creation logic for hwspinlock
has been removed after the DT-support was added to the
driver. The hwmod addr space for spinlock is therefore
no longer needed, so remove it.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 43eebf2c59e2..a5e444b1e57a 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -4471,21 +4471,11 @@ static struct omap_hwmod_ocp_if omap44xx_l4_cfg__smartreflex_mpu = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-static struct omap_hwmod_addr_space omap44xx_spinlock_addrs[] = {
-	{
-		.pa_start	= 0x4a0f6000,
-		.pa_end		= 0x4a0f6fff,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
-
 /* l4_cfg -> spinlock */
 static struct omap_hwmod_ocp_if omap44xx_l4_cfg__spinlock = {
 	.master		= &omap44xx_l4_cfg_hwmod,
 	.slave		= &omap44xx_spinlock_hwmod,
 	.clk		= "l4_div_ck",
-	.addr		= omap44xx_spinlock_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-- 
2.5.0
