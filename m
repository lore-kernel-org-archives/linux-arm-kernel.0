From: marek.vasut@gmail.com (Marek Vasut)
Date: Tue, 13 Jul 2010 09:51:04 +0200
Subject: [PATCH 1/5] pxa: Sane naming of gpios for palm platform
Message-ID: <1279007468-20872-1-git-send-email-marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
---
 arch/arm/mach-pxa/include/mach/palmld.h  |   58 ++++++++++++++--------------
 arch/arm/mach-pxa/include/mach/palmt5.h  |   30 +++++++-------
 arch/arm/mach-pxa/include/mach/palmtx.h  |   44 +++++++++++-----------
 arch/arm/mach-pxa/include/mach/palmz72.h |   28 +++++++-------
 arch/arm/mach-pxa/palmld.c               |   60 +++++++++++++++---------------
 arch/arm/mach-pxa/palmt5.c               |   52 +++++++++++++-------------
 arch/arm/mach-pxa/palmtx.c               |   52 +++++++++++++-------------
 arch/arm/mach-pxa/palmz72.c              |   60 +++++++++++++++---------------
 drivers/ata/pata_palmld.c                |   22 +++++-----
 drivers/pcmcia/pxa2xx_palmld.c           |   32 ++++++++--------
 drivers/pcmcia/pxa2xx_palmtx.c           |   42 ++++++++++----------
 11 files changed, 240 insertions(+), 240 deletions(-)
 create mode 100644 arch/arm/mach-pxa/palm27x.c
 create mode 100644 configs/config-colibri
 create mode 100644 configs/config-income
 create mode 100644 configs/config-littleton
 create mode 100644 configs/config-vpac270
 create mode 100644 configs/config-vpac270-minimal
 create mode 100644 configs/config-zaurus
 create mode 100644 configs/config-zipitz2

diff --git a/arch/arm/mach-pxa/include/mach/palmld.h b/arch/arm/mach-pxa/include/mach/palmld.h
index ae536e8..8f9034d 100644
--- a/arch/arm/mach-pxa/include/mach/palmld.h
+++ b/arch/arm/mach-pxa/include/mach/palmld.h
@@ -16,55 +16,55 @@
 /** HERE ARE GPIOs **/
 
 /* GPIOs */
-#define GPIO_NR_PALMLD_GPIO_RESET	1
-#define GPIO_NR_PALMLD_POWER_DETECT	4
-#define GPIO_NR_PALMLD_HOTSYNC_BUTTON_N	10
-#define GPIO_NR_PALMLD_POWER_SWITCH	12
-#define GPIO_NR_PALMLD_EARPHONE_DETECT 	13
-#define GPIO_NR_PALMLD_LOCK_SWITCH	15
+#define GPIO1_PALMLD_GPIO_RESET		1
+#define GPIO4_PALMLD_POWER_DETECT	4
+#define GPIO10_PALMLD_HOTSYNC_BUTTON_N	10
+#define GPIO12_PALMLD_POWER_SWITCH	12
+#define GPIO13_PALMLD_EARPHONE_DETECT	13
+#define GPIO15_PALMLD_LOCK_SWITCH	15
 
 /* SD/MMC */
-#define GPIO_NR_PALMLD_SD_DETECT_N	14
-#define GPIO_NR_PALMLD_SD_POWER		114
-#define GPIO_NR_PALMLD_SD_READONLY	116
+#define GPIO14_PALMLD_SD_DETECT_N	14
+#define GPIO114_PALMLD_SD_POWER		114
+#define GPIO116_PALMLD_SD_READONLY	116
 
 /* TOUCHSCREEN */
-#define GPIO_NR_PALMLD_WM9712_IRQ	27
+#define GPIO27_PALMLD_WM9712_IRQ	27
 
 /* IRDA */
-#define GPIO_NR_PALMLD_IR_DISABLE	108
+#define GPIO108_PALMLD_IR_DISABLE	108
 
 /* LCD/BACKLIGHT */
-#define GPIO_NR_PALMLD_BL_POWER		19
-#define GPIO_NR_PALMLD_LCD_POWER	96
+#define GPIO19_PALMLD_BL_POWER		19
+#define GPIO96_PALMLD_LCD_POWER		96
 
 /* LCD BORDER */
-#define GPIO_NR_PALMLD_BORDER_SWITCH	21
-#define GPIO_NR_PALMLD_BORDER_SELECT	22
+#define GPIO21_PALMLD_BORDER_SWITCH	21
+#define GPIO22_PALMLD_BORDER_SELECT	22
 
 /* BLUETOOTH */
-#define GPIO_NR_PALMLD_BT_POWER		17
-#define GPIO_NR_PALMLD_BT_RESET		83
+#define GPIO17_PALMLD_BT_POWER		17
+#define GPIO83_PALMLD_BT_RESET		83
 
 /* PCMCIA (WiFi) */
-#define GPIO_NR_PALMLD_PCMCIA_READY	38
-#define GPIO_NR_PALMLD_PCMCIA_POWER	36
-#define GPIO_NR_PALMLD_PCMCIA_RESET	81
+#define GPIO38_PALMLD_PCMCIA_READY	38
+#define GPIO36_PALMLD_PCMCIA_POWER	36
+#define GPIO81_PALMLD_PCMCIA_RESET	81
 
 /* LEDs */
-#define GPIO_NR_PALMLD_LED_GREEN	52
-#define GPIO_NR_PALMLD_LED_AMBER	94
+#define GPIO52_PALMLD_LED_GREEN		52
+#define GPIO94_PALMLD_LED_AMBER		94
 
 /* IDE */
-#define GPIO_NR_PALMLD_IDE_RESET	98
-#define GPIO_NR_PALMLD_IDE_PWEN		115
+#define GPIO98_PALMLD_IDE_RESET		98
+#define GPIO115_PALMLD_IDE_PWEN		115
 
 /* USB */
-#define GPIO_NR_PALMLD_USB_DETECT_N	3
-#define GPIO_NR_PALMLD_USB_READY	86
-#define GPIO_NR_PALMLD_USB_RESET	88
-#define GPIO_NR_PALMLD_USB_INT		106
-#define GPIO_NR_PALMLD_USB_POWER	118
+#define GPIO3_PALMLD_USB_DETECT_N	3
+#define GPIO86_PALMLD_USB_READY		86
+#define GPIO88_PALMLD_USB_RESET		88
+#define GPIO106_PALMLD_USB_INT		106
+#define GPIO118_PALMLD_USB_POWER	118
 /* 20, 53 and 86 are usb related too */
 
 /* INTERRUPTS */
diff --git a/arch/arm/mach-pxa/include/mach/palmt5.h b/arch/arm/mach-pxa/include/mach/palmt5.h
index 6baf746..d70bb62 100644
--- a/arch/arm/mach-pxa/include/mach/palmt5.h
+++ b/arch/arm/mach-pxa/include/mach/palmt5.h
@@ -18,34 +18,34 @@
 /** HERE ARE GPIOs **/
 
 /* GPIOs */
-#define GPIO_NR_PALMT5_GPIO_RESET		1
+#define GPIO1_PALMT5_GPIO_RESET			1
 
-#define GPIO_NR_PALMT5_POWER_DETECT		90
-#define GPIO_NR_PALMT5_HOTSYNC_BUTTON_N		10
-#define GPIO_NR_PALMT5_EARPHONE_DETECT		107
+#define GPIO90_PALMT5_POWER_DETECT		90
+#define GPIO10_PALMT5_HOTSYNC_BUTTON_N		10
+#define GPIO107_PALMT5_EARPHONE_DETECT		107
 
 /* SD/MMC */
-#define GPIO_NR_PALMT5_SD_DETECT_N		14
-#define GPIO_NR_PALMT5_SD_POWER			114
-#define GPIO_NR_PALMT5_SD_READONLY		115
+#define GPIO14_PALMT5_SD_DETECT_N		14
+#define GPIO114_PALMT5_SD_POWER			114
+#define GPIO115_PALMT5_SD_READONLY		115
 
 /* TOUCHSCREEN */
-#define GPIO_NR_PALMT5_WM9712_IRQ		27
+#define GPIO27_PALMT5_WM9712_IRQ		27
 
 /* IRDA - disable GPIO connected to SD pin of tranceiver (TFBS4710?) ? */
-#define GPIO_NR_PALMT5_IR_DISABLE		40
+#define GPIO40_PALMT5_IR_DISABLE		40
 
 /* USB */
-#define GPIO_NR_PALMT5_USB_DETECT_N		15
-#define GPIO_NR_PALMT5_USB_PULLUP		93
+#define GPIO15_PALMT5_USB_DETECT_N		15
+#define GPIO93_PALMT5_USB_PULLUP		93
 
 /* LCD/BACKLIGHT */
-#define GPIO_NR_PALMT5_BL_POWER			84
-#define GPIO_NR_PALMT5_LCD_POWER		96
+#define GPIO84_PALMT5_BL_POWER			84
+#define GPIO96_PALMT5_LCD_POWER			96
 
 /* BLUETOOTH */
-#define GPIO_NR_PALMT5_BT_POWER			17
-#define GPIO_NR_PALMT5_BT_RESET			83
+#define GPIO17_PALMT5_BT_POWER			17
+#define GPIO83_PALMT5_BT_RESET			83
 
 /* INTERRUPTS */
 #define IRQ_GPIO_PALMT5_SD_DETECT_N	IRQ_GPIO(GPIO_NR_PALMT5_SD_DETECT_N)
diff --git a/arch/arm/mach-pxa/include/mach/palmtx.h b/arch/arm/mach-pxa/include/mach/palmtx.h
index 10abc4f..8b97b4d 100644
--- a/arch/arm/mach-pxa/include/mach/palmtx.h
+++ b/arch/arm/mach-pxa/include/mach/palmtx.h
@@ -19,47 +19,47 @@
 /** HERE ARE GPIOs **/
 
 /* GPIOs */
-#define GPIO_NR_PALMTX_GPIO_RESET		1
+#define GPIO1_PALMTX_GPIO_RESET			1
 
-#define GPIO_NR_PALMTX_POWER_DETECT		12 /* 90 */
-#define GPIO_NR_PALMTX_HOTSYNC_BUTTON_N		10
-#define GPIO_NR_PALMTX_EARPHONE_DETECT		107
+#define GPIO12_PALMTX_POWER_DETECT		12 /* 90 */
+#define GPIO10_PALMTX_HOTSYNC_BUTTON_N		10
+#define GPIO107_PALMTX_EARPHONE_DETECT		107
 
 /* SD/MMC */
-#define GPIO_NR_PALMTX_SD_DETECT_N		14
-#define GPIO_NR_PALMTX_SD_POWER			114 /* probably */
-#define GPIO_NR_PALMTX_SD_READONLY		115 /* probably */
+#define GPIO14_PALMTX_SD_DETECT_N		14
+#define GPIO114_PALMTX_SD_POWER			114 /* probably */
+#define GPIO115_PALMTX_SD_READONLY		115 /* probably */
 
 /* TOUCHSCREEN */
-#define GPIO_NR_PALMTX_WM9712_IRQ		27
+#define GPIO27_PALMTX_WM9712_IRQ		27
 
 /* IRDA -  disable GPIO connected to SD pin of tranceiver (TFBS4710?) ? */
-#define GPIO_NR_PALMTX_IR_DISABLE		40
+#define GPIO40_PALMTX_IR_DISABLE		40
 
 /* USB */
-#define GPIO_NR_PALMTX_USB_DETECT_N		13
-#define GPIO_NR_PALMTX_USB_PULLUP		93
+#define GPIO13_PALMTX_USB_DETECT_N		13
+#define GPIO93_PALMTX_USB_PULLUP		93
 
 /* LCD/BACKLIGHT */
-#define GPIO_NR_PALMTX_BL_POWER			84
-#define GPIO_NR_PALMTX_LCD_POWER		96
+#define GPIO84_PALMTX_BL_POWER			84
+#define GPIO96_PALMTX_LCD_POWER			96
 
 /* LCD BORDER */
-#define GPIO_NR_PALMTX_BORDER_SWITCH		98
-#define GPIO_NR_PALMTX_BORDER_SELECT		22
+#define GPIO98_PALMTX_BORDER_SWITCH		98
+#define GPIO22_PALMTX_BORDER_SELECT		22
 
 /* BLUETOOTH */
-#define GPIO_NR_PALMTX_BT_POWER			17
-#define GPIO_NR_PALMTX_BT_RESET			83
+#define GPIO17_PALMTX_BT_POWER			17
+#define GPIO83_PALMTX_BT_RESET			83
 
 /* PCMCIA (WiFi) */
-#define GPIO_NR_PALMTX_PCMCIA_POWER1		94
-#define GPIO_NR_PALMTX_PCMCIA_POWER2		108
-#define GPIO_NR_PALMTX_PCMCIA_RESET		79
-#define GPIO_NR_PALMTX_PCMCIA_READY		116
+#define GPIO94_PALMTX_PCMCIA_POWER1		94
+#define GPIO108_PALMTX_PCMCIA_POWER2		108
+#define GPIO79_PALMTX_PCMCIA_RESET		79
+#define GPIO116_PALMTX_PCMCIA_READY		116
 
 /* NAND Flash ... this GPIO may be incorrect! */
-#define GPIO_NR_PALMTX_NAND_BUFFER_DIR		79
+#define GPIO79_PALMTX_NAND_BUFFER_DIR		79
 
 /* INTERRUPTS */
 #define IRQ_GPIO_PALMTX_SD_DETECT_N	IRQ_GPIO(GPIO_NR_PALMTX_SD_DETECT_N)
diff --git a/arch/arm/mach-pxa/include/mach/palmz72.h b/arch/arm/mach-pxa/include/mach/palmz72.h
index 2bbcf70..83dced5 100644
--- a/arch/arm/mach-pxa/include/mach/palmz72.h
+++ b/arch/arm/mach-pxa/include/mach/palmz72.h
@@ -15,34 +15,34 @@
 #define _INCLUDE_PALMZ72_H_
 
 /* Power and control */
-#define GPIO_NR_PALMZ72_GPIO_RESET		1
-#define GPIO_NR_PALMZ72_POWER_DETECT		0
+#define GPIO1_PALMZ72_GPIO_RESET		1
+#define GPIO0_PALMZ72_POWER_DETECT		0
 
 /* SD/MMC */
-#define GPIO_NR_PALMZ72_SD_DETECT_N		14
-#define GPIO_NR_PALMZ72_SD_POWER_N		98
-#define GPIO_NR_PALMZ72_SD_RO			115
+#define GPIO14_PALMZ72_SD_DETECT_N		14
+#define GPIO98_PALMZ72_SD_POWER_N		98
+#define GPIO115_PALMZ72_SD_RO			115
 
 /* Touchscreen */
-#define GPIO_NR_PALMZ72_WM9712_IRQ		27
+#define GPIO27_PALMZ72_WM9712_IRQ		27
 
 /* IRDA -  disable GPIO connected to SD pin of tranceiver (TFBS4710?) ? */
-#define GPIO_NR_PALMZ72_IR_DISABLE		49
+#define GPIO49_PALMZ72_IR_DISABLE		49
 
 /* USB */
-#define GPIO_NR_PALMZ72_USB_DETECT_N		15
-#define GPIO_NR_PALMZ72_USB_PULLUP		95
+#define GPIO15_PALMZ72_USB_DETECT_N		15
+#define GPIO95_PALMZ72_USB_PULLUP		95
 
 /* LCD/Backlight */
-#define GPIO_NR_PALMZ72_BL_POWER		20
-#define GPIO_NR_PALMZ72_LCD_POWER		96
+#define GPIO20_PALMZ72_BL_POWER			20
+#define GPIO96_PALMZ72_LCD_POWER		96
 
 /* LED */
-#define GPIO_NR_PALMZ72_LED_GREEN		88
+#define GPIO88_PALMZ72_LED_GREEN		88
 
 /* Bluetooth */
-#define GPIO_NR_PALMZ72_BT_POWER		17
-#define GPIO_NR_PALMZ72_BT_RESET		83
+#define GPIO17_PALMZ72_BT_POWER			17
+#define GPIO83_PALMZ72_BT_RESET			83
 
 /** Initial values **/
 
diff --git a/arch/arm/mach-pxa/palm27x.c b/arch/arm/mach-pxa/palm27x.c
new file mode 100644
index 0000000..e69de29
diff --git a/arch/arm/mach-pxa/palmld.c b/arch/arm/mach-pxa/palmld.c
index 83a1a55..bec35e2 100644
--- a/arch/arm/mach-pxa/palmld.c
+++ b/arch/arm/mach-pxa/palmld.c
@@ -165,9 +165,9 @@ static struct platform_device palmld_flash = {
  ******************************************************************************/
 static struct pxamci_platform_data palmld_mci_platform_data = {
 	.ocr_mask		= MMC_VDD_32_33 | MMC_VDD_33_34,
-	.gpio_card_detect	= GPIO_NR_PALMLD_SD_DETECT_N,
-	.gpio_card_ro		= GPIO_NR_PALMLD_SD_READONLY,
-	.gpio_power		= GPIO_NR_PALMLD_SD_POWER,
+	.gpio_card_detect	= GPIO14_PALMLD_SD_DETECT_N,
+	.gpio_card_ro		= GPIO116_PALMLD_SD_READONLY,
+	.gpio_power		= GPIO114_PALMLD_SD_POWER,
 	.detect_delay_ms	= 200,
 };
 
@@ -204,9 +204,9 @@ static struct pxa27x_keypad_platform_data palmld_keypad_platform_data = {
  * GPIO keys
  ******************************************************************************/
 static struct gpio_keys_button palmld_pxa_buttons[] = {
-	{KEY_F8, GPIO_NR_PALMLD_HOTSYNC_BUTTON_N, 1, "HotSync Button" },
-	{KEY_F9, GPIO_NR_PALMLD_LOCK_SWITCH, 0, "Lock Switch" },
-	{KEY_POWER, GPIO_NR_PALMLD_POWER_SWITCH, 0, "Power Switch" },
+	{KEY_F8, GPIO10_PALMLD_HOTSYNC_BUTTON_N, 1, "HotSync Button" },
+	{KEY_F9, GPIO15_PALMLD_LOCK_SWITCH, 0, "Lock Switch" },
+	{KEY_POWER, GPIO12_PALMLD_POWER_SWITCH, 0, "Power Switch" },
 };
 
 static struct gpio_keys_platform_data palmld_pxa_keys_data = {
@@ -229,39 +229,39 @@ static int palmld_backlight_init(struct device *dev)
 {
 	int ret;
 
-	ret = gpio_request(GPIO_NR_PALMLD_BL_POWER, "BL POWER");
+	ret = gpio_request(GPIO19_PALMLD_BL_POWER, "BL POWER");
 	if (ret)
 		goto err;
-	ret = gpio_direction_output(GPIO_NR_PALMLD_BL_POWER, 0);
+	ret = gpio_direction_output(GPIO19_PALMLD_BL_POWER, 0);
 	if (ret)
 		goto err2;
-	ret = gpio_request(GPIO_NR_PALMLD_LCD_POWER, "LCD POWER");
+	ret = gpio_request(GPIO96_PALMLD_LCD_POWER, "LCD POWER");
 	if (ret)
 		goto err2;
-	ret = gpio_direction_output(GPIO_NR_PALMLD_LCD_POWER, 0);
+	ret = gpio_direction_output(GPIO96_PALMLD_LCD_POWER, 0);
 	if (ret)
 		goto err3;
 
 	return 0;
 err3:
-	gpio_free(GPIO_NR_PALMLD_LCD_POWER);
+	gpio_free(GPIO96_PALMLD_LCD_POWER);
 err2:
-	gpio_free(GPIO_NR_PALMLD_BL_POWER);
+	gpio_free(GPIO19_PALMLD_BL_POWER);
 err:
 	return ret;
 }
 
 static int palmld_backlight_notify(struct device *dev, int brightness)
 {
-	gpio_set_value(GPIO_NR_PALMLD_BL_POWER, brightness);
-	gpio_set_value(GPIO_NR_PALMLD_LCD_POWER, brightness);
+	gpio_set_value(GPIO19_PALMLD_BL_POWER, brightness);
+	gpio_set_value(GPIO96_PALMLD_LCD_POWER, brightness);
 	return brightness;
 }
 
 static void palmld_backlight_exit(struct device *dev)
 {
-	gpio_free(GPIO_NR_PALMLD_BL_POWER);
-	gpio_free(GPIO_NR_PALMLD_LCD_POWER);
+	gpio_free(GPIO19_PALMLD_BL_POWER);
+	gpio_free(GPIO96_PALMLD_LCD_POWER);
 }
 
 static struct platform_pwm_backlight_data palmld_backlight_data = {
@@ -286,7 +286,7 @@ static struct platform_device palmld_backlight = {
  * IrDA
  ******************************************************************************/
 static struct pxaficp_platform_data palmld_ficp_platform_data = {
-	.gpio_pwdown		= GPIO_NR_PALMLD_IR_DISABLE,
+	.gpio_pwdown		= GPIO108_PALMLD_IR_DISABLE,
 	.transceiver_cap	= IR_SIRMODE | IR_OFF,
 };
 
@@ -297,11 +297,11 @@ struct gpio_led gpio_leds[] = {
 {
 	.name			= "palmld:green:led",
 	.default_trigger	= "none",
-	.gpio			= GPIO_NR_PALMLD_LED_GREEN,
+	.gpio			= GPIO52_PALMLD_LED_GREEN,
 }, {
 	.name			= "palmld:amber:led",
 	.default_trigger	= "none",
-	.gpio			= GPIO_NR_PALMLD_LED_AMBER,
+	.gpio			= GPIO94_PALMLD_LED_AMBER,
 },
 };
 
@@ -325,44 +325,44 @@ static int power_supply_init(struct device *dev)
 {
 	int ret;
 
-	ret = gpio_request(GPIO_NR_PALMLD_POWER_DETECT, "CABLE_STATE_AC");
+	ret = gpio_request(GPIO4_PALMLD_POWER_DETECT, "CABLE_STATE_AC");
 	if (ret)
 		goto err1;
-	ret = gpio_direction_input(GPIO_NR_PALMLD_POWER_DETECT);
+	ret = gpio_direction_input(GPIO4_PALMLD_POWER_DETECT);
 	if (ret)
 		goto err2;
 
-	ret = gpio_request(GPIO_NR_PALMLD_USB_DETECT_N, "CABLE_STATE_USB");
+	ret = gpio_request(GPIO3_PALMLD_USB_DETECT_N, "CABLE_STATE_USB");
 	if (ret)
 		goto err2;
-	ret = gpio_direction_input(GPIO_NR_PALMLD_USB_DETECT_N);
+	ret = gpio_direction_input(GPIO3_PALMLD_USB_DETECT_N);
 	if (ret)
 		goto err3;
 
 	return 0;
 
 err3:
-	gpio_free(GPIO_NR_PALMLD_USB_DETECT_N);
+	gpio_free(GPIO3_PALMLD_USB_DETECT_N);
 err2:
-	gpio_free(GPIO_NR_PALMLD_POWER_DETECT);
+	gpio_free(GPIO4_PALMLD_POWER_DETECT);
 err1:
 	return ret;
 }
 
 static int palmld_is_ac_online(void)
 {
-	return gpio_get_value(GPIO_NR_PALMLD_POWER_DETECT);
+	return gpio_get_value(GPIO4_PALMLD_POWER_DETECT);
 }
 
 static int palmld_is_usb_online(void)
 {
-	return !gpio_get_value(GPIO_NR_PALMLD_USB_DETECT_N);
+	return !gpio_get_value(GPIO3_PALMLD_USB_DETECT_N);
 }
 
 static void power_supply_exit(struct device *dev)
 {
-	gpio_free(GPIO_NR_PALMLD_USB_DETECT_N);
-	gpio_free(GPIO_NR_PALMLD_POWER_DETECT);
+	gpio_free(GPIO3_PALMLD_USB_DETECT_N);
+	gpio_free(GPIO4_PALMLD_POWER_DETECT);
 }
 
 static char *palmld_supplicants[] = {
@@ -413,7 +413,7 @@ static pxa2xx_audio_ops_t palmld_ac97_pdata = {
 };
 
 static struct palm27x_asoc_info palmld_asoc_pdata = {
-	.jack_gpio	= GPIO_NR_PALMLD_EARPHONE_DETECT,
+	.jack_gpio	= GPIO13_PALMLD_EARPHONE_DETECT,
 };
 
 static struct platform_device palmld_asoc = {
diff --git a/arch/arm/mach-pxa/palmt5.c b/arch/arm/mach-pxa/palmt5.c
index 0b36d7d..8037cfc 100644
--- a/arch/arm/mach-pxa/palmt5.c
+++ b/arch/arm/mach-pxa/palmt5.c
@@ -107,9 +107,9 @@ static unsigned long palmt5_pin_config[] __initdata = {
  ******************************************************************************/
 static struct pxamci_platform_data palmt5_mci_platform_data = {
 	.ocr_mask		= MMC_VDD_32_33 | MMC_VDD_33_34,
-	.gpio_card_detect	= GPIO_NR_PALMT5_SD_DETECT_N,
-	.gpio_card_ro		= GPIO_NR_PALMT5_SD_READONLY,
-	.gpio_power		= GPIO_NR_PALMT5_SD_POWER,
+	.gpio_card_detect	= GPIO14_PALMT5_SD_DETECT_N,
+	.gpio_card_ro		= GPIO115_PALMT5_SD_READONLY,
+	.gpio_power		= GPIO114_PALMT5_SD_POWER,
 	.detect_delay_ms	= 200,
 };
 
@@ -145,7 +145,7 @@ static struct pxa27x_keypad_platform_data palmt5_keypad_platform_data = {
  * GPIO keys
  ******************************************************************************/
 static struct gpio_keys_button palmt5_pxa_buttons[] = {
-	{KEY_F8, GPIO_NR_PALMT5_HOTSYNC_BUTTON_N, 1, "HotSync Button" },
+	{KEY_F8, GPIO10_PALMT5_HOTSYNC_BUTTON_N, 1, "HotSync Button" },
 };
 
 static struct gpio_keys_platform_data palmt5_pxa_keys_data = {
@@ -168,39 +168,39 @@ static int palmt5_backlight_init(struct device *dev)
 {
 	int ret;
 
-	ret = gpio_request(GPIO_NR_PALMT5_BL_POWER, "BL POWER");
+	ret = gpio_request(GPIO84_PALMT5_BL_POWER, "BL POWER");
 	if (ret)
 		goto err;
-	ret = gpio_direction_output(GPIO_NR_PALMT5_BL_POWER, 0);
+	ret = gpio_direction_output(GPIO84_PALMT5_BL_POWER, 0);
 	if (ret)
 		goto err2;
-	ret = gpio_request(GPIO_NR_PALMT5_LCD_POWER, "LCD POWER");
+	ret = gpio_request(GPIO96_PALMT5_LCD_POWER, "LCD POWER");
 	if (ret)
 		goto err2;
-	ret = gpio_direction_output(GPIO_NR_PALMT5_LCD_POWER, 0);
+	ret = gpio_direction_output(GPIO96_PALMT5_LCD_POWER, 0);
 	if (ret)
 		goto err3;
 
 	return 0;
 err3:
-	gpio_free(GPIO_NR_PALMT5_LCD_POWER);
+	gpio_free(GPIO96_PALMT5_LCD_POWER);
 err2:
-	gpio_free(GPIO_NR_PALMT5_BL_POWER);
+	gpio_free(GPIO84_PALMT5_BL_POWER);
 err:
 	return ret;
 }
 
 static int palmt5_backlight_notify(struct device *dev, int brightness)
 {
-	gpio_set_value(GPIO_NR_PALMT5_BL_POWER, brightness);
-	gpio_set_value(GPIO_NR_PALMT5_LCD_POWER, brightness);
+	gpio_set_value(GPIO84_PALMT5_BL_POWER, brightness);
+	gpio_set_value(GPIO96_PALMT5_LCD_POWER, brightness);
 	return brightness;
 }
 
 static void palmt5_backlight_exit(struct device *dev)
 {
-	gpio_free(GPIO_NR_PALMT5_BL_POWER);
-	gpio_free(GPIO_NR_PALMT5_LCD_POWER);
+	gpio_free(GPIO84_PALMT5_BL_POWER);
+	gpio_free(GPIO96_PALMT5_LCD_POWER);
 }
 
 static struct platform_pwm_backlight_data palmt5_backlight_data = {
@@ -225,7 +225,7 @@ static struct platform_device palmt5_backlight = {
  * IrDA
  ******************************************************************************/
 static struct pxaficp_platform_data palmt5_ficp_platform_data = {
-	.gpio_pwdown		= GPIO_NR_PALMT5_IR_DISABLE,
+	.gpio_pwdown		= GPIO40_PALMT5_IR_DISABLE,
 	.transceiver_cap	= IR_SIRMODE | IR_OFF,
 };
 
@@ -233,9 +233,9 @@ static struct pxaficp_platform_data palmt5_ficp_platform_data = {
  * UDC
  ******************************************************************************/
 static struct gpio_vbus_mach_info palmt5_udc_info = {
-	.gpio_vbus		= GPIO_NR_PALMT5_USB_DETECT_N,
+	.gpio_vbus		= GPIO15_PALMT5_USB_DETECT_N,
 	.gpio_vbus_inverted	= 1,
-	.gpio_pullup		= GPIO_NR_PALMT5_USB_PULLUP,
+	.gpio_pullup		= GPIO93_PALMT5_USB_PULLUP,
 };
 
 static struct platform_device palmt5_gpio_vbus = {
@@ -253,28 +253,28 @@ static int power_supply_init(struct device *dev)
 {
 	int ret;
 
-	ret = gpio_request(GPIO_NR_PALMT5_POWER_DETECT, "CABLE_STATE_AC");
+	ret = gpio_request(GPIO90_PALMT5_POWER_DETECT, "CABLE_STATE_AC");
 	if (ret)
 		goto err1;
-	ret = gpio_direction_input(GPIO_NR_PALMT5_POWER_DETECT);
+	ret = gpio_direction_input(GPIO90_PALMT5_POWER_DETECT);
 	if (ret)
 		goto err2;
 
 	return 0;
 err2:
-	gpio_free(GPIO_NR_PALMT5_POWER_DETECT);
+	gpio_free(GPIO90_PALMT5_POWER_DETECT);
 err1:
 	return ret;
 }
 
 static int palmt5_is_ac_online(void)
 {
-	return gpio_get_value(GPIO_NR_PALMT5_POWER_DETECT);
+	return gpio_get_value(GPIO90_PALMT5_POWER_DETECT);
 }
 
 static void power_supply_exit(struct device *dev)
 {
-	gpio_free(GPIO_NR_PALMT5_POWER_DETECT);
+	gpio_free(GPIO90_PALMT5_POWER_DETECT);
 }
 
 static char *palmt5_supplicants[] = {
@@ -324,7 +324,7 @@ static pxa2xx_audio_ops_t palmt5_ac97_pdata = {
 };
 
 static struct palm27x_asoc_info palmt5_asoc_pdata = {
-	.jack_gpio	= GPIO_NR_PALMT5_EARPHONE_DETECT,
+	.jack_gpio	= GPIO107_PALMT5_EARPHONE_DETECT,
 };
 
 static struct platform_device palmt5_asoc = {
@@ -392,9 +392,9 @@ static struct platform_device *devices[] __initdata = {
 /* setup udc GPIOs initial state */
 static void __init palmt5_udc_init(void)
 {
-	if (!gpio_request(GPIO_NR_PALMT5_USB_PULLUP, "UDC Vbus")) {
-		gpio_direction_output(GPIO_NR_PALMT5_USB_PULLUP, 1);
-		gpio_free(GPIO_NR_PALMT5_USB_PULLUP);
+	if (!gpio_request(GPIO93_PALMT5_USB_PULLUP, "UDC Vbus")) {
+		gpio_direction_output(GPIO93_PALMT5_USB_PULLUP, 1);
+		gpio_free(GPIO93_PALMT5_USB_PULLUP);
 	}
 }
 
diff --git a/arch/arm/mach-pxa/palmtx.c b/arch/arm/mach-pxa/palmtx.c
index a5429cd..a835034 100644
--- a/arch/arm/mach-pxa/palmtx.c
+++ b/arch/arm/mach-pxa/palmtx.c
@@ -167,9 +167,9 @@ static struct platform_device palmtx_flash = {
  ******************************************************************************/
 static struct pxamci_platform_data palmtx_mci_platform_data = {
 	.ocr_mask		= MMC_VDD_32_33 | MMC_VDD_33_34,
-	.gpio_card_detect	= GPIO_NR_PALMTX_SD_DETECT_N,
-	.gpio_card_ro		= GPIO_NR_PALMTX_SD_READONLY,
-	.gpio_power		= GPIO_NR_PALMTX_SD_POWER,
+	.gpio_card_detect	= GPIO14_PALMTX_SD_DETECT_N,
+	.gpio_card_ro		= GPIO115_PALMTX_SD_READONLY,
+	.gpio_power		= GPIO114_PALMTX_SD_POWER,
 	.detect_delay_ms	= 200,
 };
 
@@ -205,7 +205,7 @@ static struct pxa27x_keypad_platform_data palmtx_keypad_platform_data = {
  * GPIO keys
  ******************************************************************************/
 static struct gpio_keys_button palmtx_pxa_buttons[] = {
-	{KEY_F8, GPIO_NR_PALMTX_HOTSYNC_BUTTON_N, 1, "HotSync Button" },
+	{KEY_F8, GPIO10_PALMTX_HOTSYNC_BUTTON_N, 1, "HotSync Button" },
 };
 
 static struct gpio_keys_platform_data palmtx_pxa_keys_data = {
@@ -228,39 +228,39 @@ static int palmtx_backlight_init(struct device *dev)
 {
 	int ret;
 
-	ret = gpio_request(GPIO_NR_PALMTX_BL_POWER, "BL POWER");
+	ret = gpio_request(GPIO84_PALMTX_BL_POWER, "BL POWER");
 	if (ret)
 		goto err;
-	ret = gpio_direction_output(GPIO_NR_PALMTX_BL_POWER, 0);
+	ret = gpio_direction_output(GPIO84_PALMTX_BL_POWER, 0);
 	if (ret)
 		goto err2;
-	ret = gpio_request(GPIO_NR_PALMTX_LCD_POWER, "LCD POWER");
+	ret = gpio_request(GPIO96_PALMTX_LCD_POWER, "LCD POWER");
 	if (ret)
 		goto err2;
-	ret = gpio_direction_output(GPIO_NR_PALMTX_LCD_POWER, 0);
+	ret = gpio_direction_output(GPIO96_PALMTX_LCD_POWER, 0);
 	if (ret)
 		goto err3;
 
 	return 0;
 err3:
-	gpio_free(GPIO_NR_PALMTX_LCD_POWER);
+	gpio_free(GPIO96_PALMTX_LCD_POWER);
 err2:
-	gpio_free(GPIO_NR_PALMTX_BL_POWER);
+	gpio_free(GPIO84_PALMTX_BL_POWER);
 err:
 	return ret;
 }
 
 static int palmtx_backlight_notify(struct device *dev, int brightness)
 {
-	gpio_set_value(GPIO_NR_PALMTX_BL_POWER, brightness);
-	gpio_set_value(GPIO_NR_PALMTX_LCD_POWER, brightness);
+	gpio_set_value(GPIO84_PALMTX_BL_POWER, brightness);
+	gpio_set_value(GPIO96_PALMTX_LCD_POWER, brightness);
 	return brightness;
 }
 
 static void palmtx_backlight_exit(struct device *dev)
 {
-	gpio_free(GPIO_NR_PALMTX_BL_POWER);
-	gpio_free(GPIO_NR_PALMTX_LCD_POWER);
+	gpio_free(GPIO84_PALMTX_BL_POWER);
+	gpio_free(GPIO96_PALMTX_LCD_POWER);
 }
 
 static struct platform_pwm_backlight_data palmtx_backlight_data = {
@@ -285,7 +285,7 @@ static struct platform_device palmtx_backlight = {
  * IrDA
  ******************************************************************************/
 static struct pxaficp_platform_data palmtx_ficp_platform_data = {
-	.gpio_pwdown		= GPIO_NR_PALMTX_IR_DISABLE,
+	.gpio_pwdown		= GPIO40_PALMTX_IR_DISABLE,
 	.transceiver_cap	= IR_SIRMODE | IR_OFF,
 };
 
@@ -293,9 +293,9 @@ static struct pxaficp_platform_data palmtx_ficp_platform_data = {
  * UDC
  ******************************************************************************/
 static struct gpio_vbus_mach_info palmtx_udc_info = {
-	.gpio_vbus		= GPIO_NR_PALMTX_USB_DETECT_N,
+	.gpio_vbus		= GPIO13_PALMTX_USB_DETECT_N,
 	.gpio_vbus_inverted	= 1,
-	.gpio_pullup		= GPIO_NR_PALMTX_USB_PULLUP,
+	.gpio_pullup		= GPIO93_PALMTX_USB_PULLUP,
 };
 
 static struct platform_device palmtx_gpio_vbus = {
@@ -313,29 +313,29 @@ static int power_supply_init(struct device *dev)
 {
 	int ret;
 
-	ret = gpio_request(GPIO_NR_PALMTX_POWER_DETECT, "CABLE_STATE_AC");
+	ret = gpio_request(GPIO12_PALMTX_POWER_DETECT, "CABLE_STATE_AC");
 	if (ret)
 		goto err1;
-	ret = gpio_direction_input(GPIO_NR_PALMTX_POWER_DETECT);
+	ret = gpio_direction_input(GPIO12_PALMTX_POWER_DETECT);
 	if (ret)
 		goto err2;
 
 	return 0;
 
 err2:
-	gpio_free(GPIO_NR_PALMTX_POWER_DETECT);
+	gpio_free(GPIO12_PALMTX_POWER_DETECT);
 err1:
 	return ret;
 }
 
 static int palmtx_is_ac_online(void)
 {
-	return gpio_get_value(GPIO_NR_PALMTX_POWER_DETECT);
+	return gpio_get_value(GPIO12_PALMTX_POWER_DETECT);
 }
 
 static void power_supply_exit(struct device *dev)
 {
-	gpio_free(GPIO_NR_PALMTX_POWER_DETECT);
+	gpio_free(GPIO12_PALMTX_POWER_DETECT);
 }
 
 static char *palmtx_supplicants[] = {
@@ -385,7 +385,7 @@ static pxa2xx_audio_ops_t palmtx_ac97_pdata = {
 };
 
 static struct palm27x_asoc_info palmtx_asoc_pdata = {
-	.jack_gpio	= GPIO_NR_PALMTX_EARPHONE_DETECT,
+	.jack_gpio	= GPIO107_PALMTX_EARPHONE_DETECT,
 };
 
 static struct platform_device palmtx_asoc = {
@@ -542,9 +542,9 @@ static void __init palmtx_map_io(void)
 /* setup udc GPIOs initial state */
 static void __init palmtx_udc_init(void)
 {
-	if (!gpio_request(GPIO_NR_PALMTX_USB_PULLUP, "UDC Vbus")) {
-		gpio_direction_output(GPIO_NR_PALMTX_USB_PULLUP, 1);
-		gpio_free(GPIO_NR_PALMTX_USB_PULLUP);
+	if (!gpio_request(GPIO93_PALMTX_USB_PULLUP, "UDC Vbus")) {
+		gpio_direction_output(GPIO93_PALMTX_USB_PULLUP, 1);
+		gpio_free(GPIO93_PALMTX_USB_PULLUP);
 	}
 }
 
diff --git a/arch/arm/mach-pxa/palmz72.c b/arch/arm/mach-pxa/palmz72.c
index b78c6b4..91bc5a3 100644
--- a/arch/arm/mach-pxa/palmz72.c
+++ b/arch/arm/mach-pxa/palmz72.c
@@ -115,9 +115,9 @@ static unsigned long palmz72_pin_config[] __initdata = {
  * select, i.e. it is inverted */
 static struct pxamci_platform_data palmz72_mci_platform_data = {
 	.ocr_mask		= MMC_VDD_32_33 | MMC_VDD_33_34,
-	.gpio_card_detect	= GPIO_NR_PALMZ72_SD_DETECT_N,
-	.gpio_card_ro		= GPIO_NR_PALMZ72_SD_RO,
-	.gpio_power		= GPIO_NR_PALMZ72_SD_POWER_N,
+	.gpio_card_detect	= GPIO14_PALMZ72_SD_DETECT_N,
+	.gpio_card_ro		= GPIO115_PALMZ72_SD_RO,
+	.gpio_power		= GPIO98_PALMZ72_SD_POWER_N,
 	.gpio_power_invert	= 1,
 };
 
@@ -156,39 +156,39 @@ static int palmz72_backlight_init(struct device *dev)
 {
 	int ret;
 
-	ret = gpio_request(GPIO_NR_PALMZ72_BL_POWER, "BL POWER");
+	ret = gpio_request(GPIO20_PALMZ72_BL_POWER, "BL POWER");
 	if (ret)
 		goto err;
-	ret = gpio_direction_output(GPIO_NR_PALMZ72_BL_POWER, 0);
+	ret = gpio_direction_output(GPIO20_PALMZ72_BL_POWER, 0);
 	if (ret)
 		goto err2;
-	ret = gpio_request(GPIO_NR_PALMZ72_LCD_POWER, "LCD POWER");
+	ret = gpio_request(GPIO96_PALMZ72_LCD_POWER, "LCD POWER");
 	if (ret)
 		goto err2;
-	ret = gpio_direction_output(GPIO_NR_PALMZ72_LCD_POWER, 0);
+	ret = gpio_direction_output(GPIO96_PALMZ72_LCD_POWER, 0);
 	if (ret)
 		goto err3;
 
 	return 0;
 err3:
-	gpio_free(GPIO_NR_PALMZ72_LCD_POWER);
+	gpio_free(GPIO96_PALMZ72_LCD_POWER);
 err2:
-	gpio_free(GPIO_NR_PALMZ72_BL_POWER);
+	gpio_free(GPIO20_PALMZ72_BL_POWER);
 err:
 	return ret;
 }
 
 static int palmz72_backlight_notify(struct device *dev, int brightness)
 {
-	gpio_set_value(GPIO_NR_PALMZ72_BL_POWER, brightness);
-	gpio_set_value(GPIO_NR_PALMZ72_LCD_POWER, brightness);
+	gpio_set_value(GPIO20_PALMZ72_BL_POWER, brightness);
+	gpio_set_value(GPIO96_PALMZ72_LCD_POWER, brightness);
 	return brightness;
 }
 
 static void palmz72_backlight_exit(struct device *dev)
 {
-	gpio_free(GPIO_NR_PALMZ72_BL_POWER);
-	gpio_free(GPIO_NR_PALMZ72_LCD_POWER);
+	gpio_free(GPIO20_PALMZ72_BL_POWER);
+	gpio_free(GPIO96_PALMZ72_LCD_POWER);
 }
 
 static struct platform_pwm_backlight_data palmz72_backlight_data = {
@@ -213,7 +213,7 @@ static struct platform_device palmz72_backlight = {
  * IrDA
  ******************************************************************************/
 static struct pxaficp_platform_data palmz72_ficp_platform_data = {
-	.gpio_pwdown		= GPIO_NR_PALMZ72_IR_DISABLE,
+	.gpio_pwdown		= GPIO49_PALMZ72_IR_DISABLE,
 	.transceiver_cap	= IR_SIRMODE | IR_OFF,
 };
 
@@ -224,7 +224,7 @@ static struct gpio_led gpio_leds[] = {
 	{
 		.name			= "palmz72:green:led",
 		.default_trigger	= "none",
-		.gpio			= GPIO_NR_PALMZ72_LED_GREEN,
+		.gpio			= GPIO88_PALMZ72_LED_GREEN,
 	},
 };
 
@@ -245,8 +245,8 @@ static struct platform_device palmz72_leds = {
  * UDC
  ******************************************************************************/
 static struct gpio_vbus_mach_info palmz72_udc_info = {
-	.gpio_vbus		= GPIO_NR_PALMZ72_USB_DETECT_N,
-	.gpio_pullup		= GPIO_NR_PALMZ72_USB_PULLUP,
+	.gpio_vbus		= GPIO15_PALMZ72_USB_DETECT_N,
+	.gpio_pullup		= GPIO95_PALMZ72_USB_PULLUP,
 };
 
 static struct platform_device palmz72_gpio_vbus = {
@@ -264,43 +264,43 @@ static int power_supply_init(struct device *dev)
 {
 	int ret;
 
-	ret = gpio_request(GPIO_NR_PALMZ72_POWER_DETECT, "CABLE_STATE_AC");
+	ret = gpio_request(GPIO0_PALMZ72_POWER_DETECT, "CABLE_STATE_AC");
 	if (ret)
 		goto err1;
-	ret = gpio_direction_input(GPIO_NR_PALMZ72_POWER_DETECT);
+	ret = gpio_direction_input(GPIO0_PALMZ72_POWER_DETECT);
 	if (ret)
 		goto err2;
 
-	ret = gpio_request(GPIO_NR_PALMZ72_USB_DETECT_N, "CABLE_STATE_USB");
+	ret = gpio_request(GPIO15_PALMZ72_USB_DETECT_N, "CABLE_STATE_USB");
 	if (ret)
 		goto err2;
-	ret = gpio_direction_input(GPIO_NR_PALMZ72_USB_DETECT_N);
+	ret = gpio_direction_input(GPIO15_PALMZ72_USB_DETECT_N);
 	if (ret)
 		goto err3;
 
 	return 0;
 err3:
-	gpio_free(GPIO_NR_PALMZ72_USB_DETECT_N);
+	gpio_free(GPIO15_PALMZ72_USB_DETECT_N);
 err2:
-	gpio_free(GPIO_NR_PALMZ72_POWER_DETECT);
+	gpio_free(GPIO0_PALMZ72_POWER_DETECT);
 err1:
 	return ret;
 }
 
 static int palmz72_is_ac_online(void)
 {
-	return gpio_get_value(GPIO_NR_PALMZ72_POWER_DETECT);
+	return gpio_get_value(GPIO0_PALMZ72_POWER_DETECT);
 }
 
 static int palmz72_is_usb_online(void)
 {
-	return !gpio_get_value(GPIO_NR_PALMZ72_USB_DETECT_N);
+	return !gpio_get_value(GPIO15_PALMZ72_USB_DETECT_N);
 }
 
 static void power_supply_exit(struct device *dev)
 {
-	gpio_free(GPIO_NR_PALMZ72_USB_DETECT_N);
-	gpio_free(GPIO_NR_PALMZ72_POWER_DETECT);
+	gpio_free(GPIO15_PALMZ72_USB_DETECT_N);
+	gpio_free(GPIO0_PALMZ72_POWER_DETECT);
 }
 
 static char *palmz72_supplicants[] = {
@@ -468,9 +468,9 @@ static struct platform_device *devices[] __initdata = {
 /* setup udc GPIOs initial state */
 static void __init palmz72_udc_init(void)
 {
-	if (!gpio_request(GPIO_NR_PALMZ72_USB_PULLUP, "USB Pullup")) {
-		gpio_direction_output(GPIO_NR_PALMZ72_USB_PULLUP, 0);
-		gpio_free(GPIO_NR_PALMZ72_USB_PULLUP);
+	if (!gpio_request(GPIO95_PALMZ72_USB_PULLUP, "USB Pullup")) {
+		gpio_direction_output(GPIO95_PALMZ72_USB_PULLUP, 0);
+		gpio_free(GPIO95_PALMZ72_USB_PULLUP);
 	}
 }
 
diff --git a/configs/config-colibri b/configs/config-colibri
new file mode 100644
index 0000000..e69de29
diff --git a/configs/config-income b/configs/config-income
new file mode 100644
index 0000000..e69de29
diff --git a/configs/config-littleton b/configs/config-littleton
new file mode 100644
index 0000000..e69de29
diff --git a/configs/config-vpac270 b/configs/config-vpac270
new file mode 100644
index 0000000..e69de29
diff --git a/configs/config-vpac270-minimal b/configs/config-vpac270-minimal
new file mode 100644
index 0000000..e69de29
diff --git a/configs/config-zaurus b/configs/config-zaurus
new file mode 100644
index 0000000..e69de29
diff --git a/configs/config-zipitz2 b/configs/config-zipitz2
new file mode 100644
index 0000000..e69de29
diff --git a/drivers/ata/pata_palmld.c b/drivers/ata/pata_palmld.c
index 11fb4cc..7ca74d6 100644
--- a/drivers/ata/pata_palmld.c
+++ b/drivers/ata/pata_palmld.c
@@ -61,24 +61,24 @@ static __devinit int palmld_pata_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	/* request and activate power GPIO, IRQ GPIO */
-	ret = gpio_request(GPIO_NR_PALMLD_IDE_PWEN, "HDD PWR");
+	ret = gpio_request(GPIO115_PALMLD_IDE_PWEN, "HDD PWR");
 	if (ret)
 		goto err1;
-	ret = gpio_direction_output(GPIO_NR_PALMLD_IDE_PWEN, 1);
+	ret = gpio_direction_output(GPIO115_PALMLD_IDE_PWEN, 1);
 	if (ret)
 		goto err2;
 
-	ret = gpio_request(GPIO_NR_PALMLD_IDE_RESET, "HDD RST");
+	ret = gpio_request(GPIO98_PALMLD_IDE_RESET, "HDD RST");
 	if (ret)
 		goto err2;
-	ret = gpio_direction_output(GPIO_NR_PALMLD_IDE_RESET, 0);
+	ret = gpio_direction_output(GPIO98_PALMLD_IDE_RESET, 0);
 	if (ret)
 		goto err3;
 
 	/* reset the drive */
-	gpio_set_value(GPIO_NR_PALMLD_IDE_RESET, 0);
+	gpio_set_value(GPIO98_PALMLD_IDE_RESET, 0);
 	msleep(30);
-	gpio_set_value(GPIO_NR_PALMLD_IDE_RESET, 1);
+	gpio_set_value(GPIO98_PALMLD_IDE_RESET, 1);
 	msleep(30);
 
 	/* setup the ata port */
@@ -100,9 +100,9 @@ static __devinit int palmld_pata_probe(struct platform_device *pdev)
 					&palmld_sht);
 
 err3:
-	gpio_free(GPIO_NR_PALMLD_IDE_RESET);
+	gpio_free(GPIO98_PALMLD_IDE_RESET);
 err2:
-	gpio_free(GPIO_NR_PALMLD_IDE_PWEN);
+	gpio_free(GPIO115_PALMLD_IDE_PWEN);
 err1:
 	return ret;
 }
@@ -114,10 +114,10 @@ static __devexit int palmld_pata_remove(struct platform_device *dev)
 	ata_host_detach(host);
 
 	/* power down the HDD */
-	gpio_set_value(GPIO_NR_PALMLD_IDE_PWEN, 0);
+	gpio_set_value(GPIO115_PALMLD_IDE_PWEN, 0);
 
-	gpio_free(GPIO_NR_PALMLD_IDE_RESET);
-	gpio_free(GPIO_NR_PALMLD_IDE_PWEN);
+	gpio_free(GPIO98_PALMLD_IDE_RESET);
+	gpio_free(GPIO115_PALMLD_IDE_PWEN);
 
 	return 0;
 }
diff --git a/drivers/pcmcia/pxa2xx_palmld.c b/drivers/pcmcia/pxa2xx_palmld.c
index 6fb6f7f..4317657 100644
--- a/drivers/pcmcia/pxa2xx_palmld.c
+++ b/drivers/pcmcia/pxa2xx_palmld.c
@@ -24,52 +24,52 @@ static int palmld_pcmcia_hw_init(struct soc_pcmcia_socket *skt)
 {
 	int ret;
 
-	ret = gpio_request(GPIO_NR_PALMLD_PCMCIA_POWER, "PCMCIA PWR");
+	ret = gpio_request(GPIO36_PALMLD_PCMCIA_POWER, "PCMCIA PWR");
 	if (ret)
 		goto err1;
-	ret = gpio_direction_output(GPIO_NR_PALMLD_PCMCIA_POWER, 0);
+	ret = gpio_direction_output(GPIO36_PALMLD_PCMCIA_POWER, 0);
 	if (ret)
 		goto err2;
 
-	ret = gpio_request(GPIO_NR_PALMLD_PCMCIA_RESET, "PCMCIA RST");
+	ret = gpio_request(GPIO81_PALMLD_PCMCIA_RESET, "PCMCIA RST");
 	if (ret)
 		goto err2;
-	ret = gpio_direction_output(GPIO_NR_PALMLD_PCMCIA_RESET, 1);
+	ret = gpio_direction_output(GPIO81_PALMLD_PCMCIA_RESET, 1);
 	if (ret)
 		goto err3;
 
-	ret = gpio_request(GPIO_NR_PALMLD_PCMCIA_READY, "PCMCIA RDY");
+	ret = gpio_request(GPIO38_PALMLD_PCMCIA_READY, "PCMCIA RDY");
 	if (ret)
 		goto err3;
-	ret = gpio_direction_input(GPIO_NR_PALMLD_PCMCIA_READY);
+	ret = gpio_direction_input(GPIO38_PALMLD_PCMCIA_READY);
 	if (ret)
 		goto err4;
 
-	skt->socket.pci_irq = IRQ_GPIO(GPIO_NR_PALMLD_PCMCIA_READY);
+	skt->socket.pci_irq = IRQ_GPIO(GPIO38_PALMLD_PCMCIA_READY);
 	return 0;
 
 err4:
-	gpio_free(GPIO_NR_PALMLD_PCMCIA_READY);
+	gpio_free(GPIO38_PALMLD_PCMCIA_READY);
 err3:
-	gpio_free(GPIO_NR_PALMLD_PCMCIA_RESET);
+	gpio_free(GPIO81_PALMLD_PCMCIA_RESET);
 err2:
-	gpio_free(GPIO_NR_PALMLD_PCMCIA_POWER);
+	gpio_free(GPIO36_PALMLD_PCMCIA_POWER);
 err1:
 	return ret;
 }
 
 static void palmld_pcmcia_hw_shutdown(struct soc_pcmcia_socket *skt)
 {
-	gpio_free(GPIO_NR_PALMLD_PCMCIA_READY);
-	gpio_free(GPIO_NR_PALMLD_PCMCIA_RESET);
-	gpio_free(GPIO_NR_PALMLD_PCMCIA_POWER);
+	gpio_free(GPIO38_PALMLD_PCMCIA_READY);
+	gpio_free(GPIO81_PALMLD_PCMCIA_RESET);
+	gpio_free(GPIO36_PALMLD_PCMCIA_POWER);
 }
 
 static void palmld_pcmcia_socket_state(struct soc_pcmcia_socket *skt,
 					struct pcmcia_state *state)
 {
 	state->detect = 1; /* always inserted */
-	state->ready  = !!gpio_get_value(GPIO_NR_PALMLD_PCMCIA_READY);
+	state->ready  = !!gpio_get_value(GPIO38_PALMLD_PCMCIA_READY);
 	state->bvd1   = 1;
 	state->bvd2   = 1;
 	state->wrprot = 0;
@@ -80,8 +80,8 @@ static void palmld_pcmcia_socket_state(struct soc_pcmcia_socket *skt,
 static int palmld_pcmcia_configure_socket(struct soc_pcmcia_socket *skt,
 					const socket_state_t *state)
 {
-	gpio_set_value(GPIO_NR_PALMLD_PCMCIA_POWER, 1);
-	gpio_set_value(GPIO_NR_PALMLD_PCMCIA_RESET,
+	gpio_set_value(GPIO36_PALMLD_PCMCIA_POWER, 1);
+	gpio_set_value(GPIO81_PALMLD_PCMCIA_RESET,
 			!!(state->flags & SS_RESET));
 
 	return 0;
diff --git a/drivers/pcmcia/pxa2xx_palmtx.c b/drivers/pcmcia/pxa2xx_palmtx.c
index b07b247..cc80531 100644
--- a/drivers/pcmcia/pxa2xx_palmtx.c
+++ b/drivers/pcmcia/pxa2xx_palmtx.c
@@ -25,62 +25,62 @@ static int palmtx_pcmcia_hw_init(struct soc_pcmcia_socket *skt)
 {
 	int ret;
 
-	ret = gpio_request(GPIO_NR_PALMTX_PCMCIA_POWER1, "PCMCIA PWR1");
+	ret = gpio_request(GPIO94_PALMTX_PCMCIA_POWER1, "PCMCIA PWR1");
 	if (ret)
 		goto err1;
-	ret = gpio_direction_output(GPIO_NR_PALMTX_PCMCIA_POWER1, 0);
+	ret = gpio_direction_output(GPIO94_PALMTX_PCMCIA_POWER1, 0);
 	if (ret)
 		goto err2;
 
-	ret = gpio_request(GPIO_NR_PALMTX_PCMCIA_POWER2, "PCMCIA PWR2");
+	ret = gpio_request(GPIO108_PALMTX_PCMCIA_POWER2, "PCMCIA PWR2");
 	if (ret)
 		goto err2;
-	ret = gpio_direction_output(GPIO_NR_PALMTX_PCMCIA_POWER2, 0);
+	ret = gpio_direction_output(GPIO108_PALMTX_PCMCIA_POWER2, 0);
 	if (ret)
 		goto err3;
 
-	ret = gpio_request(GPIO_NR_PALMTX_PCMCIA_RESET, "PCMCIA RST");
+	ret = gpio_request(GPIO79_PALMTX_PCMCIA_RESET, "PCMCIA RST");
 	if (ret)
 		goto err3;
-	ret = gpio_direction_output(GPIO_NR_PALMTX_PCMCIA_RESET, 1);
+	ret = gpio_direction_output(GPIO79_PALMTX_PCMCIA_RESET, 1);
 	if (ret)
 		goto err4;
 
-	ret = gpio_request(GPIO_NR_PALMTX_PCMCIA_READY, "PCMCIA RDY");
+	ret = gpio_request(GPIO116_PALMTX_PCMCIA_READY, "PCMCIA RDY");
 	if (ret)
 		goto err4;
-	ret = gpio_direction_input(GPIO_NR_PALMTX_PCMCIA_READY);
+	ret = gpio_direction_input(GPIO116_PALMTX_PCMCIA_READY);
 	if (ret)
 		goto err5;
 
-	skt->socket.pci_irq = gpio_to_irq(GPIO_NR_PALMTX_PCMCIA_READY);
+	skt->socket.pci_irq = gpio_to_irq(GPIO116_PALMTX_PCMCIA_READY);
 	return 0;
 
 err5:
-	gpio_free(GPIO_NR_PALMTX_PCMCIA_READY);
+	gpio_free(GPIO116_PALMTX_PCMCIA_READY);
 err4:
-	gpio_free(GPIO_NR_PALMTX_PCMCIA_RESET);
+	gpio_free(GPIO79_PALMTX_PCMCIA_RESET);
 err3:
-	gpio_free(GPIO_NR_PALMTX_PCMCIA_POWER2);
+	gpio_free(GPIO108_PALMTX_PCMCIA_POWER2);
 err2:
-	gpio_free(GPIO_NR_PALMTX_PCMCIA_POWER1);
+	gpio_free(GPIO94_PALMTX_PCMCIA_POWER1);
 err1:
 	return ret;
 }
 
 static void palmtx_pcmcia_hw_shutdown(struct soc_pcmcia_socket *skt)
 {
-	gpio_free(GPIO_NR_PALMTX_PCMCIA_READY);
-	gpio_free(GPIO_NR_PALMTX_PCMCIA_RESET);
-	gpio_free(GPIO_NR_PALMTX_PCMCIA_POWER2);
-	gpio_free(GPIO_NR_PALMTX_PCMCIA_POWER1);
+	gpio_free(GPIO116_PALMTX_PCMCIA_READY);
+	gpio_free(GPIO79_PALMTX_PCMCIA_RESET);
+	gpio_free(GPIO108_PALMTX_PCMCIA_POWER2);
+	gpio_free(GPIO94_PALMTX_PCMCIA_POWER1);
 }
 
 static void palmtx_pcmcia_socket_state(struct soc_pcmcia_socket *skt,
 					struct pcmcia_state *state)
 {
 	state->detect = 1; /* always inserted */
-	state->ready  = !!gpio_get_value(GPIO_NR_PALMTX_PCMCIA_READY);
+	state->ready  = !!gpio_get_value(GPIO116_PALMTX_PCMCIA_READY);
 	state->bvd1   = 1;
 	state->bvd2   = 1;
 	state->wrprot = 0;
@@ -92,9 +92,9 @@ static int
 palmtx_pcmcia_configure_socket(struct soc_pcmcia_socket *skt,
 				const socket_state_t *state)
 {
-	gpio_set_value(GPIO_NR_PALMTX_PCMCIA_POWER1, 1);
-	gpio_set_value(GPIO_NR_PALMTX_PCMCIA_POWER2, 1);
-	gpio_set_value(GPIO_NR_PALMTX_PCMCIA_RESET,
+	gpio_set_value(GPIO94_PALMTX_PCMCIA_POWER1, 1);
+	gpio_set_value(GPIO108_PALMTX_PCMCIA_POWER2, 1);
+	gpio_set_value(GPIO79_PALMTX_PCMCIA_RESET,
 			!!(state->flags & SS_RESET));
 
 	return 0;
-- 
1.7.1
