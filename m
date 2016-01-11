From: linux@roeck-us.net (Guenter Roeck)
Date: Mon, 11 Jan 2016 09:00:49 -0800
Subject: [PATCH -next] arm: Select GPIO_GENERIC_PLATFORM for CRAGG_6410
Message-ID: <1452531649-14940-1-git-send-email-linux@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since commit 0f4630f3720e ("gpio: generic: factor into gpio_chip struct"),
all users of struct bgpio_pdata depend on GPIO_GENERIC.

This results in the following build error.

arch/arm/mach-s3c64xx/mach-crag6410.c:270:3: warning:
	excess elements in struct initializer
arch/arm/mach-s3c64xx/mach-crag6410.c:270:3: warning:
	(near initialization for '(anonymous)')
arch/arm/mach-s3c64xx/mach-crag6410.c:271:2: error:
	invalid use of undefined type 'struct bgpio_pdata'

Fixes: 0f4630f3720e ("gpio: generic: factor into gpio_chip struct")
Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
I don't know if this is the correct way to fix this problem.
If not, please consider this to be a bug report.

 arch/arm/mach-s3c64xx/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-s3c64xx/Kconfig b/arch/arm/mach-s3c64xx/Kconfig
index 7c0c420c3016..98d2aa9393f1 100644
--- a/arch/arm/mach-s3c64xx/Kconfig
+++ b/arch/arm/mach-s3c64xx/Kconfig
@@ -310,6 +310,7 @@ config MACH_WLF_CRAGG_6410
 	depends on I2C=y
 	select CPU_S3C6410
 	select LEDS_GPIO_REGISTER
+	select GPIO_GENERIC_PLATFORM
 	select S3C64XX_DEV_SPI0
 	select S3C64XX_SETUP_FB_24BPP
 	select S3C64XX_SETUP_I2C1
-- 
2.1.4
