From: notasas@gmail.com (Grazvydas Ignotas)
Date: Sun, 19 Feb 2012 00:46:20 +0200
Subject: [PATCH] ARM: omap: pandora: add support for backlight and poweroff
Message-ID: <1329605180-24939-1-git-send-email-notasas@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add platform data for drivers that recently appeared in kernel:
backlight and TWL4030 poweroff support.

Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
---
well backlight is queued for 3.4, but poweroff support is already here in 3.3.

 arch/arm/mach-omap2/board-omap3pandora.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3pandora.c b/arch/arm/mach-omap2/board-omap3pandora.c
index 2224b5d..835180f 100644
--- a/arch/arm/mach-omap2/board-omap3pandora.c
+++ b/arch/arm/mach-omap2/board-omap3pandora.c
@@ -121,6 +121,11 @@ static struct platform_device pandora_leds_gpio = {
 	},
 };
 
+static struct platform_device pandora_backlight = {
+	.name	= "pandora-backlight",
+	.id	= -1,
+};
+
 #define GPIO_BUTTON(gpio_num, ev_type, ev_code, act_low, descr)	\
 {								\
 	.gpio		= gpio_num,				\
@@ -476,6 +481,10 @@ static struct platform_device pandora_vwlan_device = {
 
 static struct twl4030_bci_platform_data pandora_bci_data;
 
+static struct twl4030_power_data pandora_power_data = {
+	.use_poweroff	= true,
+};
+
 static struct twl4030_platform_data omap3pandora_twldata = {
 	.gpio		= &omap3pandora_gpio_data,
 	.vmmc1		= &pandora_vmmc1,
@@ -486,6 +495,7 @@ static struct twl4030_platform_data omap3pandora_twldata = {
 	.vsim		= &pandora_vsim,
 	.keypad		= &pandora_kp_data,
 	.bci		= &pandora_bci_data,
+	.power		= &pandora_power_data,
 };
 
 static struct i2c_board_info __initdata omap3pandora_i2c3_boardinfo[] = {
@@ -557,6 +567,7 @@ static struct platform_device *omap3pandora_devices[] __initdata = {
 	&pandora_leds_gpio,
 	&pandora_keys_gpio,
 	&pandora_vwlan_device,
+	&pandora_backlight,
 };
 
 static const struct usbhs_omap_board_data usbhs_bdata __initconst = {
-- 
1.7.0.4
