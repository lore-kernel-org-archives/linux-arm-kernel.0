From: eric@eukrea.com (=?utf-8?q?Eric=20B=C3=A9nard?=)
Date: Thu, 27 May 2010 08:33:16 +0200
Subject: [PATCH v2 4/8] eukrea_mbimx27: update keyboard platform data
In-Reply-To: <1274942000-3580-3-git-send-email-eric@eukrea.com>
References: <1274942000-3580-1-git-send-email-eric@eukrea.com>
	<1274942000-3580-2-git-send-email-eric@eukrea.com>
	<1274942000-3580-3-git-send-email-eric@eukrea.com>
Message-ID: <1274942000-3580-4-git-send-email-eric@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* use matrix_keypad_platform_data
* enable wakeup

Signed-off-by: Eric B?nard <eric@eukrea.com>
---
 arch/arm/mach-mx2/eukrea_mbimx27-baseboard.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-mx2/eukrea_mbimx27-baseboard.c b/arch/arm/mach-mx2/eukrea_mbimx27-baseboard.c
index 34bdc26..9038e1f 100644
--- a/arch/arm/mach-mx2/eukrea_mbimx27-baseboard.c
+++ b/arch/arm/mach-mx2/eukrea_mbimx27-baseboard.c
@@ -107,6 +107,11 @@ static struct matrix_keymap_data eukrea_mbimx27_keymap_data = {
 	.keymap_size    = ARRAY_SIZE(eukrea_mbimx27_keymap),
 };
 
+static struct matrix_keypad_platform_data eukrea_mbimx27_keypad_data = {
+	.keymap_data	= &eukrea_mbimx27_keymap_data,
+	.wakeup		= 1,
+};
+
 static struct gpio_led gpio_leds[] = {
 	{
 		.name			= "led1",
@@ -350,7 +355,7 @@ void __init eukrea_mbimx27_baseboard_init(void)
 	gpio_request(GPIO_PORTA | 25, "lcd_enable");
 	platform_device_register(&eukrea_mbimx27_lcd_powerdev);
 
-	mxc_register_device(&imx_kpp_device, &eukrea_mbimx27_keymap_data);
+	mxc_register_device(&imx_kpp_device, &eukrea_mbimx27_keypad_data);
 
 	platform_add_devices(platform_devices, ARRAY_SIZE(platform_devices));
 }
-- 
1.6.3.3
