From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Fri, 21 Feb 2014 14:42:26 +0100
Subject: [PATCH] gpio: only enable kona driver on BCM_MOBILE or for compile
 testing
Message-ID: <1392990146-18916-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This change makes it easier to configure a kernel for a real machine by
not showing the option to enable it at all if COMPILE_TEST is off.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
Hello,

I'm not sure if and how "Kona" fits into the bcm281xx namespace, but
reading through the commit logs of the changes touching
drivers/gpio/gpio-bcm-kona.c so far suggests it does. In this case I'd
consider it a good idea to mention "bcm281xx" in the help text of
GPIO_BCM_KONA.

Best regards
Uwe

 drivers/gpio/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 903f24d28ba0..7cc68d26320c 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -817,7 +817,7 @@ config GPIO_MSIC
 
 config GPIO_BCM_KONA
 	bool "Broadcom Kona GPIO"
-	depends on OF_GPIO
+	depends on OF_GPIO && (ARCH_BCM_MOBILE || COMPILE_TEST)
 	help
 	  Turn on GPIO support for Broadcom "Kona" chips.
 
-- 
1.8.5.3
