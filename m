From: festevam@gmail.com (Fabio Estevam)
Date: Sat,  9 May 2015 08:51:23 -0300
Subject: [PATCH] ARM: imx: gpc: Remove .owner field
Message-ID: <1431172283-30853-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

This platform_driver does not need to set an owner as it will be 
populated by the driver core.

The semantic patch that makes this change is available
in scripts/coccinelle/api/platform_no_drv_owner.cocci.

More information about semantic patching is available at
http://coccinelle.lip6.fr/

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-imx/gpc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-imx/gpc.c b/arch/arm/mach-imx/gpc.c
index 4d60005..c478a20 100644
--- a/arch/arm/mach-imx/gpc.c
+++ b/arch/arm/mach-imx/gpc.c
@@ -464,7 +464,6 @@ static const struct of_device_id imx_gpc_dt_ids[] = {
 static struct platform_driver imx_gpc_driver = {
 	.driver = {
 		.name = "imx-gpc",
-		.owner = THIS_MODULE,
 		.of_match_table = imx_gpc_dt_ids,
 	},
 	.probe = imx_gpc_probe,
-- 
1.9.1
