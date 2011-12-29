From: dron0gus@gmail.com (Gusakov Andrey)
Date: Thu, 29 Dec 2011 17:07:14 +0400
Subject: [PATCH] S3C: fix order of MACH_S3C* checks on GPIO count define
Message-ID: <1325164036-15638-1-git-send-email-dron0gus@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gusakov Andrey <dron_gus@mail.ru>

Differnt S3C24XX SoC have different number of GPIO. When building
kernel for many S3C24XX SoCs GPIO number defined to minimun possible.
This patch reordef ifdef's to define GPIO number to muximum possible.

Signed-off-by: Gusakov Andrey <dron0gus@gmail.com>
---
 arch/arm/mach-s3c2410/include/mach/gpio.h |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-s3c2410/include/mach/gpio.h b/arch/arm/mach-s3c2410/include/mach/gpio.h
index 6fac70f..07257da 100644
--- a/arch/arm/mach-s3c2410/include/mach/gpio.h
+++ b/arch/arm/mach-s3c2410/include/mach/gpio.h
@@ -15,10 +15,10 @@
  * devices that need GPIO.
  */
 
-#ifdef CONFIG_CPU_S3C244X
-#define ARCH_NR_GPIOS	(32 * 9 + CONFIG_S3C24XX_GPIO_EXTRA)
-#elif defined(CONFIG_CPU_S3C2443) || defined(CONFIG_CPU_S3C2416)
+#if defined(CONFIG_CPU_S3C2443) || defined(CONFIG_CPU_S3C2416)
 #define ARCH_NR_GPIOS	(32 * 12 + CONFIG_S3C24XX_GPIO_EXTRA)
+#elif defined(CONFIG_CPU_S3C244X)
+#define ARCH_NR_GPIOS	(32 * 9 + CONFIG_S3C24XX_GPIO_EXTRA)
 #else
 #define ARCH_NR_GPIOS	(256 + CONFIG_S3C24XX_GPIO_EXTRA)
 #endif
@@ -26,10 +26,10 @@
 #include <mach/gpio-nrs.h>
 #include <mach/gpio-fns.h>
 
-#ifdef CONFIG_CPU_S3C244X
-#define S3C_GPIO_END	(S3C2410_GPJ(0) + 32)
-#elif defined(CONFIG_CPU_S3C2443) || defined(CONFIG_CPU_S3C2416)
+#if defined(CONFIG_CPU_S3C2443) || defined(CONFIG_CPU_S3C2416)
 #define S3C_GPIO_END	(S3C2410_GPM(0) + 32)
+#elif defined(CONFIG_CPU_S3C244X)
+#define S3C_GPIO_END	(S3C2410_GPJ(0) + 32)
 #else
 #define S3C_GPIO_END	(S3C2410_GPH(0) + 32)
 #endif
-- 
1.7.0.4
