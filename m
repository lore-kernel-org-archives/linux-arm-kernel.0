From: chunkeey@googlemail.com (Christian Lamparter)
Date: Tue, 9 Mar 2010 00:25:29 +0100
Subject: [PATCH] Kirkwood: WPS button keycode mapping
Message-ID: <201003090025.29849.chunkeey@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit "Input: add KEY_WPS_BUTTON definition"
added a generic keycode for WPS button.
Let's use it, instead of "F1" mapping.

Signed-off-by: Christian Lamparter <chunkeey@googlemail.com>
---
(untested, don't have the HW - please keep the CC!)

KEY_WPS_BUTTON chance made it into 2.6.34-rc1.
---
diff --git a/arch/arm/mach-kirkwood/mv88f6281gtw_ge-setup.c b/arch/arm/mach-kirkwood/mv88f6281gtw_ge-setup.c
index 0358f45..5e6f711 100644
--- a/arch/arm/mach-kirkwood/mv88f6281gtw_ge-setup.c
+++ b/arch/arm/mach-kirkwood/mv88f6281gtw_ge-setup.c
@@ -74,9 +74,9 @@ static struct gpio_keys_button mv88f6281gtw_ge_button_pins[] = {
 		.desc		= "SWR Button",
 		.active_low	= 1,
 	}, {
-		.code		= KEY_F1,
+		.code		= KEY_WPS_BUTTON,
 		.gpio		= 46,
-		.desc		= "WPS Button(F1)",
+		.desc		= "WPS Button",
 		.active_low	= 1,
 	},
 };
