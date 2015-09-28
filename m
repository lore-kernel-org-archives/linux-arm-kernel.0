From: petr.cvek@tul.cz (Petr Cvek)
Date: Mon, 28 Sep 2015 23:11:11 +0200
Subject: [PATCH v4 04/26] ARM: pxa: magician: Optimize debug messages for LCD
 power
In-Reply-To: <cover.1443472089.git.petr.cvek@tul.cz>
References: <cover.1443472089.git.petr.cvek@tul.cz>
Message-ID: <5609ACEF.3010601@tul.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Optimize the debug messages for the LCD power.

Signed-off-by: Petr Cvek <petr.cvek@tul.cz>
---
 arch/arm/mach-pxa/magician.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-pxa/magician.c b/arch/arm/mach-pxa/magician.c
index 29d8146..1bac785 100644
--- a/arch/arm/mach-pxa/magician.c
+++ b/arch/arm/mach-pxa/magician.c
@@ -270,10 +270,9 @@ static struct pxafb_mode_info samsung_modes[] = {
 
 static void toppoly_lcd_power(int on, struct fb_var_screeninfo *si)
 {
-	pr_debug("Toppoly LCD power\n");
+	pr_debug("Toppoly LCD power: %s\n", on ? "on" : "off");
 
 	if (on) {
-		pr_debug("on\n");
 		gpio_set_value(EGPIO_MAGICIAN_TOPPOLY_POWER, 1);
 		gpio_set_value(GPIO106_MAGICIAN_LCD_POWER_3, 1);
 		udelay(2000);
@@ -285,7 +284,6 @@ static void toppoly_lcd_power(int on, struct fb_var_screeninfo *si)
 		udelay(2000);
 		gpio_set_value(GPIO105_MAGICIAN_LCD_POWER_2, 1);
 	} else {
-		pr_debug("off\n");
 		msleep(15);
 		gpio_set_value(GPIO105_MAGICIAN_LCD_POWER_2, 0);
 		udelay(500);
@@ -298,10 +296,9 @@ static void toppoly_lcd_power(int on, struct fb_var_screeninfo *si)
 
 static void samsung_lcd_power(int on, struct fb_var_screeninfo *si)
 {
-	pr_debug("Samsung LCD power\n");
+	pr_debug("Samsung LCD power: %s\n", on ? "on" : "off");
 
 	if (on) {
-		pr_debug("on\n");
 		if (system_rev < 3)
 			gpio_set_value(GPIO75_MAGICIAN_SAMSUNG_POWER, 1);
 		else
@@ -314,7 +311,6 @@ static void samsung_lcd_power(int on, struct fb_var_screeninfo *si)
 		gpio_set_value(GPIO105_MAGICIAN_LCD_POWER_2, 1);
 		mdelay(10);
 	} else {
-		pr_debug("off\n");
 		mdelay(10);
 		gpio_set_value(GPIO105_MAGICIAN_LCD_POWER_2, 0);
 		mdelay(30);
-- 
1.7.12.1
