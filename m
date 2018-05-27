From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sun, 27 May 2018 21:23:38 +0200
Subject: [PATCH] ARM: pxa: mioa701 convert to the new AC97 bus
Message-ID: <20180527192338.21606-1-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This migration implies :
 - wm9713 device is removed, it will be auto-probed

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 arch/arm/mach-pxa/mioa701.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/mach-pxa/mioa701.c b/arch/arm/mach-pxa/mioa701.c
index 9b6c7ea45a40..04dc78d0809f 100644
--- a/arch/arm/mach-pxa/mioa701.c
+++ b/arch/arm/mach-pxa/mioa701.c
@@ -677,14 +677,12 @@ MIO_SIMPLE_DEV(mioa701_led,	  "leds-gpio",	    &gpio_led_info)
 MIO_SIMPLE_DEV(pxa2xx_pcm,	  "pxa2xx-pcm",	    NULL)
 MIO_SIMPLE_DEV(mioa701_sound,	  "mioa701-wm9713", NULL)
 MIO_SIMPLE_DEV(mioa701_board,	  "mioa701-board",  NULL)
-MIO_SIMPLE_DEV(wm9713_acodec,	  "wm9713-codec",   NULL);
 MIO_SIMPLE_DEV(gpio_vbus,	  "gpio-vbus",      &gpio_vbus_data);
 
 static struct platform_device *devices[] __initdata = {
 	&mioa701_gpio_keys,
 	&mioa701_backlight,
 	&mioa701_led,
-	&wm9713_acodec,
 	&pxa2xx_pcm,
 	&mioa701_sound,
 	&power_dev,
-- 
2.11.0
