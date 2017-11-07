From: arnd@arndb.de (Arnd Bergmann)
Date: Tue,  7 Nov 2017 15:12:36 +0100
Subject: [PATCH] pinctrl: samsung/s3c24xx: add CONFIG_OF dependency
Message-ID: <20171107141244.3377780-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The driver fails to build without CONFIG_OF:

drivers/pinctrl/samsung/pinctrl-samsung.c: In function 'samsung_gpiolib_register':
drivers/pinctrl/samsung/pinctrl-samsung.c:936:5: error: 'struct gpio_chip' has no member named 'of_node'

This configuration is now possible since we can now select the
PINCTRL subsystem on S3C24xx machines other than the device tree
based ones.

Fixes: d219b924611a ("pinctrl: change Kconfig PINCTRL variable to a menuconfig")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/pinctrl/samsung/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/samsung/Kconfig b/drivers/pinctrl/samsung/Kconfig
index 0357f9701eb9..ecfb90059eeb 100644
--- a/drivers/pinctrl/samsung/Kconfig
+++ b/drivers/pinctrl/samsung/Kconfig
@@ -29,7 +29,7 @@ config PINCTRL_EXYNOS5440
 
 config PINCTRL_S3C24XX
 	bool "Samsung S3C24XX SoC pinctrl driver"
-	depends on ARCH_S3C24XX
+	depends on ARCH_S3C24XX && OF
 	select PINCTRL_SAMSUNG
 
 config PINCTRL_S3C64XX
-- 
2.9.0
