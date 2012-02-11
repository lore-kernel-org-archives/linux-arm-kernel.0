From: hs1218.kang@samsung.com (Huisung Kang)
Date: Sat, 11 Feb 2012 15:16:15 +0900
Subject: [PATCH 2/2] ARM: EXYNOS: Support I2C for EXYNOS5250 SoC
Message-ID: <018d01cce884$a90ed370$fb2c7a50$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Huisung Kang <hs1218.kang@samsung.com>
---
 arch/arm/mach-exynos/setup-i2c0.c |    4 ++--
 arch/arm/mach-exynos/setup-i2c1.c |   13 +++++++++----
 arch/arm/mach-exynos/setup-i2c2.c |   13 +++++++++----
 arch/arm/mach-exynos/setup-i2c3.c |   13 +++++++++----
 arch/arm/mach-exynos/setup-i2c4.c |   10 ++++++----
 arch/arm/mach-exynos/setup-i2c5.c |    9 ++++++---
 arch/arm/mach-exynos/setup-i2c6.c |   13 +++++++++----
 arch/arm/mach-exynos/setup-i2c7.c |   13 +++++++++----
 8 files changed, 59 insertions(+), 29 deletions(-)

diff --git a/arch/arm/mach-exynos/setup-i2c0.c b/arch/arm/mach-exynos/setup-i2c0.c
index 3244f3e..850b99f 100644
--- a/arch/arm/mach-exynos/setup-i2c0.c
+++ b/arch/arm/mach-exynos/setup-i2c0.c
@@ -23,8 +23,8 @@ struct platform_device; /* don't need the contents */
 void s3c_i2c0_cfg_gpio(struct platform_device *dev)
 {
 	if (soc_is_exynos5250())
-		;
-		/* will be implemented with gpio function */
+		s3c_gpio_cfgall_range(EXYNOS5_GPB3(0), 2,
+				      S3C_GPIO_SFN(2), S3C_GPIO_PULL_UP);
 	else
 		s3c_gpio_cfgall_range(EXYNOS4_GPD1(0), 2,
 				      S3C_GPIO_SFN(2), S3C_GPIO_PULL_UP);
diff --git a/arch/arm/mach-exynos/setup-i2c1.c b/arch/arm/mach-exynos/setup-i2c1.c
index fd7235a..4982ee8 100644
--- a/arch/arm/mach-exynos/setup-i2c1.c
+++ b/arch/arm/mach-exynos/setup-i2c1.c
@@ -1,7 +1,7 @@
 /*
- * linux/arch/arm/mach-exynos4/setup-i2c1.c
+ * linux/arch/arm/mach-exynos/setup-i2c1.c
  *
- * Copyright (C) 2010 Samsung Electronics Co., Ltd.
+ * Copyright (c) 2010-2012 Samsung Electronics Co., Ltd.
  *
  * I2C1 GPIO configuration.
  *
@@ -15,9 +15,14 @@ struct platform_device; /* don't need the contents */
 #include <linux/gpio.h>
 #include <plat/iic.h>
 #include <plat/gpio-cfg.h>
+#include <plat/cpu.h>
 
 void s3c_i2c1_cfg_gpio(struct platform_device *dev)
 {
-	s3c_gpio_cfgall_range(EXYNOS4_GPD1(2), 2,
-			      S3C_GPIO_SFN(2), S3C_GPIO_PULL_UP);
+	if (soc_is_exynos5250())
+		s3c_gpio_cfgall_range(EXYNOS5_GPB3(2), 2,
+				      S3C_GPIO_SFN(2), S3C_GPIO_PULL_UP);
+	else
+		s3c_gpio_cfgall_range(EXYNOS4_GPD1(2), 2,
+				      S3C_GPIO_SFN(2), S3C_GPIO_PULL_UP);
 }
diff --git a/arch/arm/mach-exynos/setup-i2c2.c b/arch/arm/mach-exynos/setup-i2c2.c
index 2694b19..77aa1b6 100644
--- a/arch/arm/mach-exynos/setup-i2c2.c
+++ b/arch/arm/mach-exynos/setup-i2c2.c
@@ -1,7 +1,7 @@
 /*
- * linux/arch/arm/mach-exynos4/setup-i2c2.c
+ * linux/arch/arm/mach-exynos/setup-i2c2.c
  *
- * Copyright (c) 2009-2010 Samsung Electronics Co., Ltd.
+ * Copyright (c) 2009-2012 Samsung Electronics Co., Ltd.
  *
  * I2C2 GPIO configuration.
  *
@@ -15,9 +15,14 @@ struct platform_device; /* don't need the contents */
 #include <linux/gpio.h>
 #include <plat/iic.h>
 #include <plat/gpio-cfg.h>
+#include <plat/cpu.h>
 
 void s3c_i2c2_cfg_gpio(struct platform_device *dev)
 {
-	s3c_gpio_cfgall_range(EXYNOS4_GPA0(6), 2,
-			      S3C_GPIO_SFN(3), S3C_GPIO_PULL_UP);
+	if (soc_is_exynos5250())
+		s3c_gpio_cfgall_range(EXYNOS5_GPA0(6), 2,
+				      S3C_GPIO_SFN(3), S3C_GPIO_PULL_UP);
+	else
+		s3c_gpio_cfgall_range(EXYNOS4_GPA0(6), 2,
+				      S3C_GPIO_SFN(3), S3C_GPIO_PULL_UP);
 }
diff --git a/arch/arm/mach-exynos/setup-i2c3.c b/arch/arm/mach-exynos/setup-i2c3.c
index 379bd30..d4129dc 100644
--- a/arch/arm/mach-exynos/setup-i2c3.c
+++ b/arch/arm/mach-exynos/setup-i2c3.c
@@ -1,7 +1,7 @@
 /*
- * linux/arch/arm/mach-exynos4/setup-i2c3.c
+ * linux/arch/arm/mach-exynos/setup-i2c3.c
  *
- * Copyright (c) 2010 Samsung Electronics Co., Ltd.
+ * Copyright (c) 2010-2012 Samsung Electronics Co., Ltd.
  *
  * I2C3 GPIO configuration.
  *
@@ -15,9 +15,14 @@ struct platform_device; /* don't need the contents */
 #include <linux/gpio.h>
 #include <plat/iic.h>
 #include <plat/gpio-cfg.h>
+#include <plat/cpu.h>
 
 void s3c_i2c3_cfg_gpio(struct platform_device *dev)
 {
-	s3c_gpio_cfgall_range(EXYNOS4_GPA1(2), 2,
-			      S3C_GPIO_SFN(3), S3C_GPIO_PULL_UP);
+	if (soc_is_exynos5250())
+		s3c_gpio_cfgall_range(EXYNOS5_GPA1(2), 2,
+				      S3C_GPIO_SFN(3), S3C_GPIO_PULL_UP);
+	else
+		s3c_gpio_cfgall_range(EXYNOS4_GPA1(2), 2,
+				      S3C_GPIO_SFN(3), S3C_GPIO_PULL_UP);
 }
diff --git a/arch/arm/mach-exynos/setup-i2c4.c b/arch/arm/mach-exynos/setup-i2c4.c
index 9df73e8..cd5e16a 100644
--- a/arch/arm/mach-exynos/setup-i2c4.c
+++ b/arch/arm/mach-exynos/setup-i2c4.c
@@ -1,7 +1,7 @@
 /*
- * linux/arch/arm/mach-exynos4/setup-i2c4.c
+ * linux/arch/arm/mach-exynos/setup-i2c4.c
  *
- * Copyright (c) 2010 Samsung Electronics Co., Ltd.
+ * Copyright (c) 2010-2012 Samsung Electronics Co., Ltd.
  *
  * I2C4 GPIO configuration.
  *
@@ -22,8 +22,10 @@ void s3c_i2c4_cfg_gpio(struct platform_device *dev)
 	if (soc_is_exynos4210())
 		s3c_gpio_cfgall_range(EXYNOS4_GPB(2), 2,
 				      S3C_GPIO_SFN(3), S3C_GPIO_PULL_UP);
-	else
+	else if (soc_is_exynos4212() || soc_is_exynos4412())
 		s3c_gpio_cfgall_range(EXYNOS4_GPB(0), 2,
 				      S3C_GPIO_SFN(3), S3C_GPIO_PULL_UP);
-
+	else
+		s3c_gpio_cfgall_range(EXYNOS5_GPA2(0), 2,
+				      S3C_GPIO_SFN(3), S3C_GPIO_PULL_UP);
 }
diff --git a/arch/arm/mach-exynos/setup-i2c5.c b/arch/arm/mach-exynos/setup-i2c5.c
index 2380d10..e9e2553 100644
--- a/arch/arm/mach-exynos/setup-i2c5.c
+++ b/arch/arm/mach-exynos/setup-i2c5.c
@@ -1,7 +1,7 @@
 /*
- * linux/arch/arm/mach-exynos4/setup-i2c5.c
+ * linux/arch/arm/mach-exynos/setup-i2c5.c
  *
- * Copyright (c) 2010 Samsung Electronics Co., Ltd.
+ * Copyright (c) 2010-2012 Samsung Electronics Co., Ltd.
  *
  * I2C5 GPIO configuration.
  *
@@ -22,7 +22,10 @@ void s3c_i2c5_cfg_gpio(struct platform_device *dev)
 	if (soc_is_exynos4210())
 		s3c_gpio_cfgall_range(EXYNOS4_GPB(6), 2,
 				      S3C_GPIO_SFN(3), S3C_GPIO_PULL_UP);
-	else
+	else if (soc_is_exynos4212() || soc_is_exynos4412())
 		s3c_gpio_cfgall_range(EXYNOS4_GPB(2), 2,
 				      S3C_GPIO_SFN(3), S3C_GPIO_PULL_UP);
+	else
+		s3c_gpio_cfgall_range(EXYNOS5_GPA2(2), 2,
+				      S3C_GPIO_SFN(3), S3C_GPIO_PULL_UP);
 }
diff --git a/arch/arm/mach-exynos/setup-i2c6.c b/arch/arm/mach-exynos/setup-i2c6.c
index 284d12b..8a680de 100644
--- a/arch/arm/mach-exynos/setup-i2c6.c
+++ b/arch/arm/mach-exynos/setup-i2c6.c
@@ -1,7 +1,7 @@
 /*
- * linux/arch/arm/mach-exynos4/setup-i2c6.c
+ * linux/arch/arm/mach-exynos/setup-i2c6.c
  *
- * Copyright (c) 2010 Samsung Electronics Co., Ltd.
+ * Copyright (c) 2010-2012 Samsung Electronics Co., Ltd.
  *
  * I2C6 GPIO configuration.
  *
@@ -15,9 +15,14 @@ struct platform_device; /* don't need the contents */
 #include <linux/gpio.h>
 #include <plat/iic.h>
 #include <plat/gpio-cfg.h>
+#include <plat/cpu.h>
 
 void s3c_i2c6_cfg_gpio(struct platform_device *dev)
 {
-	s3c_gpio_cfgall_range(EXYNOS4_GPC1(3), 2,
-			      S3C_GPIO_SFN(4), S3C_GPIO_PULL_UP);
+	if (soc_is_exynos5250())
+		s3c_gpio_cfgall_range(EXYNOS5_GPB1(3), 2,
+				      S3C_GPIO_SFN(4), S3C_GPIO_PULL_UP);
+	else
+		s3c_gpio_cfgall_range(EXYNOS4_GPC1(3), 2,
+				      S3C_GPIO_SFN(4), S3C_GPIO_PULL_UP);
 }
diff --git a/arch/arm/mach-exynos/setup-i2c7.c b/arch/arm/mach-exynos/setup-i2c7.c
index b7611ee..2082d43 100644
--- a/arch/arm/mach-exynos/setup-i2c7.c
+++ b/arch/arm/mach-exynos/setup-i2c7.c
@@ -1,7 +1,7 @@
 /*
- * linux/arch/arm/mach-exynos4/setup-i2c7.c
+ * linux/arch/arm/mach-exynos/setup-i2c7.c
  *
- * Copyright (c) 2010 Samsung Electronics Co., Ltd.
+ * Copyright (c) 2010-2012 Samsung Electronics Co., Ltd.
  *
  * I2C7 GPIO configuration.
  *
@@ -15,9 +15,14 @@ struct platform_device; /* don't need the contents */
 #include <linux/gpio.h>
 #include <plat/iic.h>
 #include <plat/gpio-cfg.h>
+#include <plat/cpu.h>
 
 void s3c_i2c7_cfg_gpio(struct platform_device *dev)
 {
-	s3c_gpio_cfgall_range(EXYNOS4_GPD0(2), 2,
-			      S3C_GPIO_SFN(3), S3C_GPIO_PULL_UP);
+	if (soc_is_exynos5250())
+		s3c_gpio_cfgall_range(EXYNOS5_GPB2(2), 2,
+				      S3C_GPIO_SFN(3), S3C_GPIO_PULL_UP);
+	else
+		s3c_gpio_cfgall_range(EXYNOS4_GPD0(2), 2,
+				      S3C_GPIO_SFN(3), S3C_GPIO_PULL_UP);
 }
-- 
1.7.1
