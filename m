From: jbrunet@baylibre.com (Jerome Brunet)
Date: Fri,  9 Sep 2016 10:28:55 +0200
Subject: [PATCH v2 1/4] pinctrl: amlogic: gxbb: add spi nor pins
In-Reply-To: <1473409738-27175-1-git-send-email-jbrunet@baylibre.com>
References: <1473409738-27175-1-git-send-email-jbrunet@baylibre.com>
Message-ID: <1473409738-27175-2-git-send-email-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add EE domains pins for the SPI flash controller

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/pinctrl/meson/pinctrl-meson-gxbb.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/pinctrl/meson/pinctrl-meson-gxbb.c b/drivers/pinctrl/meson/pinctrl-meson-gxbb.c
index cb4d6ad30530..f74dbd5d350b 100644
--- a/drivers/pinctrl/meson/pinctrl-meson-gxbb.c
+++ b/drivers/pinctrl/meson/pinctrl-meson-gxbb.c
@@ -156,6 +156,11 @@ static const unsigned int emmc_clk_pins[] = { PIN(BOOT_8, EE_OFF) };
 static const unsigned int emmc_cmd_pins[] = { PIN(BOOT_10, EE_OFF) };
 static const unsigned int emmc_ds_pins[] = { PIN(BOOT_15, EE_OFF) };
 
+static const unsigned int nor_d_pins[]		= { PIN(BOOT_11, EE_OFF) };
+static const unsigned int nor_q_pins[]		= { PIN(BOOT_12, EE_OFF) };
+static const unsigned int nor_c_pins[]		= { PIN(BOOT_13, EE_OFF) };
+static const unsigned int nor_cs_pins[]		= { PIN(BOOT_15, EE_OFF) };
+
 static const unsigned int sdcard_d0_pins[] = { PIN(CARD_1, EE_OFF) };
 static const unsigned int sdcard_d1_pins[] = { PIN(CARD_0, EE_OFF) };
 static const unsigned int sdcard_d2_pins[] = { PIN(CARD_5, EE_OFF) };
@@ -393,6 +398,10 @@ static struct meson_pmx_group meson_gxbb_periphs_groups[] = {
 	GROUP(emmc_clk,		4,	18),
 	GROUP(emmc_cmd,		4,	19),
 	GROUP(emmc_ds,		4,	31),
+	GROUP(nor_d,		5,	1),
+	GROUP(nor_q,		5,	3),
+	GROUP(nor_c,		5,	2),
+	GROUP(nor_cs,		5,	0),
 
 	/* Bank CARD */
 	GROUP(sdcard_d1,	2,	14),
@@ -475,6 +484,10 @@ static const char * const emmc_groups[] = {
 	"emmc_nand_d07", "emmc_clk", "emmc_cmd", "emmc_ds",
 };
 
+static const char * const nor_groups[] = {
+	"nor_d", "nor_q", "nor_c", "nor_cs",
+};
+
 static const char * const sdcard_groups[] = {
 	"sdcard_d0", "sdcard_d1", "sdcard_d2", "sdcard_d3",
 	"sdcard_cmd", "sdcard_clk",
@@ -524,6 +537,7 @@ static const char * const i2c_slave_ao_groups[] = {
 static struct meson_pmx_func meson_gxbb_periphs_functions[] = {
 	FUNCTION(gpio_periphs),
 	FUNCTION(emmc),
+	FUNCTION(nor),
 	FUNCTION(sdcard),
 	FUNCTION(uart_a),
 	FUNCTION(uart_b),
-- 
2.7.4
