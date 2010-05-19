From: eric@eukrea.com (=?utf-8?q?Eric=20B=C3=A9nard?=)
Date: Wed, 19 May 2010 18:46:07 +0200
Subject: [PATCH 12/13] eukrea_mbimx27: add support for the keyboard
In-Reply-To: <1274287568-30253-11-git-send-email-eric@eukrea.com>
References: <1274287568-30253-1-git-send-email-eric@eukrea.com>
	<1274287568-30253-2-git-send-email-eric@eukrea.com>
	<1274287568-30253-3-git-send-email-eric@eukrea.com>
	<1274287568-30253-4-git-send-email-eric@eukrea.com>
	<1274287568-30253-5-git-send-email-eric@eukrea.com>
	<1274287568-30253-6-git-send-email-eric@eukrea.com>
	<1274287568-30253-7-git-send-email-eric@eukrea.com>
	<1274287568-30253-8-git-send-email-eric@eukrea.com>
	<1274287568-30253-9-git-send-email-eric@eukrea.com>
	<1274287568-30253-10-git-send-email-eric@eukrea.com>
	<1274287568-30253-11-git-send-email-eric@eukrea.com>
Message-ID: <1274287568-30253-12-git-send-email-eric@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Eric B?nard <eric@eukrea.com>
---
 arch/arm/mach-mx2/eukrea_mbimx27-baseboard.c |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx2/eukrea_mbimx27-baseboard.c b/arch/arm/mach-mx2/eukrea_mbimx27-baseboard.c
index 136b736..e23d422 100644
--- a/arch/arm/mach-mx2/eukrea_mbimx27-baseboard.c
+++ b/arch/arm/mach-mx2/eukrea_mbimx27-baseboard.c
@@ -26,6 +26,7 @@
 #include <linux/spi/ads7846.h>
 #include <linux/backlight.h>
 #include <video/platform_lcd.h>
+#include <linux/input/matrix_keypad.h>
 
 #include <asm/mach/arch.h>
 
@@ -94,6 +95,18 @@ static int eukrea_mbimx27_pins[] = {
 	PD31_PF_CSPI1_MOSI,
 };
 
+static const uint32_t eukrea_mbimx27_keymap[] = {
+	KEY(0, 0, KEY_UP),
+	KEY(0, 1, KEY_DOWN),
+	KEY(1, 0, KEY_RIGHT),
+	KEY(1, 1, KEY_LEFT),
+};
+
+static struct matrix_keymap_data eukrea_mbimx27_keymap_data = {
+	.keymap         = eukrea_mbimx27_keymap,
+	.keymap_size    = ARRAY_SIZE(eukrea_mbimx27_keymap),
+};
+
 static struct gpio_led gpio_leds[] = {
 	{
 		.name			= "led1",
@@ -337,5 +350,7 @@ void __init eukrea_mbimx27_baseboard_init(void)
 	gpio_request(GPIO_PORTA | 25, "lcd_enable");
 	platform_device_register(&eukrea_mbimx27_lcd_powerdev);
 
+	mxc_register_device(&imx_kpp_device, &eukrea_mbimx27_keymap_data);
+
 	platform_add_devices(platform_devices, ARRAY_SIZE(platform_devices));
 }
-- 
1.6.3.3
