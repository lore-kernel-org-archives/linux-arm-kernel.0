From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sun,  3 Jun 2012 13:42:41 +0100
Subject: [PATCH 2/2] ARM: S3C64XX: Dynamically assign interrupts for CPU PMIC
 on Cragganmore
In-Reply-To: <1338727361-25243-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1338727361-25243-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <1338727361-25243-2-git-send-email-broonie@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the WM831x driver uses irq_domain we can happily allow it to
assign its own IRQs.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 arch/arm/mach-s3c64xx/include/mach/crag6410.h |    3 +--
 arch/arm/mach-s3c64xx/mach-crag6410.c         |    1 -
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/include/mach/crag6410.h b/arch/arm/mach-s3c64xx/include/mach/crag6410.h
index ec97c15..4c3c999 100644
--- a/arch/arm/mach-s3c64xx/include/mach/crag6410.h
+++ b/arch/arm/mach-s3c64xx/include/mach/crag6410.h
@@ -13,8 +13,7 @@
 
 #include <linux/gpio.h>
 
-#define BANFF_PMIC_IRQ_BASE		IRQ_BOARD_START
-#define GLENFARCLAS_PMIC_IRQ_BASE	(IRQ_BOARD_START + 64)
+#define GLENFARCLAS_PMIC_IRQ_BASE	IRQ_BOARD_START
 
 #define PCA935X_GPIO_BASE		GPIO_BOARD_START
 #define CODEC_GPIO_BASE			(GPIO_BOARD_START + 8)
diff --git a/arch/arm/mach-s3c64xx/mach-crag6410.c b/arch/arm/mach-s3c64xx/mach-crag6410.c
index d0c352d..161c3b6 100644
--- a/arch/arm/mach-s3c64xx/mach-crag6410.c
+++ b/arch/arm/mach-s3c64xx/mach-crag6410.c
@@ -525,7 +525,6 @@ static struct wm831x_touch_pdata touch_pdata __initdata = {
 
 static struct wm831x_pdata crag_pmic_pdata __initdata = {
 	.wm831x_num = 1,
-	.irq_base = BANFF_PMIC_IRQ_BASE,
 	.gpio_base = BANFF_PMIC_GPIO_BASE,
 	.soft_shutdown = true,
 
-- 
1.7.10
