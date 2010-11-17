From: paulius.zaleckas@gmail.com (Paulius Zaleckas)
Date: Wed, 17 Nov 2010 22:20:22 +0200
Subject: [PATCH] real6410: add audio codec support
Message-ID: <20101117202022.3497.20283.stgit@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Paulius Zaleckas <paulius.zaleckas@gmail.com>
---

 arch/arm/mach-s3c64xx/mach-real6410.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/mach-real6410.c b/arch/arm/mach-s3c64xx/mach-real6410.c
index f9ef9b5..856b723 100644
--- a/arch/arm/mach-s3c64xx/mach-real6410.c
+++ b/arch/arm/mach-s3c64xx/mach-real6410.c
@@ -43,6 +43,7 @@
 #include <plat/nand.h>
 #include <plat/regs-serial.h>
 #include <plat/ts.h>
+#include <plat/audio.h>
 
 #include <video/platform_lcd.h>
 
@@ -196,6 +197,8 @@ static struct platform_device *real6410_devices[] __initdata = {
 	&s3c_device_adc,
 	&s3c_device_ts,
 	&s3c_device_ohci,
+	&s3c_device_pcm,
+	&s3c64xx_device_ac97,
 };
 
 static struct s3c2410_ts_mach_info s3c_ts_platform __initdata = {
@@ -301,6 +304,7 @@ static void __init real6410_machine_init(void)
 	s3c_fb_set_platdata(&real6410_lcd_pdata);
 	s3c_nand_set_platdata(&real6410_nand_info);
 	s3c24xx_ts_set_platdata(&s3c_ts_platform);
+	s3c64xx_ac97_setup_gpio(S3C64XX_AC97_GPD);
 
 	/* configure nCS1 width to 16 bits */
 
