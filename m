From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed,  5 Jan 2011 16:51:01 +0000
Subject: [PATCH] ARM: SMDK6410: Enable suspend support for WM1192 PMIC board
Message-ID: <1294246261-10035-1-git-send-email-broonie@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Samsung port requires explicit enable of suspend for each board,
do so for SMDK6410 when using the WM1192 PMIC board where the WM8312
can generate wake events.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 arch/arm/mach-s3c64xx/mach-smdk6410.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/mach-smdk6410.c b/arch/arm/mach-s3c64xx/mach-smdk6410.c
index 0b55771..19f9d3f 100644
--- a/arch/arm/mach-s3c64xx/mach-smdk6410.c
+++ b/arch/arm/mach-s3c64xx/mach-smdk6410.c
@@ -69,6 +69,7 @@
 #include <plat/adc.h>
 #include <plat/ts.h>
 #include <plat/keypad.h>
+#include <plat/pm.h>
 
 #define UCON S3C2410_UCON_DEFAULT | S3C2410_UCON_UCLK
 #define ULCON S3C2410_LCON_CS8 | S3C2410_LCON_PNONE | S3C2410_LCON_STOPB
@@ -535,6 +536,9 @@ static int wm1192_pre_init(struct wm831x *wm831x)
 {
 	int ret;
 
+	/* The WM8312 can generate wake signals */
+	s3c_pm_init();
+
 	/* Configure the IRQ line */
 	s3c_gpio_setpull(S3C64XX_GPN(12), S3C_GPIO_PULL_UP);
 
-- 
1.7.2.3
