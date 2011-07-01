From: ch.naveen@samsung.com (Naveen Krishna Chatradhi)
Date: Fri, 01 Jul 2011 17:03:11 +0530
Subject: [PATCH 1/2] ARM: Samsung: Use generic set_plat_data function
In-Reply-To: <1309519992-3026-1-git-send-email-ch.naveen@samsung.com>
References: <1309519992-3026-1-git-send-email-ch.naveen@samsung.com>
Message-ID: <1309519992-3026-2-git-send-email-ch.naveen@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Calls the generic s3c_set_platdata function instead..

Signed-off-by: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
---
 arch/arm/plat-samsung/dev-i2c0.c |   10 ++++------
 arch/arm/plat-samsung/dev-i2c1.c |   10 ++++------
 arch/arm/plat-samsung/dev-i2c2.c |   10 ++++------
 arch/arm/plat-samsung/dev-i2c3.c |   10 ++++------
 arch/arm/plat-samsung/dev-i2c4.c |   10 ++++------
 arch/arm/plat-samsung/dev-i2c5.c |   10 ++++------
 arch/arm/plat-samsung/dev-i2c6.c |   10 ++++------
 arch/arm/plat-samsung/dev-i2c7.c |   10 ++++------
 8 files changed, 32 insertions(+), 48 deletions(-)

diff --git a/arch/arm/plat-samsung/dev-i2c0.c b/arch/arm/plat-samsung/dev-i2c0.c
index 3a601c1..b3c7435 100644
--- a/arch/arm/plat-samsung/dev-i2c0.c
+++ b/arch/arm/plat-samsung/dev-i2c0.c
@@ -62,11 +62,9 @@ void __init s3c_i2c0_set_platdata(struct s3c2410_platform_i2c *pd)
 	if (!pd)
 		pd = &default_i2c_data0;
 
-	npd = kmemdup(pd, sizeof(struct s3c2410_platform_i2c), GFP_KERNEL);
-	if (!npd)
-		printk(KERN_ERR "%s: no memory for platform data\n", __func__);
-	else if (!npd->cfg_gpio)
-		npd->cfg_gpio = s3c_i2c0_cfg_gpio;
+	npd = s3c_set_platdata(pd, sizeof(struct s3c2410_platform_i2c),
+			&s3c_device_i2c0);
 
-	s3c_device_i2c0.dev.platform_data = npd;
+	if (!npd->cfg_gpio)
+		npd->cfg_gpio = s3c_i2c0_cfg_gpio;
 }
diff --git a/arch/arm/plat-samsung/dev-i2c1.c b/arch/arm/plat-samsung/dev-i2c1.c
index 858ee2a..93dbb97 100644
--- a/arch/arm/plat-samsung/dev-i2c1.c
+++ b/arch/arm/plat-samsung/dev-i2c1.c
@@ -59,11 +59,9 @@ void __init s3c_i2c1_set_platdata(struct s3c2410_platform_i2c *pd)
 	if (!pd)
 		pd = &default_i2c_data1;
 
-	npd = kmemdup(pd, sizeof(struct s3c2410_platform_i2c), GFP_KERNEL);
-	if (!npd)
-		printk(KERN_ERR "%s: no memory for platform data\n", __func__);
-	else if (!npd->cfg_gpio)
-		npd->cfg_gpio = s3c_i2c1_cfg_gpio;
+	npd = s3c_set_platdata(pd, sizeof(struct s3c2410_platform_i2c),
+			&s3c_device_i2c1);
 
-	s3c_device_i2c1.dev.platform_data = npd;
+	if (!npd->cfg_gpio)
+		npd->cfg_gpio = s3c_i2c1_cfg_gpio;
 }
diff --git a/arch/arm/plat-samsung/dev-i2c2.c b/arch/arm/plat-samsung/dev-i2c2.c
index ff4ba69..fce3b95 100644
--- a/arch/arm/plat-samsung/dev-i2c2.c
+++ b/arch/arm/plat-samsung/dev-i2c2.c
@@ -60,11 +60,9 @@ void __init s3c_i2c2_set_platdata(struct s3c2410_platform_i2c *pd)
 	if (!pd)
 		pd = &default_i2c_data2;
 
-	npd = kmemdup(pd, sizeof(struct s3c2410_platform_i2c), GFP_KERNEL);
-	if (!npd)
-		printk(KERN_ERR "%s: no memory for platform data\n", __func__);
-	else if (!npd->cfg_gpio)
-		npd->cfg_gpio = s3c_i2c2_cfg_gpio;
+	npd = s3c_set_platdata(pd, sizeof(struct s3c2410_platform_i2c),
+			&s3c_device_i2c2);
 
-	s3c_device_i2c2.dev.platform_data = npd;
+	if (!npd->cfg_gpio)
+		npd->cfg_gpio = s3c_i2c2_cfg_gpio;
 }
diff --git a/arch/arm/plat-samsung/dev-i2c3.c b/arch/arm/plat-samsung/dev-i2c3.c
index 8586a10..46f87ad 100644
--- a/arch/arm/plat-samsung/dev-i2c3.c
+++ b/arch/arm/plat-samsung/dev-i2c3.c
@@ -58,11 +58,9 @@ void __init s3c_i2c3_set_platdata(struct s3c2410_platform_i2c *pd)
 	if (!pd)
 		pd = &default_i2c_data3;
 
-	npd = kmemdup(pd, sizeof(struct s3c2410_platform_i2c), GFP_KERNEL);
-	if (!npd)
-		printk(KERN_ERR "%s: no memory for platform data\n", __func__);
-	else if (!npd->cfg_gpio)
-		npd->cfg_gpio = s3c_i2c3_cfg_gpio;
+	npd = s3c_set_platdata(pd, sizeof(struct s3c2410_platform_i2c),
+			&s3c_device_i2c3);
 
-	s3c_device_i2c3.dev.platform_data = npd;
+	if (!npd->cfg_gpio)
+		npd->cfg_gpio = s3c_i2c3_cfg_gpio;
 }
diff --git a/arch/arm/plat-samsung/dev-i2c4.c b/arch/arm/plat-samsung/dev-i2c4.c
index df2159e..02be589 100644
--- a/arch/arm/plat-samsung/dev-i2c4.c
+++ b/arch/arm/plat-samsung/dev-i2c4.c
@@ -58,11 +58,9 @@ void __init s3c_i2c4_set_platdata(struct s3c2410_platform_i2c *pd)
 	if (!pd)
 		pd = &default_i2c_data4;
 
-	npd = kmemdup(pd, sizeof(struct s3c2410_platform_i2c), GFP_KERNEL);
-	if (!npd)
-		printk(KERN_ERR "%s: no memory for platform data\n", __func__);
-	else if (!npd->cfg_gpio)
-		npd->cfg_gpio = s3c_i2c4_cfg_gpio;
+	npd = s3c_set_platdata(pd, sizeof(struct s3c2410_platform_i2c),
+			&s3c_device_i2c4);
 
-	s3c_device_i2c4.dev.platform_data = npd;
+	if (!npd->cfg_gpio)
+		npd->cfg_gpio = s3c_i2c4_cfg_gpio;
 }
diff --git a/arch/arm/plat-samsung/dev-i2c5.c b/arch/arm/plat-samsung/dev-i2c5.c
index 0499c2c..3b84bed 100644
--- a/arch/arm/plat-samsung/dev-i2c5.c
+++ b/arch/arm/plat-samsung/dev-i2c5.c
@@ -58,11 +58,9 @@ void __init s3c_i2c5_set_platdata(struct s3c2410_platform_i2c *pd)
 	if (!pd)
 		pd = &default_i2c_data5;
 
-	npd = kmemdup(pd, sizeof(struct s3c2410_platform_i2c), GFP_KERNEL);
-	if (!npd)
-		printk(KERN_ERR "%s: no memory for platform data\n", __func__);
-	else if (!npd->cfg_gpio)
-		npd->cfg_gpio = s3c_i2c5_cfg_gpio;
+	npd = s3c_set_platdata(pd, sizeof(struct s3c2410_platform_i2c),
+			&s3c_device_i2c5);
 
-	s3c_device_i2c5.dev.platform_data = npd;
+	if (!npd->cfg_gpio)
+		npd->cfg_gpio = s3c_i2c5_cfg_gpio;
 }
diff --git a/arch/arm/plat-samsung/dev-i2c6.c b/arch/arm/plat-samsung/dev-i2c6.c
index 4083108..c57c195 100644
--- a/arch/arm/plat-samsung/dev-i2c6.c
+++ b/arch/arm/plat-samsung/dev-i2c6.c
@@ -58,11 +58,9 @@ void __init s3c_i2c6_set_platdata(struct s3c2410_platform_i2c *pd)
 	if (!pd)
 		pd = &default_i2c_data6;
 
-	npd = kmemdup(pd, sizeof(struct s3c2410_platform_i2c), GFP_KERNEL);
-	if (!npd)
-		printk(KERN_ERR "%s: no memory for platform data\n", __func__);
-	else if (!npd->cfg_gpio)
-		npd->cfg_gpio = s3c_i2c6_cfg_gpio;
+	npd = s3c_set_platdata(pd, sizeof(struct s3c2410_platform_i2c),
+			&s3c_device_i2c6);
 
-	s3c_device_i2c6.dev.platform_data = npd;
+	if (!npd->cfg_gpio)
+		npd->cfg_gpio = s3c_i2c6_cfg_gpio;
 }
diff --git a/arch/arm/plat-samsung/dev-i2c7.c b/arch/arm/plat-samsung/dev-i2c7.c
index 1182451..2cb9682 100644
--- a/arch/arm/plat-samsung/dev-i2c7.c
+++ b/arch/arm/plat-samsung/dev-i2c7.c
@@ -58,11 +58,9 @@ void __init s3c_i2c7_set_platdata(struct s3c2410_platform_i2c *pd)
 	if (!pd)
 		pd = &default_i2c_data7;
 
-	npd = kmemdup(pd, sizeof(struct s3c2410_platform_i2c), GFP_KERNEL);
-	if (!npd)
-		printk(KERN_ERR "%s: no memory for platform data\n", __func__);
-	else if (!npd->cfg_gpio)
-		npd->cfg_gpio = s3c_i2c7_cfg_gpio;
+	npd = s3c_set_platdata(pd, sizeof(struct s3c2410_platform_i2c),
+			&s3c_device_i2c7);
 
-	s3c_device_i2c7.dev.platform_data = npd;
+	if (!npd->cfg_gpio)
+		npd->cfg_gpio = s3c_i2c7_cfg_gpio;
 }
-- 
1.7.2.3
