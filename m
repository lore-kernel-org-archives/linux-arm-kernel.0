From: s-anna@ti.com (Suman Anna)
Date: Fri, 11 Jul 2014 16:44:42 -0500
Subject: [PATCHv2 09/10] ARM: OMAP4: hwmod_data: Remove legacy mailbox addrs
In-Reply-To: <1405115083-52977-1-git-send-email-s-anna@ti.com>
References: <1405115083-52977-1-git-send-email-s-anna@ti.com>
Message-ID: <1405115083-52977-10-git-send-email-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The legacy-style definition of the hwmod addr space is no longer
required after the addition of the OMAP4 mailbox DT node, so
clean up this data.

Cc: Paul Walmsley <paul@pwsan.com>
Cc: Beno?t Cousson <bcousson@baylibre.com>
Signed-off-by: Suman Anna <s-anna@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 41e54f7..5e61b8c 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -4142,21 +4142,11 @@ static struct omap_hwmod_ocp_if omap44xx_l4_wkup__kbd = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-static struct omap_hwmod_addr_space omap44xx_mailbox_addrs[] = {
-	{
-		.pa_start	= 0x4a0f4000,
-		.pa_end		= 0x4a0f41ff,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
-
 /* l4_cfg -> mailbox */
 static struct omap_hwmod_ocp_if omap44xx_l4_cfg__mailbox = {
 	.master		= &omap44xx_l4_cfg_hwmod,
 	.slave		= &omap44xx_mailbox_hwmod,
 	.clk		= "l4_div_ck",
-	.addr		= omap44xx_mailbox_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-- 
2.0.0
