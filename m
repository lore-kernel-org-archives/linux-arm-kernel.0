From: khilman@baylibre.com (Kevin Hilman)
Date: Fri,  6 May 2016 07:21:21 -0700
Subject: [PATCH 2/7] pinctrl: amlogic: gxbb: add EMMC and SD pins
In-Reply-To: <1462544486-9516-1-git-send-email-khilman@baylibre.com>
References: <1462544486-9516-1-git-send-email-khilman@baylibre.com>
Message-ID: <1462544486-9516-3-git-send-email-khilman@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add EE domain pins for eMMC and SD card.

Cc: Carlo Caione <carlo@endlessm.com>
Signed-off-by: Kevin Hilman <khilman@baylibre.com>
---
 drivers/pinctrl/meson/pinctrl-meson-gxbb.c | 41 ++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/pinctrl/meson/pinctrl-meson-gxbb.c b/drivers/pinctrl/meson/pinctrl-meson-gxbb.c
index 50551677b0ee..5dc98ee35265 100644
--- a/drivers/pinctrl/meson/pinctrl-meson-gxbb.c
+++ b/drivers/pinctrl/meson/pinctrl-meson-gxbb.c
@@ -147,6 +147,22 @@ static const struct pinctrl_pin_desc meson_gxbb_periphs_pins[] = {
 	MESON_PIN(GPIO_TEST_N, EE_OFF),
 };
 
+static const unsigned int emmc_nand_d07_pins[] = {
+	PIN(BOOT_0, EE_OFF), PIN(BOOT_1, EE_OFF), PIN(BOOT_2, EE_OFF),
+	PIN(BOOT_3, EE_OFF), PIN(BOOT_4, EE_OFF), PIN(BOOT_5, EE_OFF),
+	PIN(BOOT_6, EE_OFF), PIN(BOOT_7, EE_OFF),
+};
+static const unsigned int emmc_clk_pins[] = { PIN(BOOT_8, EE_OFF) };
+static const unsigned int emmc_cmd_pins[] = { PIN(BOOT_10, EE_OFF) };
+static const unsigned int emmc_ds_pins[] = { PIN(BOOT_15, EE_OFF) };
+
+static const unsigned int sdcard_d0_pins[] = { PIN(CARD_1, EE_OFF) };
+static const unsigned int sdcard_d1_pins[] = { PIN(CARD_0, EE_OFF) };
+static const unsigned int sdcard_d2_pins[] = { PIN(CARD_5, EE_OFF) };
+static const unsigned int sdcard_d3_pins[] = { PIN(CARD_4, EE_OFF) };
+static const unsigned int sdcard_cmd_pins[] = { PIN(CARD_3, EE_OFF) };
+static const unsigned int sdcard_clk_pins[] = { PIN(CARD_2, EE_OFF) };
+
 static const struct pinctrl_pin_desc meson_gxbb_aobus_pins[] = {
 	MESON_PIN(GPIOAO_0, 0),
 	MESON_PIN(GPIOAO_1, 0),
@@ -307,6 +323,20 @@ static struct meson_pmx_group meson_gxbb_periphs_groups[] = {
 	GPIO_GROUP(GPIOCLK_3, EE_OFF),
 
 	GPIO_GROUP(GPIO_TEST_N, EE_OFF),
+
+	/* Bank BOOT */
+	GROUP(emmc_nand_d07,	4,	30),
+	GROUP(emmc_clk,		4,	18),
+	GROUP(emmc_cmd,		4,	19),
+	GROUP(emmc_ds,		4,	31),
+
+	/* Bank CARD */
+	GROUP(sdcard_d1,	2,	14),
+	GROUP(sdcard_d0,	2,	15),
+	GROUP(sdcard_d3,	2,	12),
+	GROUP(sdcard_d2,	2,	13),
+	GROUP(sdcard_cmd,	2,	10),
+	GROUP(sdcard_clk,	2,	11),
 };
 
 static struct meson_pmx_group meson_gxbb_aobus_groups[] = {
@@ -377,6 +407,15 @@ static const char * const gpio_periphs_groups[] = {
 	"GPIO_TEST_N",
 };
 
+static const char * const emmc_groups[] = {
+	"emmc_nand_d07", "emmc_clk", "emmc_cmd", "emmc_ds",
+};
+
+static const char * const sdcard_groups[] = {
+	"sdcard_d0", "sdcard_d1", "sdcard_d2", "sdcard_d3",
+	"sdcard_cmd", "sdcard_clk",
+};
+
 static const char * const gpio_aobus_groups[] = {
 	"GPIOAO_0", "GPIOAO_1", "GPIOAO_2", "GPIOAO_3", "GPIOAO_4",
 	"GPIOAO_5", "GPIOAO_6", "GPIOAO_7", "GPIOAO_8", "GPIOAO_9",
@@ -401,6 +440,8 @@ static const char * const i2c_slave_ao_groups[] = {
 
 static struct meson_pmx_func meson_gxbb_periphs_functions[] = {
 	FUNCTION(gpio_periphs),
+	FUNCTION(emmc),
+	FUNCTION(sdcard),
 };
 
 static struct meson_pmx_func meson_gxbb_aobus_functions[] = {
-- 
2.7.4
