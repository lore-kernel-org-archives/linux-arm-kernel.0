From: nm@ti.com (Nishanth Menon)
Date: Sat,  5 Mar 2011 20:59:14 +0530
Subject: [PATCH V3 11/19] OMAP3+: SR: fix cosmetic indentation
In-Reply-To: <1299338962-5602-1-git-send-email-nm@ti.com>
References: <1299338962-5602-1-git-send-email-nm@ti.com>
Message-ID: <1299338962-5602-12-git-send-email-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Error label case seems to have a 2 tab indentation when just 1 is
necessary.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/smartreflex.c |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index 2b6fdc7..1e52d61 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -276,16 +276,16 @@ static int sr_late_init(struct omap_sr *sr_info)
 	return ret;
 
 error:
-		iounmap(sr_info->base);
-		mem = platform_get_resource(sr_info->pdev, IORESOURCE_MEM, 0);
-		release_mem_region(mem->start, resource_size(mem));
-		list_del(&sr_info->node);
-		dev_err(&sr_info->pdev->dev, "%s: ERROR in registering"
-			"interrupt handler. Smartreflex will"
-			"not function as desired\n", __func__);
-		kfree(name);
-		kfree(sr_info);
-		return ret;
+	iounmap(sr_info->base);
+	mem = platform_get_resource(sr_info->pdev, IORESOURCE_MEM, 0);
+	release_mem_region(mem->start, resource_size(mem));
+	list_del(&sr_info->node);
+	dev_err(&sr_info->pdev->dev, "%s: ERROR in registering"
+		"interrupt handler. Smartreflex will"
+		"not function as desired\n", __func__);
+	kfree(name);
+	kfree(sr_info);
+	return ret;
 }
 
 static void sr_v1_disable(struct omap_sr *sr)
-- 
1.7.1
