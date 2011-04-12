From: lars@metafoo.de (Lars-Peter Clausen)
Date: Tue, 12 Apr 2011 22:51:04 +0200
Subject: [PATCH] ARM: s3c2440: gta02; Register dfbmcs320 device
Message-ID: <1302641464-27494-1-git-send-email-lars@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Register the dfbmcs320 device which provides the PCM DAI for the bluetooth
module.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Cc: Ben Dooks <ben-linux@fluff.org>
Cc: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s3c2440/mach-gta02.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s3c2440/mach-gta02.c b/arch/arm/mach-s3c2440/mach-gta02.c
index 0db2411..7166620 100644
--- a/arch/arm/mach-s3c2440/mach-gta02.c
+++ b/arch/arm/mach-s3c2440/mach-gta02.c
@@ -409,6 +409,10 @@ struct platform_device s3c24xx_pwm_device = {
 	.num_resources	= 0,
 };
 
+static struct platform_device gta02_dfbmcs320_device = {
+	.name = "dfbmcs320",
+};
+
 static struct i2c_board_info gta02_i2c_devs[] __initdata = {
 	{
 		I2C_BOARD_INFO("pcf50633", 0x73),
@@ -523,6 +527,7 @@ static struct platform_device *gta02_devices[] __initdata = {
 	&s3c_device_iis,
 	&samsung_asoc_dma,
 	&s3c_device_i2c0,
+	&gta02_dfbmcs320_device,
 	&gta02_buttons_device,
 	&s3c_device_adc,
 	&s3c_device_ts,
-- 
1.7.2.5
