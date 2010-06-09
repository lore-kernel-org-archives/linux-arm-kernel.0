From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Wed, 09 Jun 2010 15:08:39 +0200
Subject: [PATCH v2] arm: s5pv210: add more banks to gpiolib
Message-ID: <1276088919-20730-1-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for MP04 and MP05 gpio banks.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>

---

Changes since v1:
- fixed style issues reported by Kukjin Kim

 arch/arm/mach-s5pv210/gpiolib.c           |   14 ++++++++++++++
 arch/arm/mach-s5pv210/include/mach/gpio.h |   12 +++++++++---
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-s5pv210/gpiolib.c b/arch/arm/mach-s5pv210/gpiolib.c
index f4ac81f..0261908 100644
--- a/arch/arm/mach-s5pv210/gpiolib.c
+++ b/arch/arm/mach-s5pv210/gpiolib.c
@@ -208,6 +208,20 @@ static struct s3c_gpio_chip s5pv210_gpio_4bit[] = {
 			.label	= "MP03",
 		},
 	}, {
+		.config	= &gpio_cfg_noint,
+		.chip	= {
+			.base	= S5PV210_MP04(0),
+			.ngpio	= S5PV210_GPIO_MP04_NR,
+			.label	= "MP04",
+		},
+	}, {
+		.config	= &gpio_cfg_noint,
+		.chip	= {
+			.base	= S5PV210_MP05(0),
+			.ngpio	= S5PV210_GPIO_MP05_NR,
+			.label	= "MP05",
+		},
+	}, {
 		.base	= (S5P_VA_GPIO + 0xC00),
 		.config	= &gpio_cfg_noint,
 		.chip	= {
diff --git a/arch/arm/mach-s5pv210/include/mach/gpio.h b/arch/arm/mach-s5pv210/include/mach/gpio.h
index d6461ba..1f4b595 100644
--- a/arch/arm/mach-s5pv210/include/mach/gpio.h
+++ b/arch/arm/mach-s5pv210/include/mach/gpio.h
@@ -52,6 +52,8 @@
 #define S5PV210_GPIO_MP01_NR	(8)
 #define S5PV210_GPIO_MP02_NR	(4)
 #define S5PV210_GPIO_MP03_NR	(8)
+#define S5PV210_GPIO_MP04_NR	(8)
+#define S5PV210_GPIO_MP05_NR	(8)
 
 /* GPIO bank numbers */
 
@@ -94,6 +96,8 @@ enum s5p_gpio_number {
 	S5PV210_GPIO_MP01_START	= S5PV210_GPIO_NEXT(S5PV210_GPIO_J4),
 	S5PV210_GPIO_MP02_START	= S5PV210_GPIO_NEXT(S5PV210_GPIO_MP01),
 	S5PV210_GPIO_MP03_START	= S5PV210_GPIO_NEXT(S5PV210_GPIO_MP02),
+	S5PV210_GPIO_MP04_START	= S5PV210_GPIO_NEXT(S5PV210_GPIO_MP03),
+	S5PV210_GPIO_MP05_START	= S5PV210_GPIO_NEXT(S5PV210_GPIO_MP04),
 };
 
 /* S5PV210 GPIO number definitions */
@@ -127,13 +131,15 @@ enum s5p_gpio_number {
 #define S5PV210_MP01(_nr)	(S5PV210_GPIO_MP01_START + (_nr))
 #define S5PV210_MP02(_nr)	(S5PV210_GPIO_MP02_START + (_nr))
 #define S5PV210_MP03(_nr)	(S5PV210_GPIO_MP03_START + (_nr))
+#define S5PV210_MP04(_nr)	(S5PV210_GPIO_MP04_START + (_nr))
+#define S5PV210_MP05(_nr)	(S5PV210_GPIO_MP05_START + (_nr))
 
 /* the end of the S5PV210 specific gpios */
-#define S5PV210_GPIO_END	(S5PV210_MP03(S5PV210_GPIO_MP03_NR) + 1)
+#define S5PV210_GPIO_END	(S5PV210_MP05(S5PV210_GPIO_MP05_NR) + 1)
 #define S3C_GPIO_END		S5PV210_GPIO_END
 
-/* define the number of gpios we need to the one after the MP03() range */
-#define ARCH_NR_GPIOS		(S5PV210_MP03(S5PV210_GPIO_MP03_NR) +	\
+/* define the number of gpios we need to the one after the MP05() range */
+#define ARCH_NR_GPIOS		(S5PV210_MP05(S5PV210_GPIO_MP05_NR) +	\
 				 CONFIG_SAMSUNG_GPIO_EXTRA + 1)
 
 #include <asm-generic/gpio.h>
-- 
1.7.1.240.g225c
