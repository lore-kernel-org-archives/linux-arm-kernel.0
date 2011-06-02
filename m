From: kmpark@infradead.org (Kyungmin Park)
Date: Thu, 02 Jun 2011 18:27:27 +0900
Subject: [PATCH] ARM: samsung: Remove unused onenand plat functions
Message-ID: <20110602092727.GA14973@july>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kyungmin Park <kyungmin.park@samsung.com>

There's no place to use these functions.
and actually no need to set the platform data.

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
diff --git a/arch/arm/plat-s5p/dev-onenand.c b/arch/arm/plat-s5p/dev-onenand.c
index 6db9262..20336c8 100644
--- a/arch/arm/plat-s5p/dev-onenand.c
+++ b/arch/arm/plat-s5p/dev-onenand.c
@@ -15,8 +15,6 @@
 
 #include <linux/kernel.h>
 #include <linux/platform_device.h>
-#include <linux/mtd/mtd.h>
-#include <linux/mtd/onenand.h>
 
 #include <mach/irqs.h>
 #include <mach/map.h>
@@ -45,13 +43,3 @@ struct platform_device s5p_device_onenand = {
 	.num_resources	= ARRAY_SIZE(s5p_onenand_resources),
 	.resource	= s5p_onenand_resources,
 };
-
-void s5p_onenand_set_platdata(struct onenand_platform_data *pdata)
-{
-	struct onenand_platform_data *pd;
-
-	pd = kmemdup(pdata, sizeof(struct onenand_platform_data), GFP_KERNEL);
-	if (!pd)
-		printk(KERN_ERR "%s: no memory for platform data\n", __func__);
-	s5p_device_onenand.dev.platform_data = pd;
-}
diff --git a/arch/arm/plat-samsung/dev-onenand.c b/arch/arm/plat-samsung/dev-onenand.c
index 45ec732..f54ae71 100644
--- a/arch/arm/plat-samsung/dev-onenand.c
+++ b/arch/arm/plat-samsung/dev-onenand.c
@@ -13,8 +13,6 @@
 
 #include <linux/kernel.h>
 #include <linux/platform_device.h>
-#include <linux/mtd/mtd.h>
-#include <linux/mtd/onenand.h>
 
 #include <mach/irqs.h>
 #include <mach/map.h>
@@ -43,13 +41,3 @@ struct platform_device s3c_device_onenand = {
 	.num_resources	= ARRAY_SIZE(s3c_onenand_resources),
 	.resource	= s3c_onenand_resources,
 };
-
-void s3c_onenand_set_platdata(struct onenand_platform_data *pdata)
-{
-	struct onenand_platform_data *pd;
-
-	pd = kmemdup(pdata, sizeof(struct onenand_platform_data), GFP_KERNEL);
-	if (!pd)
-		printk(KERN_ERR "%s: no memory for platform data\n", __func__);
-	s3c_device_onenand.dev.platform_data = pd;
-}
