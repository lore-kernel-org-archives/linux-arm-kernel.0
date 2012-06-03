From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sun,  3 Jun 2012 13:42:40 +0100
Subject: [PATCH 1/2] ARM: S3C64XX: Dynamically allocate the IRQ range for
 WM8994 on Cragganmore
Message-ID: <1338727361-25243-1-git-send-email-broonie@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the new irqdomain support in the WM8994 driver to dynamically allocate
the interrupt range for the WM8994 rather than doing it explicitly. This
is more idiomatic for modern interrupt usage.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 arch/arm/mach-s3c64xx/include/mach/crag6410.h |    1 -
 arch/arm/mach-s3c64xx/mach-crag6410-module.c  |    1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/include/mach/crag6410.h b/arch/arm/mach-s3c64xx/include/mach/crag6410.h
index 4cb2f951..ec97c15 100644
--- a/arch/arm/mach-s3c64xx/include/mach/crag6410.h
+++ b/arch/arm/mach-s3c64xx/include/mach/crag6410.h
@@ -15,7 +15,6 @@
 
 #define BANFF_PMIC_IRQ_BASE		IRQ_BOARD_START
 #define GLENFARCLAS_PMIC_IRQ_BASE	(IRQ_BOARD_START + 64)
-#define CODEC_IRQ_BASE			(IRQ_BOARD_START + 128)
 
 #define PCA935X_GPIO_BASE		GPIO_BOARD_START
 #define CODEC_GPIO_BASE			(GPIO_BOARD_START + 8)
diff --git a/arch/arm/mach-s3c64xx/mach-crag6410-module.c b/arch/arm/mach-s3c64xx/mach-crag6410-module.c
index 4979372..4a83b4e 100644
--- a/arch/arm/mach-s3c64xx/mach-crag6410-module.c
+++ b/arch/arm/mach-s3c64xx/mach-crag6410-module.c
@@ -168,7 +168,6 @@ static struct wm8994_pdata wm8994_pdata = {
 	.gpio_defaults = {
 		0x3,          /* IRQ out, active high, CMOS */
 	},
-	.irq_base = CODEC_IRQ_BASE,
 	.ldo = {
 		 { .init_data = &wm8994_ldo1, },
 		 { .init_data = &wm8994_ldo2, },
-- 
1.7.10
