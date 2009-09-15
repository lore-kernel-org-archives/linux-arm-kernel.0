From: jassi.brar@samsung.com (Jassi)
Date: Tue, 15 Sep 2009 19:02:34 +0900
Subject: [PATCH 02/10] S3C64XX I2S: declared i2s_v4
Message-ID: <1253008954-10473-1-git-send-email-jassi.brar@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For now, I2S-v4 is simply enumerated as third I2S controller of S3C6410
rather than a special device.
Also, Declared I2S-v4 device for SMDK6410.

Signed-Off-by: Jassi <jassi.brar@samsung.com>
---
 arch/arm/mach-s3c6410/mach-smdk6410.c |    1 +
 arch/arm/plat-s3c/dev-audio.c         |    6 ++++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-s3c6410/mach-smdk6410.c b/arch/arm/mach-s3c6410/mach-smdk6410.c
index bc9a7de..108ba37 100644
--- a/arch/arm/mach-s3c6410/mach-smdk6410.c
+++ b/arch/arm/mach-s3c6410/mach-smdk6410.c
@@ -181,6 +181,7 @@ static struct platform_device *smdk6410_devices[] __initdata = {
 #endif
 	&s3c_device_i2c0,
 	&s3c_device_i2c1,
+	&s3c64xx_device_iisv4,
 	&s3c_device_fb,
 	&s3c_device_usb,
 	&s3c_device_usb_hsotg,
diff --git a/arch/arm/plat-s3c/dev-audio.c b/arch/arm/plat-s3c/dev-audio.c
index 1322beb..28c030c 100644
--- a/arch/arm/plat-s3c/dev-audio.c
+++ b/arch/arm/plat-s3c/dev-audio.c
@@ -51,6 +51,7 @@ struct platform_device s3c64xx_device_iis1 = {
 };
 EXPORT_SYMBOL(s3c64xx_device_iis1);
 
+#ifdef CONFIG_CPU_S3C6410
 static struct resource s3c64xx_iisv4_resource[] = {
 	[0] = {
 		.start = S3C64XX_PA_IISV4,
@@ -60,9 +61,10 @@ static struct resource s3c64xx_iisv4_resource[] = {
 };
 
 struct platform_device s3c64xx_device_iisv4 = {
-	.name		  = "s3c64xx-iis-v4",
-	.id		  = -1,
+	.name		  = "s3c64xx-iis",
+	.id		  = 2,
 	.num_resources	  = ARRAY_SIZE(s3c64xx_iisv4_resource),
 	.resource	  = s3c64xx_iisv4_resource,
 };
 EXPORT_SYMBOL(s3c64xx_device_iisv4);
+#endif
-- 
1.6.2.5
