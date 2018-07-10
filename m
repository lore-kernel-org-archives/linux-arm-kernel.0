From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 10 Jul 2018 17:18:47 +0200
Subject: [PATCH 1/2] gpio: mt7621: add OF_GPIO dependency
Message-ID: <20180710151915.2282622-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Compile-testing the driver fails unless OF_GPIO is enabled:

drivers/gpio/gpio-mt7621.c: In function 'mediatek_gpio_bank_probe':
drivers/gpio/gpio-mt7621.c:228:10: error: 'struct gpio_chip' has no member named 'of_node'

Fixes: 4ba9c3afda41 ("gpio: mt7621: Add a driver for MT7621")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpio/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 836aa2173e44..7429b30e61b0 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -362,6 +362,7 @@ config GPIO_MPC8XXX
 config GPIO_MT7621
 	bool "Mediatek MT7621 GPIO Support"
 	depends on SOC_MT7620 || SOC_MT7621 || COMPILE_TEST
+	depends on OF_GPIO
 	select GPIO_GENERIC
 	select GPIOLIB_IRQCHIP
 	help
-- 
2.9.0
