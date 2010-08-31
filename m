From: kmpark@infradead.org (Kyungmin Park)
Date: Tue, 31 Aug 2010 17:16:38 +0900
Subject: [PATCH] ARM: Samsung: Fix header double inclusion
Message-ID: <20100831081638.GA32385@july>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jaehoon Chung <jh80.chung@samsung.com>

Fix the header double inclusion when use the devs.h

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
diff --git a/arch/arm/plat-samsung/include/plat/devs.h b/arch/arm/plat-samsung/include/plat/devs.h
index 85f6f23..42581f8 100644
--- a/arch/arm/plat-samsung/include/plat/devs.h
+++ b/arch/arm/plat-samsung/include/plat/devs.h
@@ -8,7 +8,11 @@
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
-*/
+ */
+
+#ifndef __PLAT_SAMSUNG_DEVS_H
+#define __PLAT_SAMSUNG_DEVS_H
+
 #include <linux/platform_device.h>
 
 struct s3c24xx_uart_resources {
@@ -128,3 +132,5 @@ extern struct platform_device s3c_device_ac97;
  */
 extern void *s3c_set_platdata(void *pd, size_t pdsize,
 			      struct platform_device *pdev);
+
+#endif
