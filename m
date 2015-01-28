From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 28 Jan 2015 21:05:50 +0100
Subject: [PATCH] leds: ipaq needs LEDS_CLASS
Message-ID: <7354226.f7e3npkAlC@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All other drivers have a dependency on this already, but this one
does not, which can lead to a link error when LEDS_CLASS is not set.

drivers/built-in.o: In function `micro_leds_remove':
:(.text+0x13d1bc): undefined reference to `led_classdev_unregister'
drivers/built-in.o: In function `micro_leds_probe':
:(.text+0x13d3d0): undefined reference to `led_classdev_register'

This patch adds the missing dependency.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
index 95029dfd311a..927bb4491e1c 100644
--- a/drivers/leds/Kconfig
+++ b/drivers/leds/Kconfig
@@ -144,6 +144,7 @@ config LEDS_SUNFIRE
 
 config LEDS_IPAQ_MICRO
 	tristate "LED Support for the Compaq iPAQ h3xxx"
+	depends on LEDS_CLASS
 	depends on MFD_IPAQ_MICRO
 	help
 	  Choose this option if you want to use the notification LED on
