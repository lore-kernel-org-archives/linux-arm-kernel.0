From: jcd@tribudubois.net (Jean-Christophe Dubois)
Date: Sat, 26 Dec 2015 23:16:08 +0100
Subject: [PATCH] [ARM] i.MX6: fix cleanup path in imx6q_suspend_init()
Message-ID: <1451168168-24303-1-git-send-email-jcd@tribudubois.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The wrong pointer is passed to the ioumap function in the cleanup path

Signed-off-by: Jean-Christophe Dubois <jcd@tribudubois.net>
---
 arch/arm/mach-imx/pm-imx6.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-imx/pm-imx6.c b/arch/arm/mach-imx/pm-imx6.c
index 4470376..58924b3 100644
--- a/arch/arm/mach-imx/pm-imx6.c
+++ b/arch/arm/mach-imx/pm-imx6.c
@@ -561,13 +561,13 @@ static int __init imx6q_suspend_init(const struct imx6_pm_socdata *socdata)
 	goto put_node;
 
 pl310_cache_map_failed:
-	iounmap(&pm_info->gpc_base.vbase);
+	iounmap(pm_info->gpc_base.vbase);
 gpc_map_failed:
-	iounmap(&pm_info->iomuxc_base.vbase);
+	iounmap(pm_info->iomuxc_base.vbase);
 iomuxc_map_failed:
-	iounmap(&pm_info->src_base.vbase);
+	iounmap(pm_info->src_base.vbase);
 src_map_failed:
-	iounmap(&pm_info->mmdc_base.vbase);
+	iounmap(pm_info->mmdc_base.vbase);
 put_node:
 	of_node_put(node);
 
-- 
2.5.0
