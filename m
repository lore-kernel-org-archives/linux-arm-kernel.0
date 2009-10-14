From: yegor_sub1@visionsystems.de (Yegor Yefremov)
Date: Wed, 14 Oct 2009 17:02:33 +0200
Subject: Fix watchdog enabling for AT91SAM9G45
Message-ID: <4AD5E809.6090505@visionsystems.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix watchdog enabling for AT91SAM9G45

The macro for the watchdog has been changed from CONFIG_AT91SAM9_WATCHDOG
to CONFIG_AT91SAM9X_WATCHDOG due to AT91CAP9 chips support

Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>

Index: linus2/arch/arm/mach-at91/at91sam9g45_devices.c
===================================================================
--- linus2.orig/arch/arm/mach-at91/at91sam9g45_devices.c
+++ linus2/arch/arm/mach-at91/at91sam9g45_devices.c
@@ -838,7 +838,7 @@ static void __init at91_add_device_rtt(v
  *  Watchdog
  * -------------------------------------------------------------------- */
 
-#if defined(CONFIG_AT91SAM9_WATCHDOG) || defined(CONFIG_AT91SAM9_WATCHDOG_MODULE)
+#if defined(CONFIG_AT91SAM9X_WATCHDOG) || defined(CONFIG_AT91SAM9X_WATCHDOG_MODULE)
 static struct platform_device at91sam9g45_wdt_device = {
 	.name		= "at91_wdt",
 	.id		= -1,
