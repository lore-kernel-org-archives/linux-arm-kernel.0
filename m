From: jbrunet@baylibre.com (Jerome Brunet)
Date: Wed, 20 Sep 2017 15:39:22 +0200
Subject: [PATCH 3/8] pinctrl: meson: remove offset continued - gxl
In-Reply-To: <20170920133927.17390-1-jbrunet@baylibre.com>
References: <20170920133927.17390-1-jbrunet@baylibre.com>
Message-ID: <20170920133927.17390-4-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/pinctrl/meson/pinctrl-meson-gxl.c | 814 +++++++++++++++---------------
 1 file changed, 402 insertions(+), 412 deletions(-)

diff --git a/drivers/pinctrl/meson/pinctrl-meson-gxl.c b/drivers/pinctrl/meson/pinctrl-meson-gxl.c
index 36c14b85fc7c..32e35ba9c04e 100644
--- a/drivers/pinctrl/meson/pinctrl-meson-gxl.c
+++ b/drivers/pinctrl/meson/pinctrl-meson-gxl.c
@@ -15,407 +15,397 @@
 #include <dt-bindings/gpio/meson-gxl-gpio.h>
 #include "pinctrl-meson.h"
 
-#define EE_OFF	10
-
 static const struct pinctrl_pin_desc meson_gxl_periphs_pins[] = {
-	MESON_PIN(GPIOZ_0, EE_OFF),
-	MESON_PIN(GPIOZ_1, EE_OFF),
-	MESON_PIN(GPIOZ_2, EE_OFF),
-	MESON_PIN(GPIOZ_3, EE_OFF),
-	MESON_PIN(GPIOZ_4, EE_OFF),
-	MESON_PIN(GPIOZ_5, EE_OFF),
-	MESON_PIN(GPIOZ_6, EE_OFF),
-	MESON_PIN(GPIOZ_7, EE_OFF),
-	MESON_PIN(GPIOZ_8, EE_OFF),
-	MESON_PIN(GPIOZ_9, EE_OFF),
-	MESON_PIN(GPIOZ_10, EE_OFF),
-	MESON_PIN(GPIOZ_11, EE_OFF),
-	MESON_PIN(GPIOZ_12, EE_OFF),
-	MESON_PIN(GPIOZ_13, EE_OFF),
-	MESON_PIN(GPIOZ_14, EE_OFF),
-	MESON_PIN(GPIOZ_15, EE_OFF),
-
-	MESON_PIN(GPIOH_0, EE_OFF),
-	MESON_PIN(GPIOH_1, EE_OFF),
-	MESON_PIN(GPIOH_2, EE_OFF),
-	MESON_PIN(GPIOH_3, EE_OFF),
-	MESON_PIN(GPIOH_4, EE_OFF),
-	MESON_PIN(GPIOH_5, EE_OFF),
-	MESON_PIN(GPIOH_6, EE_OFF),
-	MESON_PIN(GPIOH_7, EE_OFF),
-	MESON_PIN(GPIOH_8, EE_OFF),
-	MESON_PIN(GPIOH_9, EE_OFF),
-
-	MESON_PIN(BOOT_0, EE_OFF),
-	MESON_PIN(BOOT_1, EE_OFF),
-	MESON_PIN(BOOT_2, EE_OFF),
-	MESON_PIN(BOOT_3, EE_OFF),
-	MESON_PIN(BOOT_4, EE_OFF),
-	MESON_PIN(BOOT_5, EE_OFF),
-	MESON_PIN(BOOT_6, EE_OFF),
-	MESON_PIN(BOOT_7, EE_OFF),
-	MESON_PIN(BOOT_8, EE_OFF),
-	MESON_PIN(BOOT_9, EE_OFF),
-	MESON_PIN(BOOT_10, EE_OFF),
-	MESON_PIN(BOOT_11, EE_OFF),
-	MESON_PIN(BOOT_12, EE_OFF),
-	MESON_PIN(BOOT_13, EE_OFF),
-	MESON_PIN(BOOT_14, EE_OFF),
-	MESON_PIN(BOOT_15, EE_OFF),
-
-	MESON_PIN(CARD_0, EE_OFF),
-	MESON_PIN(CARD_1, EE_OFF),
-	MESON_PIN(CARD_2, EE_OFF),
-	MESON_PIN(CARD_3, EE_OFF),
-	MESON_PIN(CARD_4, EE_OFF),
-	MESON_PIN(CARD_5, EE_OFF),
-	MESON_PIN(CARD_6, EE_OFF),
-
-	MESON_PIN(GPIODV_0, EE_OFF),
-	MESON_PIN(GPIODV_1, EE_OFF),
-	MESON_PIN(GPIODV_2, EE_OFF),
-	MESON_PIN(GPIODV_3, EE_OFF),
-	MESON_PIN(GPIODV_4, EE_OFF),
-	MESON_PIN(GPIODV_5, EE_OFF),
-	MESON_PIN(GPIODV_6, EE_OFF),
-	MESON_PIN(GPIODV_7, EE_OFF),
-	MESON_PIN(GPIODV_8, EE_OFF),
-	MESON_PIN(GPIODV_9, EE_OFF),
-	MESON_PIN(GPIODV_10, EE_OFF),
-	MESON_PIN(GPIODV_11, EE_OFF),
-	MESON_PIN(GPIODV_12, EE_OFF),
-	MESON_PIN(GPIODV_13, EE_OFF),
-	MESON_PIN(GPIODV_14, EE_OFF),
-	MESON_PIN(GPIODV_15, EE_OFF),
-	MESON_PIN(GPIODV_16, EE_OFF),
-	MESON_PIN(GPIODV_17, EE_OFF),
-	MESON_PIN(GPIODV_18, EE_OFF),
-	MESON_PIN(GPIODV_19, EE_OFF),
-	MESON_PIN(GPIODV_20, EE_OFF),
-	MESON_PIN(GPIODV_21, EE_OFF),
-	MESON_PIN(GPIODV_22, EE_OFF),
-	MESON_PIN(GPIODV_23, EE_OFF),
-	MESON_PIN(GPIODV_24, EE_OFF),
-	MESON_PIN(GPIODV_25, EE_OFF),
-	MESON_PIN(GPIODV_26, EE_OFF),
-	MESON_PIN(GPIODV_27, EE_OFF),
-	MESON_PIN(GPIODV_28, EE_OFF),
-	MESON_PIN(GPIODV_29, EE_OFF),
-
-	MESON_PIN(GPIOX_0, EE_OFF),
-	MESON_PIN(GPIOX_1, EE_OFF),
-	MESON_PIN(GPIOX_2, EE_OFF),
-	MESON_PIN(GPIOX_3, EE_OFF),
-	MESON_PIN(GPIOX_4, EE_OFF),
-	MESON_PIN(GPIOX_5, EE_OFF),
-	MESON_PIN(GPIOX_6, EE_OFF),
-	MESON_PIN(GPIOX_7, EE_OFF),
-	MESON_PIN(GPIOX_8, EE_OFF),
-	MESON_PIN(GPIOX_9, EE_OFF),
-	MESON_PIN(GPIOX_10, EE_OFF),
-	MESON_PIN(GPIOX_11, EE_OFF),
-	MESON_PIN(GPIOX_12, EE_OFF),
-	MESON_PIN(GPIOX_13, EE_OFF),
-	MESON_PIN(GPIOX_14, EE_OFF),
-	MESON_PIN(GPIOX_15, EE_OFF),
-	MESON_PIN(GPIOX_16, EE_OFF),
-	MESON_PIN(GPIOX_17, EE_OFF),
-	MESON_PIN(GPIOX_18, EE_OFF),
-
-	MESON_PIN(GPIOCLK_0, EE_OFF),
-	MESON_PIN(GPIOCLK_1, EE_OFF),
-
-	MESON_PIN(GPIO_TEST_N, EE_OFF),
+	MESON_PIN(GPIOZ_0),
+	MESON_PIN(GPIOZ_1),
+	MESON_PIN(GPIOZ_2),
+	MESON_PIN(GPIOZ_3),
+	MESON_PIN(GPIOZ_4),
+	MESON_PIN(GPIOZ_5),
+	MESON_PIN(GPIOZ_6),
+	MESON_PIN(GPIOZ_7),
+	MESON_PIN(GPIOZ_8),
+	MESON_PIN(GPIOZ_9),
+	MESON_PIN(GPIOZ_10),
+	MESON_PIN(GPIOZ_11),
+	MESON_PIN(GPIOZ_12),
+	MESON_PIN(GPIOZ_13),
+	MESON_PIN(GPIOZ_14),
+	MESON_PIN(GPIOZ_15),
+
+	MESON_PIN(GPIOH_0),
+	MESON_PIN(GPIOH_1),
+	MESON_PIN(GPIOH_2),
+	MESON_PIN(GPIOH_3),
+	MESON_PIN(GPIOH_4),
+	MESON_PIN(GPIOH_5),
+	MESON_PIN(GPIOH_6),
+	MESON_PIN(GPIOH_7),
+	MESON_PIN(GPIOH_8),
+	MESON_PIN(GPIOH_9),
+
+	MESON_PIN(BOOT_0),
+	MESON_PIN(BOOT_1),
+	MESON_PIN(BOOT_2),
+	MESON_PIN(BOOT_3),
+	MESON_PIN(BOOT_4),
+	MESON_PIN(BOOT_5),
+	MESON_PIN(BOOT_6),
+	MESON_PIN(BOOT_7),
+	MESON_PIN(BOOT_8),
+	MESON_PIN(BOOT_9),
+	MESON_PIN(BOOT_10),
+	MESON_PIN(BOOT_11),
+	MESON_PIN(BOOT_12),
+	MESON_PIN(BOOT_13),
+	MESON_PIN(BOOT_14),
+	MESON_PIN(BOOT_15),
+
+	MESON_PIN(CARD_0),
+	MESON_PIN(CARD_1),
+	MESON_PIN(CARD_2),
+	MESON_PIN(CARD_3),
+	MESON_PIN(CARD_4),
+	MESON_PIN(CARD_5),
+	MESON_PIN(CARD_6),
+
+	MESON_PIN(GPIODV_0),
+	MESON_PIN(GPIODV_1),
+	MESON_PIN(GPIODV_2),
+	MESON_PIN(GPIODV_3),
+	MESON_PIN(GPIODV_4),
+	MESON_PIN(GPIODV_5),
+	MESON_PIN(GPIODV_6),
+	MESON_PIN(GPIODV_7),
+	MESON_PIN(GPIODV_8),
+	MESON_PIN(GPIODV_9),
+	MESON_PIN(GPIODV_10),
+	MESON_PIN(GPIODV_11),
+	MESON_PIN(GPIODV_12),
+	MESON_PIN(GPIODV_13),
+	MESON_PIN(GPIODV_14),
+	MESON_PIN(GPIODV_15),
+	MESON_PIN(GPIODV_16),
+	MESON_PIN(GPIODV_17),
+	MESON_PIN(GPIODV_18),
+	MESON_PIN(GPIODV_19),
+	MESON_PIN(GPIODV_20),
+	MESON_PIN(GPIODV_21),
+	MESON_PIN(GPIODV_22),
+	MESON_PIN(GPIODV_23),
+	MESON_PIN(GPIODV_24),
+	MESON_PIN(GPIODV_25),
+	MESON_PIN(GPIODV_26),
+	MESON_PIN(GPIODV_27),
+	MESON_PIN(GPIODV_28),
+	MESON_PIN(GPIODV_29),
+
+	MESON_PIN(GPIOX_0),
+	MESON_PIN(GPIOX_1),
+	MESON_PIN(GPIOX_2),
+	MESON_PIN(GPIOX_3),
+	MESON_PIN(GPIOX_4),
+	MESON_PIN(GPIOX_5),
+	MESON_PIN(GPIOX_6),
+	MESON_PIN(GPIOX_7),
+	MESON_PIN(GPIOX_8),
+	MESON_PIN(GPIOX_9),
+	MESON_PIN(GPIOX_10),
+	MESON_PIN(GPIOX_11),
+	MESON_PIN(GPIOX_12),
+	MESON_PIN(GPIOX_13),
+	MESON_PIN(GPIOX_14),
+	MESON_PIN(GPIOX_15),
+	MESON_PIN(GPIOX_16),
+	MESON_PIN(GPIOX_17),
+	MESON_PIN(GPIOX_18),
+
+	MESON_PIN(GPIOCLK_0),
+	MESON_PIN(GPIOCLK_1),
+
+	MESON_PIN(GPIO_TEST_N),
 };
 
 static const unsigned int emmc_nand_d07_pins[] = {
-	PIN(BOOT_0, EE_OFF), PIN(BOOT_1, EE_OFF), PIN(BOOT_2, EE_OFF),
-	PIN(BOOT_3, EE_OFF), PIN(BOOT_4, EE_OFF), PIN(BOOT_5, EE_OFF),
-	PIN(BOOT_6, EE_OFF), PIN(BOOT_7, EE_OFF),
-};
-static const unsigned int emmc_clk_pins[] = { PIN(BOOT_8, EE_OFF) };
-static const unsigned int emmc_cmd_pins[] = { PIN(BOOT_10, EE_OFF) };
-static const unsigned int emmc_ds_pins[] = { PIN(BOOT_15, EE_OFF) };
-
-static const unsigned int nor_d_pins[]		= { PIN(BOOT_11, EE_OFF) };
-static const unsigned int nor_q_pins[]		= { PIN(BOOT_12, EE_OFF) };
-static const unsigned int nor_c_pins[]		= { PIN(BOOT_13, EE_OFF) };
-static const unsigned int nor_cs_pins[]		= { PIN(BOOT_15, EE_OFF) };
-
-static const unsigned int spi_mosi_pins[]	= { PIN(GPIOX_8, EE_OFF) };
-static const unsigned int spi_miso_pins[]	= { PIN(GPIOX_9, EE_OFF) };
-static const unsigned int spi_ss0_pins[]	= { PIN(GPIOX_10, EE_OFF) };
-static const unsigned int spi_sclk_pins[]	= { PIN(GPIOX_11, EE_OFF) };
-
-static const unsigned int sdcard_d0_pins[] = { PIN(CARD_1, EE_OFF) };
-static const unsigned int sdcard_d1_pins[] = { PIN(CARD_0, EE_OFF) };
-static const unsigned int sdcard_d2_pins[] = { PIN(CARD_5, EE_OFF) };
-static const unsigned int sdcard_d3_pins[] = { PIN(CARD_4, EE_OFF) };
-static const unsigned int sdcard_cmd_pins[] = { PIN(CARD_3, EE_OFF) };
-static const unsigned int sdcard_clk_pins[] = { PIN(CARD_2, EE_OFF) };
-
-static const unsigned int sdio_d0_pins[] = { PIN(GPIOX_0, EE_OFF) };
-static const unsigned int sdio_d1_pins[] = { PIN(GPIOX_1, EE_OFF) };
-static const unsigned int sdio_d2_pins[] = { PIN(GPIOX_2, EE_OFF) };
-static const unsigned int sdio_d3_pins[] = { PIN(GPIOX_3, EE_OFF) };
-static const unsigned int sdio_cmd_pins[] = { PIN(GPIOX_4, EE_OFF) };
-static const unsigned int sdio_clk_pins[] = { PIN(GPIOX_5, EE_OFF) };
-static const unsigned int sdio_irq_pins[] = { PIN(GPIOX_7, EE_OFF) };
-
-static const unsigned int nand_ce0_pins[]	= { PIN(BOOT_8, EE_OFF) };
-static const unsigned int nand_ce1_pins[]	= { PIN(BOOT_9, EE_OFF) };
-static const unsigned int nand_rb0_pins[]	= { PIN(BOOT_10, EE_OFF) };
-static const unsigned int nand_ale_pins[]	= { PIN(BOOT_11, EE_OFF) };
-static const unsigned int nand_cle_pins[]	= { PIN(BOOT_12, EE_OFF) };
-static const unsigned int nand_wen_clk_pins[]	= { PIN(BOOT_13, EE_OFF) };
-static const unsigned int nand_ren_wr_pins[]	= { PIN(BOOT_14, EE_OFF) };
-static const unsigned int nand_dqs_pins[]	= { PIN(BOOT_15, EE_OFF) };
-
-static const unsigned int uart_tx_a_pins[]	= { PIN(GPIOX_12, EE_OFF) };
-static const unsigned int uart_rx_a_pins[]	= { PIN(GPIOX_13, EE_OFF) };
-static const unsigned int uart_cts_a_pins[]	= { PIN(GPIOX_14, EE_OFF) };
-static const unsigned int uart_rts_a_pins[]	= { PIN(GPIOX_15, EE_OFF) };
-
-static const unsigned int uart_tx_b_pins[]	= { PIN(GPIODV_24, EE_OFF) };
-static const unsigned int uart_rx_b_pins[]	= { PIN(GPIODV_25, EE_OFF) };
-static const unsigned int uart_cts_b_pins[]	= { PIN(GPIODV_26, EE_OFF) };
-static const unsigned int uart_rts_b_pins[]	= { PIN(GPIODV_27, EE_OFF) };
-
-static const unsigned int uart_tx_c_pins[]	= { PIN(GPIOX_8, EE_OFF) };
-static const unsigned int uart_rx_c_pins[]	= { PIN(GPIOX_9, EE_OFF) };
-static const unsigned int uart_cts_c_pins[]	= { PIN(GPIOX_10, EE_OFF) };
-static const unsigned int uart_rts_c_pins[]	= { PIN(GPIOX_11, EE_OFF) };
-
-static const unsigned int i2c_sck_a_pins[]	= { PIN(GPIODV_25, EE_OFF) };
-static const unsigned int i2c_sda_a_pins[]	= { PIN(GPIODV_24, EE_OFF) };
-
-static const unsigned int i2c_sck_b_pins[]	= { PIN(GPIODV_27, EE_OFF) };
-static const unsigned int i2c_sda_b_pins[]	= { PIN(GPIODV_26, EE_OFF) };
-
-static const unsigned int i2c_sck_c_pins[]	= { PIN(GPIODV_29, EE_OFF) };
-static const unsigned int i2c_sda_c_pins[]	= { PIN(GPIODV_28, EE_OFF) };
-
-static const unsigned int i2c_sck_c_dv19_pins[]	= { PIN(GPIODV_19, EE_OFF) };
-static const unsigned int i2c_sda_c_dv18_pins[]	= { PIN(GPIODV_18, EE_OFF) };
-
-static const unsigned int eth_mdio_pins[]	= { PIN(GPIOZ_0, EE_OFF) };
-static const unsigned int eth_mdc_pins[]	= { PIN(GPIOZ_1, EE_OFF) };
-static const unsigned int eth_clk_rx_clk_pins[]	= { PIN(GPIOZ_2, EE_OFF) };
-static const unsigned int eth_rx_dv_pins[]	= { PIN(GPIOZ_3, EE_OFF) };
-static const unsigned int eth_rxd0_pins[]	= { PIN(GPIOZ_4, EE_OFF) };
-static const unsigned int eth_rxd1_pins[]	= { PIN(GPIOZ_5, EE_OFF) };
-static const unsigned int eth_rxd2_pins[]	= { PIN(GPIOZ_6, EE_OFF) };
-static const unsigned int eth_rxd3_pins[]	= { PIN(GPIOZ_7, EE_OFF) };
-static const unsigned int eth_rgmii_tx_clk_pins[] = { PIN(GPIOZ_8, EE_OFF) };
-static const unsigned int eth_tx_en_pins[]	= { PIN(GPIOZ_9, EE_OFF) };
-static const unsigned int eth_txd0_pins[]	= { PIN(GPIOZ_10, EE_OFF) };
-static const unsigned int eth_txd1_pins[]	= { PIN(GPIOZ_11, EE_OFF) };
-static const unsigned int eth_txd2_pins[]	= { PIN(GPIOZ_12, EE_OFF) };
-static const unsigned int eth_txd3_pins[]	= { PIN(GPIOZ_13, EE_OFF) };
-
-static const unsigned int pwm_a_pins[]		= { PIN(GPIOX_6, EE_OFF) };
-
-static const unsigned int pwm_b_pins[]		= { PIN(GPIODV_29, EE_OFF) };
-
-static const unsigned int pwm_c_pins[]		= { PIN(GPIOZ_15, EE_OFF) };
-
-static const unsigned int pwm_d_pins[]		= { PIN(GPIODV_28, EE_OFF) };
-
-static const unsigned int pwm_e_pins[]		= { PIN(GPIOX_16, EE_OFF) };
-
-static const unsigned int pwm_f_clk_pins[]	= { PIN(GPIOCLK_1, EE_OFF) };
-static const unsigned int pwm_f_x_pins[]	= { PIN(GPIOX_7, EE_OFF) };
-
-static const unsigned int hdmi_hpd_pins[]	= { PIN(GPIOH_0, EE_OFF) };
-static const unsigned int hdmi_sda_pins[]	= { PIN(GPIOH_1, EE_OFF) };
-static const unsigned int hdmi_scl_pins[]	= { PIN(GPIOH_2, EE_OFF) };
-
-static const unsigned int i2s_am_clk_pins[]	= { PIN(GPIOH_6, EE_OFF) };
-static const unsigned int i2s_out_ao_clk_pins[]	= { PIN(GPIOH_7, EE_OFF) };
-static const unsigned int i2s_out_lr_clk_pins[]	= { PIN(GPIOH_8, EE_OFF) };
-static const unsigned int i2s_out_ch01_pins[]	= { PIN(GPIOH_9, EE_OFF) };
-static const unsigned int i2s_out_ch23_z_pins[]	= { PIN(GPIOZ_5, EE_OFF) };
-static const unsigned int i2s_out_ch45_z_pins[]	= { PIN(GPIOZ_6, EE_OFF) };
-static const unsigned int i2s_out_ch67_z_pins[]	= { PIN(GPIOZ_7, EE_OFF) };
-
-static const unsigned int spdif_out_h_pins[]	= { PIN(GPIOH_4, EE_OFF) };
-
-static const unsigned int eth_link_led_pins[]	= { PIN(GPIOZ_14, EE_OFF) };
-static const unsigned int eth_act_led_pins[]	= { PIN(GPIOZ_15, EE_OFF) };
-
-static const unsigned int tsin_a_d0_pins[]	= { PIN(GPIODV_0, EE_OFF) };
-static const unsigned int tsin_a_d0_x_pins[]	= { PIN(GPIOX_10, EE_OFF) };
-static const unsigned int tsin_a_clk_pins[]	= { PIN(GPIODV_8, EE_OFF) };
-static const unsigned int tsin_a_clk_x_pins[]	= { PIN(GPIOX_11, EE_OFF) };
-static const unsigned int tsin_a_sop_pins[]	= { PIN(GPIODV_9, EE_OFF) };
-static const unsigned int tsin_a_sop_x_pins[]	= { PIN(GPIOX_8, EE_OFF) };
-static const unsigned int tsin_a_d_valid_pins[]	= { PIN(GPIODV_10, EE_OFF) };
-static const unsigned int tsin_a_d_valid_x_pins[] = { PIN(GPIOX_9, EE_OFF) };
-static const unsigned int tsin_a_fail_pins[]	= { PIN(GPIODV_11, EE_OFF) };
+	BOOT_0, BOOT_1, BOOT_2, BOOT_3, BOOT_4, BOOT_5, BOOT_6, BOOT_7,
+};
+static const unsigned int emmc_clk_pins[]	= { BOOT_8 };
+static const unsigned int emmc_cmd_pins[]	= { BOOT_10 };
+static const unsigned int emmc_ds_pins[]	= { BOOT_15 };
+
+static const unsigned int nor_d_pins[]		= { BOOT_11 };
+static const unsigned int nor_q_pins[]		= { BOOT_12 };
+static const unsigned int nor_c_pins[]		= { BOOT_13 };
+static const unsigned int nor_cs_pins[]		= { BOOT_15 };
+
+static const unsigned int spi_mosi_pins[]	= { GPIOX_8 };
+static const unsigned int spi_miso_pins[]	= { GPIOX_9 };
+static const unsigned int spi_ss0_pins[]	= { GPIOX_10 };
+static const unsigned int spi_sclk_pins[]	= { GPIOX_11 };
+
+static const unsigned int sdcard_d0_pins[]	= { CARD_1 };
+static const unsigned int sdcard_d1_pins[]	= { CARD_0 };
+static const unsigned int sdcard_d2_pins[]	= { CARD_5 };
+static const unsigned int sdcard_d3_pins[]	= { CARD_4 };
+static const unsigned int sdcard_cmd_pins[]	= { CARD_3 };
+static const unsigned int sdcard_clk_pins[]	= { CARD_2 };
+
+static const unsigned int sdio_d0_pins[]	= { GPIOX_0 };
+static const unsigned int sdio_d1_pins[]	= { GPIOX_1 };
+static const unsigned int sdio_d2_pins[]	= { GPIOX_2 };
+static const unsigned int sdio_d3_pins[]	= { GPIOX_3 };
+static const unsigned int sdio_cmd_pins[]	= { GPIOX_4 };
+static const unsigned int sdio_clk_pins[]	= { GPIOX_5 };
+static const unsigned int sdio_irq_pins[]	= { GPIOX_7 };
+
+static const unsigned int nand_ce0_pins[]	= { BOOT_8 };
+static const unsigned int nand_ce1_pins[]	= { BOOT_9 };
+static const unsigned int nand_rb0_pins[]	= { BOOT_10 };
+static const unsigned int nand_ale_pins[]	= { BOOT_11 };
+static const unsigned int nand_cle_pins[]	= { BOOT_12 };
+static const unsigned int nand_wen_clk_pins[]	= { BOOT_13 };
+static const unsigned int nand_ren_wr_pins[]	= { BOOT_14 };
+static const unsigned int nand_dqs_pins[]	= { BOOT_15 };
+
+static const unsigned int uart_tx_a_pins[]	= { GPIOX_12 };
+static const unsigned int uart_rx_a_pins[]	= { GPIOX_13 };
+static const unsigned int uart_cts_a_pins[]	= { GPIOX_14 };
+static const unsigned int uart_rts_a_pins[]	= { GPIOX_15 };
+
+static const unsigned int uart_tx_b_pins[]	= { GPIODV_24 };
+static const unsigned int uart_rx_b_pins[]	= { GPIODV_25 };
+static const unsigned int uart_cts_b_pins[]	= { GPIODV_26 };
+static const unsigned int uart_rts_b_pins[]	= { GPIODV_27 };
+
+static const unsigned int uart_tx_c_pins[]	= { GPIOX_8 };
+static const unsigned int uart_rx_c_pins[]	= { GPIOX_9 };
+static const unsigned int uart_cts_c_pins[]	= { GPIOX_10 };
+static const unsigned int uart_rts_c_pins[]	= { GPIOX_11 };
+
+static const unsigned int i2c_sck_a_pins[]	= { GPIODV_25 };
+static const unsigned int i2c_sda_a_pins[]	= { GPIODV_24 };
+
+static const unsigned int i2c_sck_b_pins[]	= { GPIODV_27 };
+static const unsigned int i2c_sda_b_pins[]	= { GPIODV_26 };
+
+static const unsigned int i2c_sck_c_pins[]	= { GPIODV_29 };
+static const unsigned int i2c_sda_c_pins[]	= { GPIODV_28 };
+
+static const unsigned int i2c_sck_c_dv19_pins[] = { GPIODV_19 };
+static const unsigned int i2c_sda_c_dv18_pins[] = { GPIODV_18 };
+
+static const unsigned int eth_mdio_pins[]	= { GPIOZ_0 };
+static const unsigned int eth_mdc_pins[]	= { GPIOZ_1 };
+static const unsigned int eth_clk_rx_clk_pins[] = { GPIOZ_2 };
+static const unsigned int eth_rx_dv_pins[]	= { GPIOZ_3 };
+static const unsigned int eth_rxd0_pins[]	= { GPIOZ_4 };
+static const unsigned int eth_rxd1_pins[]	= { GPIOZ_5 };
+static const unsigned int eth_rxd2_pins[]	= { GPIOZ_6 };
+static const unsigned int eth_rxd3_pins[]	= { GPIOZ_7 };
+static const unsigned int eth_rgmii_tx_clk_pins[] = { GPIOZ_8 };
+static const unsigned int eth_tx_en_pins[]	= { GPIOZ_9 };
+static const unsigned int eth_txd0_pins[]	= { GPIOZ_10 };
+static const unsigned int eth_txd1_pins[]	= { GPIOZ_11 };
+static const unsigned int eth_txd2_pins[]	= { GPIOZ_12 };
+static const unsigned int eth_txd3_pins[]	= { GPIOZ_13 };
+
+static const unsigned int pwm_a_pins[]		= { GPIOX_6 };
+
+static const unsigned int pwm_b_pins[]		= { GPIODV_29 };
+
+static const unsigned int pwm_c_pins[]		= { GPIOZ_15 };
+
+static const unsigned int pwm_d_pins[]		= { GPIODV_28 };
+
+static const unsigned int pwm_e_pins[]		= { GPIOX_16 };
+
+static const unsigned int pwm_f_clk_pins[]	= { GPIOCLK_1 };
+static const unsigned int pwm_f_x_pins[]	= { GPIOX_7 };
+
+static const unsigned int hdmi_hpd_pins[]	= { GPIOH_0 };
+static const unsigned int hdmi_sda_pins[]	= { GPIOH_1 };
+static const unsigned int hdmi_scl_pins[]	= { GPIOH_2 };
+
+static const unsigned int i2s_am_clk_pins[]	= { GPIOH_6 };
+static const unsigned int i2s_out_ao_clk_pins[] = { GPIOH_7 };
+static const unsigned int i2s_out_lr_clk_pins[] = { GPIOH_8 };
+static const unsigned int i2s_out_ch01_pins[]	= { GPIOH_9 };
+static const unsigned int i2s_out_ch23_z_pins[] = { GPIOZ_5 };
+static const unsigned int i2s_out_ch45_z_pins[] = { GPIOZ_6 };
+static const unsigned int i2s_out_ch67_z_pins[] = { GPIOZ_7 };
+
+static const unsigned int spdif_out_h_pins[]	= { GPIOH_4 };
+
+static const unsigned int eth_link_led_pins[]	= { GPIOZ_14 };
+static const unsigned int eth_act_led_pins[]	= { GPIOZ_15 };
+
+static const unsigned int tsin_a_d0_pins[]	= { GPIODV_0 };
+static const unsigned int tsin_a_d0_x_pins[]	= { GPIOX_10 };
+static const unsigned int tsin_a_clk_pins[]	= { GPIODV_8 };
+static const unsigned int tsin_a_clk_x_pins[]	= { GPIOX_11 };
+static const unsigned int tsin_a_sop_pins[]	= { GPIODV_9 };
+static const unsigned int tsin_a_sop_x_pins[]	= { GPIOX_8 };
+static const unsigned int tsin_a_d_valid_pins[] = { GPIODV_10 };
+static const unsigned int tsin_a_d_valid_x_pins[] = { GPIOX_9 };
+static const unsigned int tsin_a_fail_pins[]	= { GPIODV_11 };
 static const unsigned int tsin_a_dp_pins[] = {
-	PIN(GPIODV_1, EE_OFF),
-	PIN(GPIODV_2, EE_OFF),
-	PIN(GPIODV_3, EE_OFF),
-	PIN(GPIODV_4, EE_OFF),
-	PIN(GPIODV_5, EE_OFF),
-	PIN(GPIODV_6, EE_OFF),
-	PIN(GPIODV_7, EE_OFF),
+	GPIODV_1, GPIODV_2, GPIODV_3, GPIODV_4, GPIODV_5, GPIODV_6, GPIODV_7,
 };
 
 static const struct pinctrl_pin_desc meson_gxl_aobus_pins[] = {
-	MESON_PIN(GPIOAO_0, 0),
-	MESON_PIN(GPIOAO_1, 0),
-	MESON_PIN(GPIOAO_2, 0),
-	MESON_PIN(GPIOAO_3, 0),
-	MESON_PIN(GPIOAO_4, 0),
-	MESON_PIN(GPIOAO_5, 0),
-	MESON_PIN(GPIOAO_6, 0),
-	MESON_PIN(GPIOAO_7, 0),
-	MESON_PIN(GPIOAO_8, 0),
-	MESON_PIN(GPIOAO_9, 0),
-};
-
-static const unsigned int uart_tx_ao_a_pins[]	= { PIN(GPIOAO_0, 0) };
-static const unsigned int uart_rx_ao_a_pins[]	= { PIN(GPIOAO_1, 0) };
-static const unsigned int uart_tx_ao_b_0_pins[]	= { PIN(GPIOAO_0, 0) };
-static const unsigned int uart_rx_ao_b_1_pins[]	= { PIN(GPIOAO_1, 0) };
-static const unsigned int uart_cts_ao_a_pins[]	= { PIN(GPIOAO_2, 0) };
-static const unsigned int uart_rts_ao_a_pins[]	= { PIN(GPIOAO_3, 0) };
-static const unsigned int uart_tx_ao_b_pins[]	= { PIN(GPIOAO_4, 0) };
-static const unsigned int uart_rx_ao_b_pins[]	= { PIN(GPIOAO_5, 0) };
-static const unsigned int uart_cts_ao_b_pins[]	= { PIN(GPIOAO_2, 0) };
-static const unsigned int uart_rts_ao_b_pins[]	= { PIN(GPIOAO_3, 0) };
-
-static const unsigned int i2c_sck_ao_pins[] = {PIN(GPIOAO_4, 0) };
-static const unsigned int i2c_sda_ao_pins[] = {PIN(GPIOAO_5, 0) };
-static const unsigned int i2c_slave_sck_ao_pins[] = {PIN(GPIOAO_4, 0) };
-static const unsigned int i2c_slave_sda_ao_pins[] = {PIN(GPIOAO_5, 0) };
-
-static const unsigned int remote_input_ao_pins[] = {PIN(GPIOAO_7, 0) };
-
-static const unsigned int pwm_ao_a_3_pins[]	= { PIN(GPIOAO_3, 0) };
-static const unsigned int pwm_ao_a_8_pins[]	= { PIN(GPIOAO_8, 0) };
-
-static const unsigned int pwm_ao_b_pins[]	= { PIN(GPIOAO_9, 0) };
-static const unsigned int pwm_ao_b_6_pins[]	= { PIN(GPIOAO_6, 0) };
-
-static const unsigned int i2s_out_ch23_ao_pins[] = { PIN(GPIOAO_8, 0) };
-static const unsigned int i2s_out_ch45_ao_pins[] = { PIN(GPIOAO_9, 0) };
-
-static const unsigned int spdif_out_ao_6_pins[]	= { PIN(GPIOAO_6, 0) };
-static const unsigned int spdif_out_ao_9_pins[]	= { PIN(GPIOAO_9, 0) };
-
-static const unsigned int ao_cec_pins[]		= { PIN(GPIOAO_8, 0) };
-static const unsigned int ee_cec_pins[]		= { PIN(GPIOAO_8, 0) };
+	MESON_PIN(GPIOAO_0),
+	MESON_PIN(GPIOAO_1),
+	MESON_PIN(GPIOAO_2),
+	MESON_PIN(GPIOAO_3),
+	MESON_PIN(GPIOAO_4),
+	MESON_PIN(GPIOAO_5),
+	MESON_PIN(GPIOAO_6),
+	MESON_PIN(GPIOAO_7),
+	MESON_PIN(GPIOAO_8),
+	MESON_PIN(GPIOAO_9),
+};
+
+static const unsigned int uart_tx_ao_a_pins[]	= { GPIOAO_0 };
+static const unsigned int uart_rx_ao_a_pins[]	= { GPIOAO_1 };
+static const unsigned int uart_tx_ao_b_0_pins[] = { GPIOAO_0 };
+static const unsigned int uart_rx_ao_b_1_pins[] = { GPIOAO_1 };
+static const unsigned int uart_cts_ao_a_pins[]	= { GPIOAO_2 };
+static const unsigned int uart_rts_ao_a_pins[]	= { GPIOAO_3 };
+static const unsigned int uart_tx_ao_b_pins[]	= { GPIOAO_4 };
+static const unsigned int uart_rx_ao_b_pins[]	= { GPIOAO_5 };
+static const unsigned int uart_cts_ao_b_pins[]	= { GPIOAO_2 };
+static const unsigned int uart_rts_ao_b_pins[]	= { GPIOAO_3 };
+
+static const unsigned int i2c_sck_ao_pins[]	= {GPIOAO_4 };
+static const unsigned int i2c_sda_ao_pins[]	= {GPIOAO_5 };
+static const unsigned int i2c_slave_sck_ao_pins[] = {GPIOAO_4 };
+static const unsigned int i2c_slave_sda_ao_pins[] = {GPIOAO_5 };
+
+static const unsigned int remote_input_ao_pins[] = {GPIOAO_7 };
+
+static const unsigned int pwm_ao_a_3_pins[]	= { GPIOAO_3 };
+static const unsigned int pwm_ao_a_8_pins[]	= { GPIOAO_8 };
+
+static const unsigned int pwm_ao_b_pins[]	= { GPIOAO_9 };
+static const unsigned int pwm_ao_b_6_pins[]	= { GPIOAO_6 };
+
+static const unsigned int i2s_out_ch23_ao_pins[] = { GPIOAO_8 };
+static const unsigned int i2s_out_ch45_ao_pins[] = { GPIOAO_9 };
+
+static const unsigned int spdif_out_ao_6_pins[] = { GPIOAO_6 };
+static const unsigned int spdif_out_ao_9_pins[] = { GPIOAO_9 };
+
+static const unsigned int ao_cec_pins[]		= { GPIOAO_8 };
+static const unsigned int ee_cec_pins[]		= { GPIOAO_8 };
 
 static struct meson_pmx_group meson_gxl_periphs_groups[] = {
-	GPIO_GROUP(GPIOZ_0, EE_OFF),
-	GPIO_GROUP(GPIOZ_1, EE_OFF),
-	GPIO_GROUP(GPIOZ_2, EE_OFF),
-	GPIO_GROUP(GPIOZ_3, EE_OFF),
-	GPIO_GROUP(GPIOZ_4, EE_OFF),
-	GPIO_GROUP(GPIOZ_5, EE_OFF),
-	GPIO_GROUP(GPIOZ_6, EE_OFF),
-	GPIO_GROUP(GPIOZ_7, EE_OFF),
-	GPIO_GROUP(GPIOZ_8, EE_OFF),
-	GPIO_GROUP(GPIOZ_9, EE_OFF),
-	GPIO_GROUP(GPIOZ_10, EE_OFF),
-	GPIO_GROUP(GPIOZ_11, EE_OFF),
-	GPIO_GROUP(GPIOZ_12, EE_OFF),
-	GPIO_GROUP(GPIOZ_13, EE_OFF),
-	GPIO_GROUP(GPIOZ_14, EE_OFF),
-	GPIO_GROUP(GPIOZ_15, EE_OFF),
-
-	GPIO_GROUP(GPIOH_0, EE_OFF),
-	GPIO_GROUP(GPIOH_1, EE_OFF),
-	GPIO_GROUP(GPIOH_2, EE_OFF),
-	GPIO_GROUP(GPIOH_3, EE_OFF),
-	GPIO_GROUP(GPIOH_4, EE_OFF),
-	GPIO_GROUP(GPIOH_5, EE_OFF),
-	GPIO_GROUP(GPIOH_6, EE_OFF),
-	GPIO_GROUP(GPIOH_7, EE_OFF),
-	GPIO_GROUP(GPIOH_8, EE_OFF),
-	GPIO_GROUP(GPIOH_9, EE_OFF),
-
-	GPIO_GROUP(BOOT_0, EE_OFF),
-	GPIO_GROUP(BOOT_1, EE_OFF),
-	GPIO_GROUP(BOOT_2, EE_OFF),
-	GPIO_GROUP(BOOT_3, EE_OFF),
-	GPIO_GROUP(BOOT_4, EE_OFF),
-	GPIO_GROUP(BOOT_5, EE_OFF),
-	GPIO_GROUP(BOOT_6, EE_OFF),
-	GPIO_GROUP(BOOT_7, EE_OFF),
-	GPIO_GROUP(BOOT_8, EE_OFF),
-	GPIO_GROUP(BOOT_9, EE_OFF),
-	GPIO_GROUP(BOOT_10, EE_OFF),
-	GPIO_GROUP(BOOT_11, EE_OFF),
-	GPIO_GROUP(BOOT_12, EE_OFF),
-	GPIO_GROUP(BOOT_13, EE_OFF),
-	GPIO_GROUP(BOOT_14, EE_OFF),
-	GPIO_GROUP(BOOT_15, EE_OFF),
-
-	GPIO_GROUP(CARD_0, EE_OFF),
-	GPIO_GROUP(CARD_1, EE_OFF),
-	GPIO_GROUP(CARD_2, EE_OFF),
-	GPIO_GROUP(CARD_3, EE_OFF),
-	GPIO_GROUP(CARD_4, EE_OFF),
-	GPIO_GROUP(CARD_5, EE_OFF),
-	GPIO_GROUP(CARD_6, EE_OFF),
-
-	GPIO_GROUP(GPIODV_0, EE_OFF),
-	GPIO_GROUP(GPIODV_1, EE_OFF),
-	GPIO_GROUP(GPIODV_2, EE_OFF),
-	GPIO_GROUP(GPIODV_3, EE_OFF),
-	GPIO_GROUP(GPIODV_4, EE_OFF),
-	GPIO_GROUP(GPIODV_5, EE_OFF),
-	GPIO_GROUP(GPIODV_6, EE_OFF),
-	GPIO_GROUP(GPIODV_7, EE_OFF),
-	GPIO_GROUP(GPIODV_8, EE_OFF),
-	GPIO_GROUP(GPIODV_9, EE_OFF),
-	GPIO_GROUP(GPIODV_10, EE_OFF),
-	GPIO_GROUP(GPIODV_11, EE_OFF),
-	GPIO_GROUP(GPIODV_12, EE_OFF),
-	GPIO_GROUP(GPIODV_13, EE_OFF),
-	GPIO_GROUP(GPIODV_14, EE_OFF),
-	GPIO_GROUP(GPIODV_15, EE_OFF),
-	GPIO_GROUP(GPIODV_16, EE_OFF),
-	GPIO_GROUP(GPIODV_17, EE_OFF),
-	GPIO_GROUP(GPIODV_19, EE_OFF),
-	GPIO_GROUP(GPIODV_20, EE_OFF),
-	GPIO_GROUP(GPIODV_21, EE_OFF),
-	GPIO_GROUP(GPIODV_22, EE_OFF),
-	GPIO_GROUP(GPIODV_23, EE_OFF),
-	GPIO_GROUP(GPIODV_24, EE_OFF),
-	GPIO_GROUP(GPIODV_25, EE_OFF),
-	GPIO_GROUP(GPIODV_26, EE_OFF),
-	GPIO_GROUP(GPIODV_27, EE_OFF),
-	GPIO_GROUP(GPIODV_28, EE_OFF),
-	GPIO_GROUP(GPIODV_29, EE_OFF),
-
-	GPIO_GROUP(GPIOX_0, EE_OFF),
-	GPIO_GROUP(GPIOX_1, EE_OFF),
-	GPIO_GROUP(GPIOX_2, EE_OFF),
-	GPIO_GROUP(GPIOX_3, EE_OFF),
-	GPIO_GROUP(GPIOX_4, EE_OFF),
-	GPIO_GROUP(GPIOX_5, EE_OFF),
-	GPIO_GROUP(GPIOX_6, EE_OFF),
-	GPIO_GROUP(GPIOX_7, EE_OFF),
-	GPIO_GROUP(GPIOX_8, EE_OFF),
-	GPIO_GROUP(GPIOX_9, EE_OFF),
-	GPIO_GROUP(GPIOX_10, EE_OFF),
-	GPIO_GROUP(GPIOX_11, EE_OFF),
-	GPIO_GROUP(GPIOX_12, EE_OFF),
-	GPIO_GROUP(GPIOX_13, EE_OFF),
-	GPIO_GROUP(GPIOX_14, EE_OFF),
-	GPIO_GROUP(GPIOX_15, EE_OFF),
-	GPIO_GROUP(GPIOX_16, EE_OFF),
-	GPIO_GROUP(GPIOX_17, EE_OFF),
-	GPIO_GROUP(GPIOX_18, EE_OFF),
-
-	GPIO_GROUP(GPIOCLK_0, EE_OFF),
-	GPIO_GROUP(GPIOCLK_1, EE_OFF),
-
-	GPIO_GROUP(GPIO_TEST_N, EE_OFF),
+	GPIO_GROUP(GPIOZ_0),
+	GPIO_GROUP(GPIOZ_1),
+	GPIO_GROUP(GPIOZ_2),
+	GPIO_GROUP(GPIOZ_3),
+	GPIO_GROUP(GPIOZ_4),
+	GPIO_GROUP(GPIOZ_5),
+	GPIO_GROUP(GPIOZ_6),
+	GPIO_GROUP(GPIOZ_7),
+	GPIO_GROUP(GPIOZ_8),
+	GPIO_GROUP(GPIOZ_9),
+	GPIO_GROUP(GPIOZ_10),
+	GPIO_GROUP(GPIOZ_11),
+	GPIO_GROUP(GPIOZ_12),
+	GPIO_GROUP(GPIOZ_13),
+	GPIO_GROUP(GPIOZ_14),
+	GPIO_GROUP(GPIOZ_15),
+
+	GPIO_GROUP(GPIOH_0),
+	GPIO_GROUP(GPIOH_1),
+	GPIO_GROUP(GPIOH_2),
+	GPIO_GROUP(GPIOH_3),
+	GPIO_GROUP(GPIOH_4),
+	GPIO_GROUP(GPIOH_5),
+	GPIO_GROUP(GPIOH_6),
+	GPIO_GROUP(GPIOH_7),
+	GPIO_GROUP(GPIOH_8),
+	GPIO_GROUP(GPIOH_9),
+
+	GPIO_GROUP(BOOT_0),
+	GPIO_GROUP(BOOT_1),
+	GPIO_GROUP(BOOT_2),
+	GPIO_GROUP(BOOT_3),
+	GPIO_GROUP(BOOT_4),
+	GPIO_GROUP(BOOT_5),
+	GPIO_GROUP(BOOT_6),
+	GPIO_GROUP(BOOT_7),
+	GPIO_GROUP(BOOT_8),
+	GPIO_GROUP(BOOT_9),
+	GPIO_GROUP(BOOT_10),
+	GPIO_GROUP(BOOT_11),
+	GPIO_GROUP(BOOT_12),
+	GPIO_GROUP(BOOT_13),
+	GPIO_GROUP(BOOT_14),
+	GPIO_GROUP(BOOT_15),
+
+	GPIO_GROUP(CARD_0),
+	GPIO_GROUP(CARD_1),
+	GPIO_GROUP(CARD_2),
+	GPIO_GROUP(CARD_3),
+	GPIO_GROUP(CARD_4),
+	GPIO_GROUP(CARD_5),
+	GPIO_GROUP(CARD_6),
+
+	GPIO_GROUP(GPIODV_0),
+	GPIO_GROUP(GPIODV_1),
+	GPIO_GROUP(GPIODV_2),
+	GPIO_GROUP(GPIODV_3),
+	GPIO_GROUP(GPIODV_4),
+	GPIO_GROUP(GPIODV_5),
+	GPIO_GROUP(GPIODV_6),
+	GPIO_GROUP(GPIODV_7),
+	GPIO_GROUP(GPIODV_8),
+	GPIO_GROUP(GPIODV_9),
+	GPIO_GROUP(GPIODV_10),
+	GPIO_GROUP(GPIODV_11),
+	GPIO_GROUP(GPIODV_12),
+	GPIO_GROUP(GPIODV_13),
+	GPIO_GROUP(GPIODV_14),
+	GPIO_GROUP(GPIODV_15),
+	GPIO_GROUP(GPIODV_16),
+	GPIO_GROUP(GPIODV_17),
+	GPIO_GROUP(GPIODV_19),
+	GPIO_GROUP(GPIODV_20),
+	GPIO_GROUP(GPIODV_21),
+	GPIO_GROUP(GPIODV_22),
+	GPIO_GROUP(GPIODV_23),
+	GPIO_GROUP(GPIODV_24),
+	GPIO_GROUP(GPIODV_25),
+	GPIO_GROUP(GPIODV_26),
+	GPIO_GROUP(GPIODV_27),
+	GPIO_GROUP(GPIODV_28),
+	GPIO_GROUP(GPIODV_29),
+
+	GPIO_GROUP(GPIOX_0),
+	GPIO_GROUP(GPIOX_1),
+	GPIO_GROUP(GPIOX_2),
+	GPIO_GROUP(GPIOX_3),
+	GPIO_GROUP(GPIOX_4),
+	GPIO_GROUP(GPIOX_5),
+	GPIO_GROUP(GPIOX_6),
+	GPIO_GROUP(GPIOX_7),
+	GPIO_GROUP(GPIOX_8),
+	GPIO_GROUP(GPIOX_9),
+	GPIO_GROUP(GPIOX_10),
+	GPIO_GROUP(GPIOX_11),
+	GPIO_GROUP(GPIOX_12),
+	GPIO_GROUP(GPIOX_13),
+	GPIO_GROUP(GPIOX_14),
+	GPIO_GROUP(GPIOX_15),
+	GPIO_GROUP(GPIOX_16),
+	GPIO_GROUP(GPIOX_17),
+	GPIO_GROUP(GPIOX_18),
+
+	GPIO_GROUP(GPIOCLK_0),
+	GPIO_GROUP(GPIOCLK_1),
+
+	GPIO_GROUP(GPIO_TEST_N),
 
 	/* Bank X */
 	GROUP(sdio_d0,		5,	31),
@@ -530,16 +520,16 @@ static struct meson_pmx_group meson_gxl_periphs_groups[] = {
 };
 
 static struct meson_pmx_group meson_gxl_aobus_groups[] = {
-	GPIO_GROUP(GPIOAO_0, 0),
-	GPIO_GROUP(GPIOAO_1, 0),
-	GPIO_GROUP(GPIOAO_2, 0),
-	GPIO_GROUP(GPIOAO_3, 0),
-	GPIO_GROUP(GPIOAO_4, 0),
-	GPIO_GROUP(GPIOAO_5, 0),
-	GPIO_GROUP(GPIOAO_6, 0),
-	GPIO_GROUP(GPIOAO_7, 0),
-	GPIO_GROUP(GPIOAO_8, 0),
-	GPIO_GROUP(GPIOAO_9, 0),
+	GPIO_GROUP(GPIOAO_0),
+	GPIO_GROUP(GPIOAO_1),
+	GPIO_GROUP(GPIOAO_2),
+	GPIO_GROUP(GPIOAO_3),
+	GPIO_GROUP(GPIOAO_4),
+	GPIO_GROUP(GPIOAO_5),
+	GPIO_GROUP(GPIOAO_6),
+	GPIO_GROUP(GPIOAO_7),
+	GPIO_GROUP(GPIOAO_8),
+	GPIO_GROUP(GPIOAO_9),
 
 	/* bank AO */
 	GROUP(uart_tx_ao_b_0,	0,	26),
@@ -800,24 +790,24 @@ static struct meson_pmx_func meson_gxl_aobus_functions[] = {
 };
 
 static struct meson_bank meson_gxl_periphs_banks[] = {
-	/*   name    first                      last                    irq	  pullen  pull    dir     out     in  */
-	BANK("X",    PIN(GPIOX_0, EE_OFF),	PIN(GPIOX_18, EE_OFF),   89, 107, 4,  0,  4,  0,  12, 0,  13, 0,  14, 0),
-	BANK("DV",   PIN(GPIODV_0, EE_OFF),	PIN(GPIODV_29, EE_OFF),  83,  88, 0,  0,  0,  0,  0,  0,  1,  0,  2,  0),
-	BANK("H",    PIN(GPIOH_0, EE_OFF),	PIN(GPIOH_9, EE_OFF),    26,  35, 1, 20,  1, 20,  3, 20,  4, 20,  5, 20),
-	BANK("Z",    PIN(GPIOZ_0, EE_OFF),	PIN(GPIOZ_15, EE_OFF),   10,  25, 3,  0,  3,  0,  9,  0,  10, 0, 11,  0),
-	BANK("CARD", PIN(CARD_0, EE_OFF),	PIN(CARD_6, EE_OFF),     52,  58, 2, 20,  2, 20,  6, 20,  7, 20,  8, 20),
-	BANK("BOOT", PIN(BOOT_0, EE_OFF),	PIN(BOOT_15, EE_OFF),    36,  51, 2,  0,  2,  0,  6,  0,  7,  0,  8,  0),
-	BANK("CLK",  PIN(GPIOCLK_0, EE_OFF),	PIN(GPIOCLK_1, EE_OFF), 108, 109, 3, 28,  3, 28,  9, 28, 10, 28, 11, 28),
+	/*   name    first      last       irq	     pullen  pull    dir     out     in  */
+	BANK("X",    GPIOX_0,	GPIOX_18,   89, 107, 4,  0,  4,  0,  12, 0,  13, 0,  14, 0),
+	BANK("DV",   GPIODV_0,	GPIODV_29,  83,  88, 0,  0,  0,  0,  0,  0,  1,  0,  2,  0),
+	BANK("H",    GPIOH_0,	GPIOH_9,    26,  35, 1, 20,  1, 20,  3, 20,  4, 20,  5, 20),
+	BANK("Z",    GPIOZ_0,	GPIOZ_15,   10,  25, 3,  0,  3,  0,  9,  0,  10, 0, 11,  0),
+	BANK("CARD", CARD_0,	CARD_6,     52,  58, 2, 20,  2, 20,  6, 20,  7, 20,  8, 20),
+	BANK("BOOT", BOOT_0,	BOOT_15,    36,  51, 2,  0,  2,  0,  6,  0,  7,  0,  8,  0),
+	BANK("CLK",  GPIOCLK_0,	GPIOCLK_1, 108, 109, 3, 28,  3, 28,  9, 28, 10, 28, 11, 28),
 };
 
 static struct meson_bank meson_gxl_aobus_banks[] = {
-	/*   name    first              last              irq	pullen  pull    dir     out     in  */
-	BANK("AO",   PIN(GPIOAO_0, 0),  PIN(GPIOAO_9, 0), 0, 9, 0,  0,  0, 16,  0,  0,  0, 16,  1,  0),
+	/*   name    first      last      irq	pullen  pull    dir     out     in  */
+	BANK("AO",   GPIOAO_0,  GPIOAO_9, 0, 9, 0,  0,  0, 16,  0,  0,  0, 16,  1,  0),
 };
 
 struct meson_pinctrl_data meson_gxl_periphs_pinctrl_data = {
 	.name		= "periphs-banks",
-	.pin_base	= 10,
+	.pin_base	= 0,
 	.pins		= meson_gxl_periphs_pins,
 	.groups		= meson_gxl_periphs_groups,
 	.funcs		= meson_gxl_periphs_functions,
-- 
2.13.5
