From: voice.shen@atmel.com (Bo Shen)
Date: Fri, 12 Oct 2012 10:34:18 +0800
Subject: [PATCH] i2c: change the id to let the i2c device work
Message-ID: <1350009258-10044-1-git-send-email-voice.shen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As the old method will use platform device id, change the id to
let the i2c device work

Signed-off-by: Bo Shen <voice.shen@atmel.com>
---
 arch/arm/mach-at91/at91sam9260_devices.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-at91/at91sam9260_devices.c b/arch/arm/mach-at91/at91sam9260_devices.c
index 5c5966a..aad76b7 100644
--- a/arch/arm/mach-at91/at91sam9260_devices.c
+++ b/arch/arm/mach-at91/at91sam9260_devices.c
@@ -471,7 +471,7 @@ static struct i2c_gpio_platform_data pdata = {
 
 static struct platform_device at91sam9260_twi_device = {
 	.name			= "i2c-gpio",
-	.id			= -1,
+	.id			= 0,
 	.dev.platform_data	= &pdata,
 };
 
-- 
1.7.9.5
