From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue,  3 Nov 2015 14:05:57 +0100
Subject: [PATCH] ARM: pxa: palm: Fix typos in PWM lookup table code
Message-ID: <1446555957-27520-1-git-send-email-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patches that were applied to add PWM lookup tables for legacy boards
were from v1 of the series instead of the revised v2 where the resulting
build errors had already been fixed.

Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
---
 arch/arm/mach-pxa/palm27x.c | 2 +-
 arch/arm/mach-pxa/palmtc.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-pxa/palm27x.c b/arch/arm/mach-pxa/palm27x.c
index 13eba2b26e0a..8fbfb10047ec 100644
--- a/arch/arm/mach-pxa/palm27x.c
+++ b/arch/arm/mach-pxa/palm27x.c
@@ -344,7 +344,7 @@ void __init palm27x_pwm_init(int bl, int lcd)
 {
 	palm_bl_power	= bl;
 	palm_lcd_power	= lcd;
-	pwm_add_lookup(palm27x_pwm_lookup, ARRAY_SIZE(palm27x_pwm_lookup));
+	pwm_add_table(palm27x_pwm_lookup, ARRAY_SIZE(palm27x_pwm_lookup));
 	platform_device_register(&palm27x_backlight);
 }
 #endif
diff --git a/arch/arm/mach-pxa/palmtc.c b/arch/arm/mach-pxa/palmtc.c
index aebf6de62468..0b5c3876720c 100644
--- a/arch/arm/mach-pxa/palmtc.c
+++ b/arch/arm/mach-pxa/palmtc.c
@@ -169,7 +169,7 @@ static inline void palmtc_keys_init(void) {}
 #if defined(CONFIG_BACKLIGHT_PWM) || defined(CONFIG_BACKLIGHT_PWM_MODULE)
 static struct pwm_lookup palmtc_pwm_lookup[] = {
 	PWM_LOOKUP("pxa25x-pwm.1", 0, "pwm-backlight.0", NULL, PALMTC_PERIOD_NS,
-		   PWM_PERIOD_NORMAL),
+		   PWM_POLARITY_NORMAL),
 };
 
 static struct platform_pwm_backlight_data palmtc_backlight_data = {
-- 
2.5.0
