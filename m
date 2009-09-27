From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Sun, 27 Sep 2009 20:12:44 +0300
Subject: s3c24xx gpiolib question
Message-ID: <200909272012.53753.anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Is following patch sufficient to add GPJ port support to s3c24xx gpiolib?
And how to switch gpioline to custom function mode (for example TOUT0 on GPB0) 
via gpiolib?

diff --git a/arch/arm/plat-s3c24xx/gpiolib.c b/arch/arm/plat-s3c24xx/gpiolib.c
index 6d7a961..65d79f9 100644
--- a/arch/arm/plat-s3c24xx/gpiolib.c
+++ b/arch/arm/plat-s3c24xx/gpiolib.c
@@ -151,7 +151,8 @@ struct s3c_gpio_chip s3c24xx_gpios[] = {
 			.ngpio			= 16,
 			.to_irq			= s3c24xx_gpiolib_bankg_toirq,
 		},
-	}, {
+	}, 
+	[7] = {
 		.base	= S3C2410_GPHCON,
 		.pm	= __gpio_pm(&s3c_gpio_pm_2bit),
 		.chip	= {
@@ -161,6 +162,16 @@ struct s3c_gpio_chip s3c24xx_gpios[] = {
 			.ngpio			= 11,
 		},
 	},
+	[8] = {
+		.base	= S3C2440_GPJCON,
+		.pm = __gpio_pm(&s3c_gpio_pm_2bit),
+		.chip	= {
+			.base			= S3C2440_GPJ0,
+			.owner			= THIS_MODULE,
+			.label			= "GPIOJ",
+			.ngpio			= 16,
+		},
+	},
 };
 
 static __init int s3c24xx_gpiolib_init(void)
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20090927/2dd0962b/attachment.sig>
