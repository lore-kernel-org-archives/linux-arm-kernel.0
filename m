From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 31 Oct 2011 18:42:53 +0000
Subject: [PATCH 3/3 v3.1] ARM: S3C64XX: Correct reservation of GPIOs for CPU
	module on Cragganmore
In-Reply-To: <1320086573-21184-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1320086573-21184-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <1320086573-21184-3-git-send-email-broonie@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The gpio_base for the PMIC on the CPU module was being incorrectly set to
be the same as that for the CODEC causing the two GPIO drivers to collide.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 arch/arm/mach-s3c64xx/mach-crag6410.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/mach-crag6410.c b/arch/arm/mach-s3c64xx/mach-crag6410.c
index 3903d86..03eb475 100644
--- a/arch/arm/mach-s3c64xx/mach-crag6410.c
+++ b/arch/arm/mach-s3c64xx/mach-crag6410.c
@@ -74,6 +74,7 @@
 #define PCA935X_GPIO_BASE		GPIO_BOARD_START
 #define CODEC_GPIO_BASE		(GPIO_BOARD_START + 8)
 #define GLENFARCLAS_PMIC_GPIO_BASE	(GPIO_BOARD_START + 16)
+#define BANFF_PMIC_GPIO_BASE		(GLENFARCLAS_PMIC_GPIO_BASE + 16)
 
 /* serial port setup */
 
@@ -509,7 +510,7 @@ static struct wm831x_touch_pdata touch_pdata __initdata = {
 static struct wm831x_pdata crag_pmic_pdata __initdata = {
 	.wm831x_num = 1,
 	.irq_base = BANFF_PMIC_IRQ_BASE,
-	.gpio_base = GPIO_BOARD_START + 8,
+	.gpio_base = BANFF_PMIC_GPIO_BASE,
 	.soft_shutdown = true,
 
 	.backup = &banff_backup_pdata,
-- 
1.7.7.1
