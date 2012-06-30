From: sylvester.nawrocki@gmail.com (Sylwester Nawrocki)
Date: Sat, 30 Jun 2012 14:08:57 +0200
Subject: [PATCH 05/10] ARM: S3C24XX: Convert the touchscreen setup code to
 common GPIO API
In-Reply-To: <1341058142-30438-1-git-send-email-sylvester.nawrocki@gmail.com>
References: <1341058142-30438-1-git-send-email-sylvester.nawrocki@gmail.com>
Message-ID: <1341058142-30438-6-git-send-email-sylvester.nawrocki@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace the S3C24XX SoC specific calls with the common gpiolib
API. This removes one more user of an obsolete GPIO API.

Signed-off-by: Sylwester Nawrocki <sylvester.nawrocki@gmail.com>
---
Tested on Micro2440-SDK.
---
 arch/arm/mach-s3c24xx/setup-ts.c |    6 +-----
 1 files changed, 1 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-s3c24xx/setup-ts.c b/arch/arm/mach-s3c24xx/setup-ts.c
index ed26386..4e11aff 100644
--- a/arch/arm/mach-s3c24xx/setup-ts.c
+++ b/arch/arm/mach-s3c24xx/setup-ts.c
@@ -16,7 +16,6 @@
 struct platform_device; /* don't need the contents */
 
 #include <mach/hardware.h>
-#include <mach/regs-gpio.h>
 
 /**
  * s3c24xx_ts_cfg_gpio - configure gpio for s3c2410 systems
@@ -27,8 +26,5 @@ struct platform_device; /* don't need the contents */
  */
 void s3c24xx_ts_cfg_gpio(struct platform_device *dev)
 {
-	s3c2410_gpio_cfgpin(S3C2410_GPG(12), S3C2410_GPG12_XMON);
-	s3c2410_gpio_cfgpin(S3C2410_GPG(13), S3C2410_GPG13_nXPON);
-	s3c2410_gpio_cfgpin(S3C2410_GPG(14), S3C2410_GPG14_YMON);
-	s3c2410_gpio_cfgpin(S3C2410_GPG(15), S3C2410_GPG15_nYPON);
+	s3c_gpio_cfgpin_range(S3C2410_GPG(12), 4, S3C_GPIO_SFN(3));
 }
-- 
1.7.4.1
