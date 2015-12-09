From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 09 Dec 2015 17:35:05 +0100
Subject: [PATCH] ARM: pxa: use PWM lookup table for all machines
Message-ID: <3221771.lHXPua29rx@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The recent change to use a pwm lookup table for the ezx machines
was incomplete and only changed the a780 model, but not the
other ones in the same file.

This adds the missing calls to pwm_add_table().

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: c3322022897c ("ARM: pxa: ezx: Use PWM lookup table")
Acked-by: Thierry Reding <thierry.reding@gmail.com>
---
If nobody has any objections, I'll queue this up for 4.4. No backport
is needed as it only broke in this release.

diff --git a/arch/arm/mach-pxa/ezx.c b/arch/arm/mach-pxa/ezx.c
index 391ba898b971..34ad0a89d4a9 100644
--- a/arch/arm/mach-pxa/ezx.c
+++ b/arch/arm/mach-pxa/ezx.c
@@ -889,6 +889,7 @@ static void __init e680_init(void)
 
 	pxa_set_keypad_info(&e680_keypad_platform_data);
 
+	pwm_add_table(ezx_pwm_lookup, ARRAY_SIZE(ezx_pwm_lookup));
 	platform_add_devices(ARRAY_AND_SIZE(ezx_devices));
 	platform_add_devices(ARRAY_AND_SIZE(e680_devices));
 }
@@ -956,6 +957,7 @@ static void __init a1200_init(void)
 
 	pxa_set_keypad_info(&a1200_keypad_platform_data);
 
+	pwm_add_table(ezx_pwm_lookup, ARRAY_SIZE(ezx_pwm_lookup));
 	platform_add_devices(ARRAY_AND_SIZE(ezx_devices));
 	platform_add_devices(ARRAY_AND_SIZE(a1200_devices));
 }
@@ -1148,6 +1150,7 @@ static void __init a910_init(void)
 		platform_device_register(&a910_camera);
 	}
 
+	pwm_add_table(ezx_pwm_lookup, ARRAY_SIZE(ezx_pwm_lookup));
 	platform_add_devices(ARRAY_AND_SIZE(ezx_devices));
 	platform_add_devices(ARRAY_AND_SIZE(a910_devices));
 }
@@ -1215,6 +1218,7 @@ static void __init e6_init(void)
 
 	pxa_set_keypad_info(&e6_keypad_platform_data);
 
+	pwm_add_table(ezx_pwm_lookup, ARRAY_SIZE(ezx_pwm_lookup));
 	platform_add_devices(ARRAY_AND_SIZE(ezx_devices));
 	platform_add_devices(ARRAY_AND_SIZE(e6_devices));
 }
@@ -1256,6 +1260,7 @@ static void __init e2_init(void)
 
 	pxa_set_keypad_info(&e2_keypad_platform_data);
 
+	pwm_add_table(ezx_pwm_lookup, ARRAY_SIZE(ezx_pwm_lookup));
 	platform_add_devices(ARRAY_AND_SIZE(ezx_devices));
 	platform_add_devices(ARRAY_AND_SIZE(e2_devices));
 }
