From: chunkeey@googlemail.com (Christian Lamparter)
Date: Tue, 9 Mar 2010 00:26:35 +0100
Subject: [PATCH] Orion5x: replace KEY_WLAN with KEY_WPS_BUTTON
Message-ID: <201003090026.35696.chunkeey@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"Input: add KEY_WPS_BUTTON definition" introduced
a generic keycode for WPS input events. 

Signed-off-by: Christian Lamparter <chunkeey@googlemail.com>
---
(untested, don't have the HW - keep the CC.)

KEY_WLAN is _reversed_ for WLAN rfkill. ;-)
---
diff --git a/arch/arm/mach-orion5x/wrt350n-v2-setup.c b/arch/arm/mach-orion5x/wrt350n-v2-setup.c
index cb0feca..f9f222e 100644
--- a/arch/arm/mach-orion5x/wrt350n-v2-setup.c
+++ b/arch/arm/mach-orion5x/wrt350n-v2-setup.c
@@ -77,7 +77,7 @@ static struct gpio_keys_button wrt350n_v2_buttons[] = {
 		.desc		= "Reset Button",
 		.active_low	= 1,
 	}, {
-		.code		= KEY_WLAN,
+		.code		= KEY_WPS_BUTTON,
 		.gpio		= 2,
 		.desc		= "WPS Button",
 		.active_low	= 1,
