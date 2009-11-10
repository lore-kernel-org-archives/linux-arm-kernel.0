From: ben-linux@fluff.org (Ben Dooks)
Date: Tue, 10 Nov 2009 23:21:53 +0000
Subject: [PATCH 1/4] H1940: Correct name of the local platform devices for LED
	and Bluetooth
In-Reply-To: <1257895316-9156-1-git-send-email-ben-linux@fluff.org>
References: <1257895316-9156-1-git-send-email-ben-linux@fluff.org>
Message-ID: <1257895316-9156-2-git-send-email-ben-linux@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mach-h1940.c file was using s3c_device_ where it really should be
calling these local definitions h1940_device to ensure they are not
mistaken for real s3c_devices when the device change is done.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 arch/arm/mach-s3c2410/mach-h1940.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-s3c2410/mach-h1940.c b/arch/arm/mach-s3c2410/mach-h1940.c
index d9cd5dd..20f3400 100644
--- a/arch/arm/mach-s3c2410/mach-h1940.c
+++ b/arch/arm/mach-s3c2410/mach-h1940.c
@@ -171,12 +171,12 @@ static struct s3c2410fb_mach_info h1940_fb_info __initdata = {
 	.gpdup_mask=	0xffffffff,
 };
 
-static struct platform_device s3c_device_leds = {
+static struct platform_device h1940_device_leds = {
 	.name             = "h1940-leds",
 	.id               = -1,
 };
 
-static struct platform_device s3c_device_bluetooth = {
+static struct platform_device h1940_device_bluetooth = {
 	.name             = "h1940-bt",
 	.id               = -1,
 };
@@ -188,8 +188,8 @@ static struct platform_device *h1940_devices[] __initdata = {
 	&s3c_device_i2c0,
 	&s3c_device_iis,
 	&s3c_device_usbgadget,
-	&s3c_device_leds,
-	&s3c_device_bluetooth,
+	&h1940_device_leds,
+	&h1940_device_bluetooth,
 };
 
 static void __init h1940_map_io(void)
-- 
1.6.5
