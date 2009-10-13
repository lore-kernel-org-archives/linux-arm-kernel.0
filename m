From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Tue, 13 Oct 2009 10:11:10 +0200
Subject: [PATCH 05/17] ARM: S5PC1XX: add GPIO L banks to register definition
In-Reply-To: <1255421482-26455-5-git-send-email-m.szyprowski@samsung.com>
References: <1255421482-26455-1-git-send-email-m.szyprowski@samsung.com>
	<1255421482-26455-2-git-send-email-m.szyprowski@samsung.com>
	<1255421482-26455-3-git-send-email-m.szyprowski@samsung.com>
	<1255421482-26455-4-git-send-email-m.szyprowski@samsung.com>
	<1255421482-26455-5-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1255421482-26455-6-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add GPIO L0-L4 banks to register definition.

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm/mach-s5pc100/include/mach/gpio.h |   30 ++++++++++++++++++++++------
 1 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-s5pc100/include/mach/gpio.h b/arch/arm/mach-s5pc100/include/mach/gpio.h
index c74fc93..5d22961 100644
--- a/arch/arm/mach-s5pc100/include/mach/gpio.h
+++ b/arch/arm/mach-s5pc100/include/mach/gpio.h
@@ -47,6 +47,11 @@
 #define S5PC1XX_GPIO_K1_NR	(6)
 #define S5PC1XX_GPIO_K2_NR	(8)
 #define S5PC1XX_GPIO_K3_NR	(8)
+#define S5PC1XX_GPIO_L0_NR	(8)
+#define S5PC1XX_GPIO_L1_NR	(8)
+#define S5PC1XX_GPIO_L2_NR	(8)
+#define S5PC1XX_GPIO_L3_NR	(8)
+#define S5PC1XX_GPIO_L4_NR	(8)
 #define S5PC1XX_GPIO_MP00_NR	(8)
 #define S5PC1XX_GPIO_MP01_NR	(8)
 #define S5PC1XX_GPIO_MP02_NR	(8)
@@ -64,9 +69,9 @@
 	((__gpio##_START) + (__gpio##_NR) + CONFIG_S3C_GPIO_SPACE + 1)
 
 enum s3c_gpio_number {
-	S5PC1XX_GPIO_A0_START 	= 0,
-	S5PC1XX_GPIO_A1_START 	= S5PC1XX_GPIO_NEXT(S5PC1XX_GPIO_A0),
-	S5PC1XX_GPIO_B_START 	= S5PC1XX_GPIO_NEXT(S5PC1XX_GPIO_A1),
+	S5PC1XX_GPIO_A0_START	= 0,
+	S5PC1XX_GPIO_A1_START	= S5PC1XX_GPIO_NEXT(S5PC1XX_GPIO_A0),
+	S5PC1XX_GPIO_B_START	= S5PC1XX_GPIO_NEXT(S5PC1XX_GPIO_A1),
 	S5PC1XX_GPIO_C_START	= S5PC1XX_GPIO_NEXT(S5PC1XX_GPIO_B),
 	S5PC1XX_GPIO_D_START	= S5PC1XX_GPIO_NEXT(S5PC1XX_GPIO_C),
 	S5PC1XX_GPIO_E0_START	= S5PC1XX_GPIO_NEXT(S5PC1XX_GPIO_D),
@@ -93,11 +98,17 @@ enum s3c_gpio_number {
 	S5PC1XX_GPIO_K1_START	= S5PC1XX_GPIO_NEXT(S5PC1XX_GPIO_K0),
 	S5PC1XX_GPIO_K2_START	= S5PC1XX_GPIO_NEXT(S5PC1XX_GPIO_K1),
 	S5PC1XX_GPIO_K3_START	= S5PC1XX_GPIO_NEXT(S5PC1XX_GPIO_K2),
-	S5PC1XX_GPIO_MP00_START	= S5PC1XX_GPIO_NEXT(S5PC1XX_GPIO_K3),
+	S5PC1XX_GPIO_L0_START	= S5PC1XX_GPIO_NEXT(S5PC1XX_GPIO_K3),
+	S5PC1XX_GPIO_L1_START	= S5PC1XX_GPIO_NEXT(S5PC1XX_GPIO_L0),
+	S5PC1XX_GPIO_L2_START	= S5PC1XX_GPIO_NEXT(S5PC1XX_GPIO_L1),
+	S5PC1XX_GPIO_L3_START	= S5PC1XX_GPIO_NEXT(S5PC1XX_GPIO_L2),
+	S5PC1XX_GPIO_L4_START	= S5PC1XX_GPIO_NEXT(S5PC1XX_GPIO_L3),
+	S5PC1XX_GPIO_MP00_START	= S5PC1XX_GPIO_NEXT(S5PC1XX_GPIO_L4),
 	S5PC1XX_GPIO_MP01_START	= S5PC1XX_GPIO_NEXT(S5PC1XX_GPIO_MP00),
 	S5PC1XX_GPIO_MP02_START	= S5PC1XX_GPIO_NEXT(S5PC1XX_GPIO_MP01),
 	S5PC1XX_GPIO_MP03_START	= S5PC1XX_GPIO_NEXT(S5PC1XX_GPIO_MP02),
 	S5PC1XX_GPIO_MP04_START	= S5PC1XX_GPIO_NEXT(S5PC1XX_GPIO_MP03),
+	S5PC1XX_GPIO_END	= S5PC1XX_GPIO_NEXT(S5PC1XX_GPIO_MP04),
 };
 
 /* S5PC1XX GPIO number definitions. */
@@ -130,17 +141,22 @@ enum s3c_gpio_number {
 #define S5PC1XX_GPK1(_nr)	(S5PC1XX_GPIO_K1_START + (_nr))
 #define S5PC1XX_GPK2(_nr)	(S5PC1XX_GPIO_K2_START + (_nr))
 #define S5PC1XX_GPK3(_nr)	(S5PC1XX_GPIO_K3_START + (_nr))
+#define S5PC1XX_GPL0(_nr)	(S5PC1XX_GPIO_L0_START + (_nr))
+#define S5PC1XX_GPL1(_nr)	(S5PC1XX_GPIO_L1_START + (_nr))
+#define S5PC1XX_GPL2(_nr)	(S5PC1XX_GPIO_L2_START + (_nr))
+#define S5PC1XX_GPL3(_nr)	(S5PC1XX_GPIO_L3_START + (_nr))
+#define S5PC1XX_GPL4(_nr)	(S5PC1XX_GPIO_L4_START + (_nr))
 #define S5PC1XX_MP00(_nr)	(S5PC1XX_GPIO_MP00_START + (_nr))
 #define S5PC1XX_MP01(_nr)	(S5PC1XX_GPIO_MP01_START + (_nr))
 #define S5PC1XX_MP02(_nr)	(S5PC1XX_GPIO_MP02_START + (_nr))
 #define S5PC1XX_MP03(_nr)	(S5PC1XX_GPIO_MP03_START + (_nr))
 #define S5PC1XX_MP04(_nr)	(S5PC1XX_GPIO_MP04_START + (_nr))
+#define S5PC1XX_MP05(_nr)	(S5PC1XX_GPIO_MP05_START + (_nr))
 
-/* the end of the S5PC1XX specific gpios */
-#define S5PC1XX_GPIO_END	(S5PC1XX_MP04(S5PC1XX_GPIO_MP04_NR) + 1)
+/* It used the end of the S5PC1XX gpios */
 #define S3C_GPIO_END		S5PC1XX_GPIO_END
 
 /* define the number of gpios we need to the one after the MP04() range */
-#define ARCH_NR_GPIOS	(S5PC1XX_MP04(S5PC1XX_GPIO_MP04_NR) + 1)
+#define ARCH_NR_GPIOS		(S5PC1XX_GPIO_END + 1)
 
 #include <asm-generic/gpio.h>
-- 
1.6.4
