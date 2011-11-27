From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sun, 27 Nov 2011 22:04:58 +0000
Subject: [PATCH] ARM: S3C64XX: Remove extern from definition of framebuffer
 setup call
Message-ID: <1322431498-6555-1-git-send-email-broonie@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The extern is only useful on prototypes.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 arch/arm/mach-s3c64xx/setup-fb-24bpp.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/setup-fb-24bpp.c b/arch/arm/mach-s3c64xx/setup-fb-24bpp.c
index 83d2afb..2cf8002 100644
--- a/arch/arm/mach-s3c64xx/setup-fb-24bpp.c
+++ b/arch/arm/mach-s3c64xx/setup-fb-24bpp.c
@@ -20,7 +20,7 @@
 #include <plat/fb.h>
 #include <plat/gpio-cfg.h>
 
-extern void s3c64xx_fb_gpio_setup_24bpp(void)
+void s3c64xx_fb_gpio_setup_24bpp(void)
 {
 	s3c_gpio_cfgrange_nopull(S3C64XX_GPI(0), 16, S3C_GPIO_SFN(2));
 	s3c_gpio_cfgrange_nopull(S3C64XX_GPJ(0), 12, S3C_GPIO_SFN(2));
-- 
1.7.7.3
