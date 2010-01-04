From: eric.y.miao@gmail.com (Eric Miao)
Date: Mon, 4 Jan 2010 11:43:35 +0800
Subject: [ARM] pxa: update pwm_backlight->notify() to include missed 'struct
	device *'
Message-ID: <f17812d71001031943l168a0616i19406a92df1b9c6@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

commit 2d51a521e64f91e42424b291fcae49d4d3f63d88
Author: Eric Miao <eric.y.miao@gmail.com>
Date:   Mon Jan 4 11:42:01 2010 +0800

    [ARM] pxa: update pwm_backlight->notify() to include missed
'struct device *'

    Signed-off-by: Eric Miao <eric.y.miao@gmail.com>

diff --git a/arch/arm/mach-pxa/magician.c b/arch/arm/mach-pxa/magician.c
index 8a38d60..189f330 100644
--- a/arch/arm/mach-pxa/magician.c
+++ b/arch/arm/mach-pxa/magician.c
@@ -381,7 +381,7 @@ err:
 	return ret;
 }

-static int magician_backlight_notify(int brightness)
+static int magician_backlight_notify(struct device *dev, int brightness)
 {
 	gpio_set_value(EGPIO_MAGICIAN_BL_POWER, brightness);
 	if (brightness >= 200) {
diff --git a/arch/arm/mach-pxa/palmld.c b/arch/arm/mach-pxa/palmld.c
index 5914021..e100af7 100644
--- a/arch/arm/mach-pxa/palmld.c
+++ b/arch/arm/mach-pxa/palmld.c
@@ -270,7 +270,7 @@ err:
 	return ret;
 }

-static int palmld_backlight_notify(int brightness)
+static int palmld_backlight_notify(struct device *dev, int brightness)
 {
 	gpio_set_value(GPIO_NR_PALMLD_BL_POWER, brightness);
 	gpio_set_value(GPIO_NR_PALMLD_LCD_POWER, brightness);
diff --git a/arch/arm/mach-pxa/palmt5.c b/arch/arm/mach-pxa/palmt5.c
index 7f89ca2..8fe3ec2 100644
--- a/arch/arm/mach-pxa/palmt5.c
+++ b/arch/arm/mach-pxa/palmt5.c
@@ -209,7 +209,7 @@ err:
 	return ret;
 }

-static int palmt5_backlight_notify(int brightness)
+static int palmt5_backlight_notify(struct device *dev, int brightness)
 {
 	gpio_set_value(GPIO_NR_PALMT5_BL_POWER, brightness);
 	gpio_set_value(GPIO_NR_PALMT5_LCD_POWER, brightness);
diff --git a/arch/arm/mach-pxa/palmtc.c b/arch/arm/mach-pxa/palmtc.c
index 3084175..b992f07 100644
--- a/arch/arm/mach-pxa/palmtc.c
+++ b/arch/arm/mach-pxa/palmtc.c
@@ -185,7 +185,7 @@ err:
 	return ret;
 }

-static int palmtc_backlight_notify(int brightness)
+static int palmtc_backlight_notify(struct device *dev, int brightness)
 {
 	/* backlight is on when GPIO16 AF0 is high */
 	gpio_set_value(GPIO_NR_PALMTC_BL_POWER, brightness);
diff --git a/arch/arm/mach-pxa/palmte2.c b/arch/arm/mach-pxa/palmte2.c
index 265d62b..dc728d6 100644
--- a/arch/arm/mach-pxa/palmte2.c
+++ b/arch/arm/mach-pxa/palmte2.c
@@ -181,7 +181,7 @@ err:
 	return ret;
 }

-static int palmte2_backlight_notify(int brightness)
+static int palmte2_backlight_notify(struct device *dev, int brightness)
 {
 	gpio_set_value(GPIO_NR_PALMTE2_BL_POWER, brightness);
 	gpio_set_value(GPIO_NR_PALMTE2_LCD_POWER, brightness);
diff --git a/arch/arm/mach-pxa/palmtreo.c b/arch/arm/mach-pxa/palmtreo.c
index 606eb7e..b433bb4 100644
--- a/arch/arm/mach-pxa/palmtreo.c
+++ b/arch/arm/mach-pxa/palmtreo.c
@@ -375,7 +375,7 @@ err:
 	return ret;
 }

-static int treo_backlight_notify(int brightness)
+static int treo_backlight_notify(struct device *dev, int brightness)
 {
 	gpio_set_value(GPIO_NR_TREO_BL_POWER, brightness);
 	return TREO_MAX_INTENSITY - brightness;
diff --git a/arch/arm/mach-pxa/palmtx.c b/arch/arm/mach-pxa/palmtx.c
index 7bf18c2..b37a025 100644
--- a/arch/arm/mach-pxa/palmtx.c
+++ b/arch/arm/mach-pxa/palmtx.c
@@ -269,7 +269,7 @@ err:
 	return ret;
 }

-static int palmtx_backlight_notify(int brightness)
+static int palmtx_backlight_notify(struct device *dev, int brightness)
 {
 	gpio_set_value(GPIO_NR_PALMTX_BL_POWER, brightness);
 	gpio_set_value(GPIO_NR_PALMTX_LCD_POWER, brightness);
diff --git a/arch/arm/mach-pxa/palmz72.c b/arch/arm/mach-pxa/palmz72.c
index d787ac7..1c5d68a 100644
--- a/arch/arm/mach-pxa/palmz72.c
+++ b/arch/arm/mach-pxa/palmz72.c
@@ -196,7 +196,7 @@ err:
 	return ret;
 }

-static int palmz72_backlight_notify(int brightness)
+static int palmz72_backlight_notify(struct device *dev, int brightness)
 {
 	gpio_set_value(GPIO_NR_PALMZ72_BL_POWER, brightness);
 	gpio_set_value(GPIO_NR_PALMZ72_LCD_POWER, brightness);
diff --git a/arch/arm/mach-pxa/viper.c b/arch/arm/mach-pxa/viper.c
index 5352b4e..89f258c 100644
--- a/arch/arm/mach-pxa/viper.c
+++ b/arch/arm/mach-pxa/viper.c
@@ -379,7 +379,7 @@ err_request_bckl:
 	return ret;
 }

-static int viper_backlight_notify(int brightness)
+static int viper_backlight_notify(struct device *dev, int brightness)
 {
 	gpio_set_value(VIPER_LCD_EN_GPIO, !!brightness);
 	gpio_set_value(VIPER_BCKLIGHT_EN_GPIO, !!brightness);
