From: ben-linux@fluff.org (Ben Dooks)
Date: Mon, 18 Jan 2010 08:45:16 +0000
Subject: [PATCH] ARM: MINI2440: Remove commented out devices from device array
In-Reply-To: <1263804317-8996-1-git-send-email-ben-linux@fluff.org>
References: <1263804317-8996-1-git-send-email-ben-linux@fluff.org>
Message-ID: <1263804317-8996-7-git-send-email-ben-linux@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There's no point in having these in until there is proper support for
them, so remove as they only confuse the device changing script.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 arch/arm/mach-s3c2440/mach-mini2440.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-s3c2440/mach-mini2440.c b/arch/arm/mach-s3c2440/mach-mini2440.c
index 347eb6d..65ea3b5 100644
--- a/arch/arm/mach-s3c2440/mach-mini2440.c
+++ b/arch/arm/mach-s3c2440/mach-mini2440.c
@@ -508,7 +508,6 @@ static struct i2c_board_info mini2440_i2c_devs[] __initdata = {
 static struct platform_device *mini2440_devices[] __initdata = {
 	&s3c_device_ohci,
 	&s3c_device_wdt,
-/*	&s3c_device_adc,*/ /* ADC doesn't like living with touchscreen ! */
 	&s3c_device_i2c0,
 	&s3c_device_rtc,
 	&s3c_device_usbgadget,
@@ -522,8 +521,6 @@ static struct platform_device *mini2440_devices[] __initdata = {
 	&s3c_device_sdi,
 	&s3c_device_iis,
 	&mini2440_audio,
-/*	&s3c_device_timer[0],*/	/* buzzer pwm, no API for it */
-	/* remaining devices are optional */
 };
 
 static void __init mini2440_map_io(void)
-- 
1.6.0.4
