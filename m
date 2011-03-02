From: nm@ti.com (Nishanth Menon)
Date: Wed,  2 Mar 2011 16:25:22 +0530
Subject: [PATCH v2 09/18] omap3+: sr: fix cosmetic indentation
In-Reply-To: <1299063331-27968-1-git-send-email-nm@ti.com>
References: <1299063331-27968-1-git-send-email-nm@ti.com>
Message-ID: <1299063331-27968-10-git-send-email-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Error label case seems to have a 2 tab indentation when just 1 is
necessary.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/smartreflex.c |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index 35658a2..99e4c4f 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -289,15 +289,15 @@ static int sr_late_init(struct omap_sr *sr_info)
 	return ret;
 
 error:
-		iounmap(sr_info->base);
-		mem = platform_get_resource(sr_info->pdev, IORESOURCE_MEM, 0);
-		release_mem_region(mem->start, resource_size(mem));
-		list_del(&sr_info->node);
-		dev_err(&sr_info->pdev->dev, "%s: ERROR in registering"
-			"interrupt handler. Smartreflex will"
-			"not function as desired\n", __func__);
-		kfree(sr_info);
-		return ret;
+	iounmap(sr_info->base);
+	mem = platform_get_resource(sr_info->pdev, IORESOURCE_MEM, 0);
+	release_mem_region(mem->start, resource_size(mem));
+	list_del(&sr_info->node);
+	dev_err(&sr_info->pdev->dev, "%s: ERROR in registering"
+		"interrupt handler. Smartreflex will"
+		"not function as desired\n", __func__);
+	kfree(sr_info);
+	return ret;
 }
 
 static void sr_v1_disable(struct omap_sr *sr)
-- 
1.7.1
