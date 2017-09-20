From: jbrunet@baylibre.com (Jerome Brunet)
Date: Wed, 20 Sep 2017 15:39:24 +0200
Subject: [PATCH 5/8] pinctrl: meson: remove offset continued - meson8b
In-Reply-To: <20170920133927.17390-1-jbrunet@baylibre.com>
References: <20170920133927.17390-1-jbrunet@baylibre.com>
Message-ID: <20170920133927.17390-6-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tested-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/pinctrl/meson/pinctrl-meson8b.c | 780 ++++++++++++++++----------------
 1 file changed, 388 insertions(+), 392 deletions(-)

diff --git a/drivers/pinctrl/meson/pinctrl-meson8b.c b/drivers/pinctrl/meson/pinctrl-meson8b.c
index 71f216b5b0b9..c3c247bfbc60 100644
--- a/drivers/pinctrl/meson/pinctrl-meson8b.c
+++ b/drivers/pinctrl/meson/pinctrl-meson8b.c
@@ -15,407 +15,403 @@
 #include <dt-bindings/gpio/meson8b-gpio.h>
 #include "pinctrl-meson.h"
 
-#define AO_OFF	130
-
 static const struct pinctrl_pin_desc meson8b_cbus_pins[] = {
-	MESON_PIN(GPIOX_0, 0),
-	MESON_PIN(GPIOX_1, 0),
-	MESON_PIN(GPIOX_2, 0),
-	MESON_PIN(GPIOX_3, 0),
-	MESON_PIN(GPIOX_4, 0),
-	MESON_PIN(GPIOX_5, 0),
-	MESON_PIN(GPIOX_6, 0),
-	MESON_PIN(GPIOX_7, 0),
-	MESON_PIN(GPIOX_8, 0),
-	MESON_PIN(GPIOX_9, 0),
-	MESON_PIN(GPIOX_10, 0),
-	MESON_PIN(GPIOX_11, 0),
-	MESON_PIN(GPIOX_16, 0),
-	MESON_PIN(GPIOX_17, 0),
-	MESON_PIN(GPIOX_18, 0),
-	MESON_PIN(GPIOX_19, 0),
-	MESON_PIN(GPIOX_20, 0),
-	MESON_PIN(GPIOX_21, 0),
-
-	MESON_PIN(GPIOY_0, 0),
-	MESON_PIN(GPIOY_1, 0),
-	MESON_PIN(GPIOY_3, 0),
-	MESON_PIN(GPIOY_6, 0),
-	MESON_PIN(GPIOY_7, 0),
-	MESON_PIN(GPIOY_8, 0),
-	MESON_PIN(GPIOY_9, 0),
-	MESON_PIN(GPIOY_10, 0),
-	MESON_PIN(GPIOY_11, 0),
-	MESON_PIN(GPIOY_12, 0),
-	MESON_PIN(GPIOY_13, 0),
-	MESON_PIN(GPIOY_14, 0),
-
-	MESON_PIN(GPIODV_9, 0),
-	MESON_PIN(GPIODV_24, 0),
-	MESON_PIN(GPIODV_25, 0),
-	MESON_PIN(GPIODV_26, 0),
-	MESON_PIN(GPIODV_27, 0),
-	MESON_PIN(GPIODV_28, 0),
-	MESON_PIN(GPIODV_29, 0),
-
-	MESON_PIN(GPIOH_0, 0),
-	MESON_PIN(GPIOH_1, 0),
-	MESON_PIN(GPIOH_2, 0),
-	MESON_PIN(GPIOH_3, 0),
-	MESON_PIN(GPIOH_4, 0),
-	MESON_PIN(GPIOH_5, 0),
-	MESON_PIN(GPIOH_6, 0),
-	MESON_PIN(GPIOH_7, 0),
-	MESON_PIN(GPIOH_8, 0),
-	MESON_PIN(GPIOH_9, 0),
-
-	MESON_PIN(CARD_0, 0),
-	MESON_PIN(CARD_1, 0),
-	MESON_PIN(CARD_2, 0),
-	MESON_PIN(CARD_3, 0),
-	MESON_PIN(CARD_4, 0),
-	MESON_PIN(CARD_5, 0),
-	MESON_PIN(CARD_6, 0),
-
-	MESON_PIN(BOOT_0, 0),
-	MESON_PIN(BOOT_1, 0),
-	MESON_PIN(BOOT_2, 0),
-	MESON_PIN(BOOT_3, 0),
-	MESON_PIN(BOOT_4, 0),
-	MESON_PIN(BOOT_5, 0),
-	MESON_PIN(BOOT_6, 0),
-	MESON_PIN(BOOT_7, 0),
-	MESON_PIN(BOOT_8, 0),
-	MESON_PIN(BOOT_9, 0),
-	MESON_PIN(BOOT_10, 0),
-	MESON_PIN(BOOT_11, 0),
-	MESON_PIN(BOOT_12, 0),
-	MESON_PIN(BOOT_13, 0),
-	MESON_PIN(BOOT_14, 0),
-	MESON_PIN(BOOT_15, 0),
-	MESON_PIN(BOOT_16, 0),
-	MESON_PIN(BOOT_17, 0),
-	MESON_PIN(BOOT_18, 0),
-
-	MESON_PIN(DIF_0_P, 0),
-	MESON_PIN(DIF_0_N, 0),
-	MESON_PIN(DIF_1_P, 0),
-	MESON_PIN(DIF_1_N, 0),
-	MESON_PIN(DIF_2_P, 0),
-	MESON_PIN(DIF_2_N, 0),
-	MESON_PIN(DIF_3_P, 0),
-	MESON_PIN(DIF_3_N, 0),
-	MESON_PIN(DIF_4_P, 0),
-	MESON_PIN(DIF_4_N, 0),
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
+	MESON_PIN(GPIOX_16),
+	MESON_PIN(GPIOX_17),
+	MESON_PIN(GPIOX_18),
+	MESON_PIN(GPIOX_19),
+	MESON_PIN(GPIOX_20),
+	MESON_PIN(GPIOX_21),
+
+	MESON_PIN(GPIOY_0),
+	MESON_PIN(GPIOY_1),
+	MESON_PIN(GPIOY_3),
+	MESON_PIN(GPIOY_6),
+	MESON_PIN(GPIOY_7),
+	MESON_PIN(GPIOY_8),
+	MESON_PIN(GPIOY_9),
+	MESON_PIN(GPIOY_10),
+	MESON_PIN(GPIOY_11),
+	MESON_PIN(GPIOY_12),
+	MESON_PIN(GPIOY_13),
+	MESON_PIN(GPIOY_14),
+
+	MESON_PIN(GPIODV_9),
+	MESON_PIN(GPIODV_24),
+	MESON_PIN(GPIODV_25),
+	MESON_PIN(GPIODV_26),
+	MESON_PIN(GPIODV_27),
+	MESON_PIN(GPIODV_28),
+	MESON_PIN(GPIODV_29),
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
+	MESON_PIN(CARD_0),
+	MESON_PIN(CARD_1),
+	MESON_PIN(CARD_2),
+	MESON_PIN(CARD_3),
+	MESON_PIN(CARD_4),
+	MESON_PIN(CARD_5),
+	MESON_PIN(CARD_6),
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
+	MESON_PIN(BOOT_16),
+	MESON_PIN(BOOT_17),
+	MESON_PIN(BOOT_18),
+
+	MESON_PIN(DIF_0_P),
+	MESON_PIN(DIF_0_N),
+	MESON_PIN(DIF_1_P),
+	MESON_PIN(DIF_1_N),
+	MESON_PIN(DIF_2_P),
+	MESON_PIN(DIF_2_N),
+	MESON_PIN(DIF_3_P),
+	MESON_PIN(DIF_3_N),
+	MESON_PIN(DIF_4_P),
+	MESON_PIN(DIF_4_N),
 };
 
 static const struct pinctrl_pin_desc meson8b_aobus_pins[] = {
-	MESON_PIN(GPIOAO_0, AO_OFF),
-	MESON_PIN(GPIOAO_1, AO_OFF),
-	MESON_PIN(GPIOAO_2, AO_OFF),
-	MESON_PIN(GPIOAO_3, AO_OFF),
-	MESON_PIN(GPIOAO_4, AO_OFF),
-	MESON_PIN(GPIOAO_5, AO_OFF),
-	MESON_PIN(GPIOAO_6, AO_OFF),
-	MESON_PIN(GPIOAO_7, AO_OFF),
-	MESON_PIN(GPIOAO_8, AO_OFF),
-	MESON_PIN(GPIOAO_9, AO_OFF),
-	MESON_PIN(GPIOAO_10, AO_OFF),
-	MESON_PIN(GPIOAO_11, AO_OFF),
-	MESON_PIN(GPIOAO_12, AO_OFF),
-	MESON_PIN(GPIOAO_13, AO_OFF),
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
+	MESON_PIN(GPIOAO_10),
+	MESON_PIN(GPIOAO_11),
+	MESON_PIN(GPIOAO_12),
+	MESON_PIN(GPIOAO_13),
 
 	/*
 	 * The following 2 pins are not mentionned in the public datasheet
 	 * According to this datasheet, they can't be used with the gpio
 	 * interrupt controller
 	 */
-	MESON_PIN(GPIO_BSD_EN, AO_OFF),
-	MESON_PIN(GPIO_TEST_N, AO_OFF),
+	MESON_PIN(GPIO_BSD_EN),
+	MESON_PIN(GPIO_TEST_N),
 };
 
 /* bank X */
-static const unsigned int sd_d0_a_pins[]	= { PIN(GPIOX_0, 0) };
-static const unsigned int sd_d1_a_pins[]	= { PIN(GPIOX_1, 0) };
-static const unsigned int sd_d2_a_pins[]	= { PIN(GPIOX_2, 0) };
-static const unsigned int sd_d3_a_pins[]	= { PIN(GPIOX_3, 0) };
-static const unsigned int sdxc_d0_0_a_pins[]	= { PIN(GPIOX_4, 0) };
-static const unsigned int sdxc_d47_a_pins[]	= { PIN(GPIOX_4, 0), PIN(GPIOX_5, 0),
-						    PIN(GPIOX_6, 0), PIN(GPIOX_7, 0) };
-static const unsigned int sdxc_d13_0_a_pins[]	= { PIN(GPIOX_5, 0), PIN(GPIOX_6, 0),
-						    PIN(GPIOX_7, 0) };
-static const unsigned int sd_clk_a_pins[]	= { PIN(GPIOX_8, 0) };
-static const unsigned int sd_cmd_a_pins[]	= { PIN(GPIOX_9, 0) };
-static const unsigned int xtal_32k_out_pins[]	= { PIN(GPIOX_10, 0) };
-static const unsigned int xtal_24m_out_pins[]	= { PIN(GPIOX_11, 0) };
-static const unsigned int uart_tx_b0_pins[]	= { PIN(GPIOX_16, 0) };
-static const unsigned int uart_rx_b0_pins[]	= { PIN(GPIOX_17, 0) };
-static const unsigned int uart_cts_b0_pins[]	= { PIN(GPIOX_18, 0) };
-static const unsigned int uart_rts_b0_pins[]	= { PIN(GPIOX_19, 0) };
-
-static const unsigned int sdxc_d0_1_a_pins[]	= { PIN(GPIOX_0, 0) };
-static const unsigned int sdxc_d13_1_a_pins[]	= { PIN(GPIOX_1, 0), PIN(GPIOX_2, 0),
-						    PIN(GPIOX_3, 0) };
-static const unsigned int pcm_out_a_pins[]	= { PIN(GPIOX_4, 0) };
-static const unsigned int pcm_in_a_pins[]	= { PIN(GPIOX_5, 0) };
-static const unsigned int pcm_fs_a_pins[]	= { PIN(GPIOX_6, 0) };
-static const unsigned int pcm_clk_a_pins[]	= { PIN(GPIOX_7, 0) };
-static const unsigned int sdxc_clk_a_pins[]	= { PIN(GPIOX_8, 0) };
-static const unsigned int sdxc_cmd_a_pins[]	= { PIN(GPIOX_9, 0) };
-static const unsigned int pwm_vs_0_pins[]	= { PIN(GPIOX_10, 0) };
-static const unsigned int pwm_e_pins[]		= { PIN(GPIOX_10, 0) };
-static const unsigned int pwm_vs_1_pins[]	= { PIN(GPIOX_11, 0) };
-
-static const unsigned int uart_tx_a_pins[]	= { PIN(GPIOX_4, 0) };
-static const unsigned int uart_rx_a_pins[]	= { PIN(GPIOX_5, 0) };
-static const unsigned int uart_cts_a_pins[]	= { PIN(GPIOX_6, 0) };
-static const unsigned int uart_rts_a_pins[]	= { PIN(GPIOX_7, 0) };
-static const unsigned int uart_tx_b1_pins[]	= { PIN(GPIOX_8, 0) };
-static const unsigned int uart_rx_b1_pins[]	= { PIN(GPIOX_9, 0) };
-static const unsigned int uart_cts_b1_pins[]	= { PIN(GPIOX_10, 0) };
-static const unsigned int uart_rts_b1_pins[]	= { PIN(GPIOX_20, 0) };
-
-static const unsigned int iso7816_0_clk_pins[]	= { PIN(GPIOX_6, 0) };
-static const unsigned int iso7816_0_data_pins[]	= { PIN(GPIOX_7, 0) };
-static const unsigned int spi_sclk_0_pins[]	= { PIN(GPIOX_8, 0) };
-static const unsigned int spi_miso_0_pins[]	= { PIN(GPIOX_9, 0) };
-static const unsigned int spi_mosi_0_pins[]	= { PIN(GPIOX_10, 0) };
-static const unsigned int iso7816_det_pins[]	= { PIN(GPIOX_16, 0) };
-static const unsigned int iso7816_reset_pins[]	= { PIN(GPIOX_17, 0) };
-static const unsigned int iso7816_1_clk_pins[]	= { PIN(GPIOX_18, 0) };
-static const unsigned int iso7816_1_data_pins[]	= { PIN(GPIOX_19, 0) };
-static const unsigned int spi_ss0_0_pins[]	= { PIN(GPIOX_20, 0) };
-
-static const unsigned int tsin_clk_b_pins[]	= { PIN(GPIOX_8, 0) };
-static const unsigned int tsin_sop_b_pins[]	= { PIN(GPIOX_9, 0) };
-static const unsigned int tsin_d0_b_pins[]	= { PIN(GPIOX_10, 0) };
-static const unsigned int pwm_b_pins[]		= { PIN(GPIOX_11, 0) };
-static const unsigned int i2c_sda_d0_pins[]	= { PIN(GPIOX_16, 0) };
-static const unsigned int i2c_sck_d0_pins[]	= { PIN(GPIOX_17, 0) };
-static const unsigned int tsin_d_valid_b_pins[] = { PIN(GPIOX_20, 0) };
+static const unsigned int sd_d0_a_pins[]	= { GPIOX_0 };
+static const unsigned int sd_d1_a_pins[]	= { GPIOX_1 };
+static const unsigned int sd_d2_a_pins[]	= { GPIOX_2 };
+static const unsigned int sd_d3_a_pins[]	= { GPIOX_3 };
+static const unsigned int sdxc_d0_0_a_pins[]	= { GPIOX_4 };
+static const unsigned int sdxc_d47_a_pins[]	= { GPIOX_4, GPIOX_5,
+						    GPIOX_6, GPIOX_7 };
+static const unsigned int sdxc_d13_0_a_pins[]	= { GPIOX_5, GPIOX_6,
+						    GPIOX_7 };
+static const unsigned int sd_clk_a_pins[]	= { GPIOX_8 };
+static const unsigned int sd_cmd_a_pins[]	= { GPIOX_9 };
+static const unsigned int xtal_32k_out_pins[]	= { GPIOX_10 };
+static const unsigned int xtal_24m_out_pins[]	= { GPIOX_11 };
+static const unsigned int uart_tx_b0_pins[]	= { GPIOX_16 };
+static const unsigned int uart_rx_b0_pins[]	= { GPIOX_17 };
+static const unsigned int uart_cts_b0_pins[]	= { GPIOX_18 };
+static const unsigned int uart_rts_b0_pins[]	= { GPIOX_19 };
+
+static const unsigned int sdxc_d0_1_a_pins[]	= { GPIOX_0 };
+static const unsigned int sdxc_d13_1_a_pins[]	= { GPIOX_1, GPIOX_2,
+						    GPIOX_3 };
+static const unsigned int pcm_out_a_pins[]	= { GPIOX_4 };
+static const unsigned int pcm_in_a_pins[]	= { GPIOX_5 };
+static const unsigned int pcm_fs_a_pins[]	= { GPIOX_6 };
+static const unsigned int pcm_clk_a_pins[]	= { GPIOX_7 };
+static const unsigned int sdxc_clk_a_pins[]	= { GPIOX_8 };
+static const unsigned int sdxc_cmd_a_pins[]	= { GPIOX_9 };
+static const unsigned int pwm_vs_0_pins[]	= { GPIOX_10 };
+static const unsigned int pwm_e_pins[]		= { GPIOX_10 };
+static const unsigned int pwm_vs_1_pins[]	= { GPIOX_11 };
+
+static const unsigned int uart_tx_a_pins[]	= { GPIOX_4 };
+static const unsigned int uart_rx_a_pins[]	= { GPIOX_5 };
+static const unsigned int uart_cts_a_pins[]	= { GPIOX_6 };
+static const unsigned int uart_rts_a_pins[]	= { GPIOX_7 };
+static const unsigned int uart_tx_b1_pins[]	= { GPIOX_8 };
+static const unsigned int uart_rx_b1_pins[]	= { GPIOX_9 };
+static const unsigned int uart_cts_b1_pins[]	= { GPIOX_10 };
+static const unsigned int uart_rts_b1_pins[]	= { GPIOX_20 };
+
+static const unsigned int iso7816_0_clk_pins[]	= { GPIOX_6 };
+static const unsigned int iso7816_0_data_pins[]	= { GPIOX_7 };
+static const unsigned int spi_sclk_0_pins[]	= { GPIOX_8 };
+static const unsigned int spi_miso_0_pins[]	= { GPIOX_9 };
+static const unsigned int spi_mosi_0_pins[]	= { GPIOX_10 };
+static const unsigned int iso7816_det_pins[]	= { GPIOX_16 };
+static const unsigned int iso7816_reset_pins[]	= { GPIOX_17 };
+static const unsigned int iso7816_1_clk_pins[]	= { GPIOX_18 };
+static const unsigned int iso7816_1_data_pins[]	= { GPIOX_19 };
+static const unsigned int spi_ss0_0_pins[]	= { GPIOX_20 };
+
+static const unsigned int tsin_clk_b_pins[]	= { GPIOX_8 };
+static const unsigned int tsin_sop_b_pins[]	= { GPIOX_9 };
+static const unsigned int tsin_d0_b_pins[]	= { GPIOX_10 };
+static const unsigned int pwm_b_pins[]		= { GPIOX_11 };
+static const unsigned int i2c_sda_d0_pins[]	= { GPIOX_16 };
+static const unsigned int i2c_sck_d0_pins[]	= { GPIOX_17 };
+static const unsigned int tsin_d_valid_b_pins[] = { GPIOX_20 };
 
 /* bank Y */
-static const unsigned int tsin_d_valid_a_pins[] = { PIN(GPIOY_0, 0) };
-static const unsigned int tsin_sop_a_pins[]	= { PIN(GPIOY_1, 0) };
-static const unsigned int tsin_d17_a_pins[]	= { PIN(GPIOY_6, 0), PIN(GPIOY_7, 0),
-						    PIN(GPIOY_10, 0), PIN(GPIOY_11, 0),
-						    PIN(GPIOY_12, 0), PIN(GPIOY_13, 0),
-						    PIN(GPIOY_14, 0) };
-static const unsigned int tsin_clk_a_pins[]	= { PIN(GPIOY_8, 0) };
-static const unsigned int tsin_d0_a_pins[]	= { PIN(GPIOY_9, 0) };
+static const unsigned int tsin_d_valid_a_pins[] = { GPIOY_0 };
+static const unsigned int tsin_sop_a_pins[]	= { GPIOY_1 };
+static const unsigned int tsin_d17_a_pins[] = {
+	GPIOY_6, GPIOY_7, GPIOY_10, GPIOY_11, GPIOY_12, GPIOY_13, GPIOY_14,
+};
+static const unsigned int tsin_clk_a_pins[]	= { GPIOY_8 };
+static const unsigned int tsin_d0_a_pins[]	= { GPIOY_9 };
 
-static const unsigned int spdif_out_0_pins[]	= { PIN(GPIOY_3, 0) };
+static const unsigned int spdif_out_0_pins[]	= { GPIOY_3 };
 
-static const unsigned int xtal_24m_pins[]	= { PIN(GPIOY_3, 0) };
-static const unsigned int iso7816_2_clk_pins[]	= { PIN(GPIOY_13, 0) };
-static const unsigned int iso7816_2_data_pins[] = { PIN(GPIOY_14, 0) };
+static const unsigned int xtal_24m_pins[]	= { GPIOY_3 };
+static const unsigned int iso7816_2_clk_pins[]	= { GPIOY_13 };
+static const unsigned int iso7816_2_data_pins[] = { GPIOY_14 };
 
 /* bank DV */
-static const unsigned int pwm_d_pins[]		= { PIN(GPIODV_28, 0) };
-static const unsigned int pwm_c0_pins[]		= { PIN(GPIODV_29, 0) };
+static const unsigned int pwm_d_pins[]		= { GPIODV_28 };
+static const unsigned int pwm_c0_pins[]		= { GPIODV_29 };
 
-static const unsigned int pwm_vs_2_pins[]	= { PIN(GPIODV_9, 0) };
-static const unsigned int pwm_vs_3_pins[]	= { PIN(GPIODV_28, 0) };
-static const unsigned int pwm_vs_4_pins[]	= { PIN(GPIODV_29, 0) };
+static const unsigned int pwm_vs_2_pins[]	= { GPIODV_9 };
+static const unsigned int pwm_vs_3_pins[]	= { GPIODV_28 };
+static const unsigned int pwm_vs_4_pins[]	= { GPIODV_29 };
 
-static const unsigned int xtal24_out_pins[]	= { PIN(GPIODV_29, 0) };
+static const unsigned int xtal24_out_pins[]	= { GPIODV_29 };
 
-static const unsigned int uart_tx_c_pins[]	= { PIN(GPIODV_24, 0) };
-static const unsigned int uart_rx_c_pins[]	= { PIN(GPIODV_25, 0) };
-static const unsigned int uart_cts_c_pins[]	= { PIN(GPIODV_26, 0) };
-static const unsigned int uart_rts_c_pins[]	= { PIN(GPIODV_27, 0) };
+static const unsigned int uart_tx_c_pins[]	= { GPIODV_24 };
+static const unsigned int uart_rx_c_pins[]	= { GPIODV_25 };
+static const unsigned int uart_cts_c_pins[]	= { GPIODV_26 };
+static const unsigned int uart_rts_c_pins[]	= { GPIODV_27 };
 
-static const unsigned int pwm_c1_pins[]		= { PIN(GPIODV_9, 0) };
+static const unsigned int pwm_c1_pins[]		= { GPIODV_9 };
 
-static const unsigned int i2c_sda_a_pins[]	= { PIN(GPIODV_24, 0) };
-static const unsigned int i2c_sck_a_pins[]	= { PIN(GPIODV_25, 0) };
-static const unsigned int i2c_sda_b0_pins[]	= { PIN(GPIODV_26, 0) };
-static const unsigned int i2c_sck_b0_pins[]	= { PIN(GPIODV_27, 0) };
-static const unsigned int i2c_sda_c0_pins[]	= { PIN(GPIODV_28, 0) };
-static const unsigned int i2c_sck_c0_pins[]	= { PIN(GPIODV_29, 0) };
+static const unsigned int i2c_sda_a_pins[]	= { GPIODV_24 };
+static const unsigned int i2c_sck_a_pins[]	= { GPIODV_25 };
+static const unsigned int i2c_sda_b0_pins[]	= { GPIODV_26 };
+static const unsigned int i2c_sck_b0_pins[]	= { GPIODV_27 };
+static const unsigned int i2c_sda_c0_pins[]	= { GPIODV_28 };
+static const unsigned int i2c_sck_c0_pins[]	= { GPIODV_29 };
 
 /* bank H */
-static const unsigned int hdmi_hpd_pins[]	= { PIN(GPIOH_0, 0) };
-static const unsigned int hdmi_sda_pins[]	= { PIN(GPIOH_1, 0) };
-static const unsigned int hdmi_scl_pins[]	= { PIN(GPIOH_2, 0) };
-static const unsigned int hdmi_cec_0_pins[]	= { PIN(GPIOH_3, 0) };
-static const unsigned int eth_txd1_0_pins[]	= { PIN(GPIOH_5, 0) };
-static const unsigned int eth_txd0_0_pins[]	= { PIN(GPIOH_6, 0) };
-static const unsigned int clk_24m_out_pins[]	= { PIN(GPIOH_9, 0) };
-
-static const unsigned int spi_ss1_pins[]	= { PIN(GPIOH_0, 0) };
-static const unsigned int spi_ss2_pins[]	= { PIN(GPIOH_1, 0) };
-static const unsigned int spi_ss0_1_pins[]	= { PIN(GPIOH_3, 0) };
-static const unsigned int spi_miso_1_pins[]	= { PIN(GPIOH_4, 0) };
-static const unsigned int spi_mosi_1_pins[]	= { PIN(GPIOH_5, 0) };
-static const unsigned int spi_sclk_1_pins[]	= { PIN(GPIOH_6, 0) };
-
-static const unsigned int eth_txd3_pins[]	= { PIN(GPIOH_7, 0) };
-static const unsigned int eth_txd2_pins[]	= { PIN(GPIOH_8, 0) };
-static const unsigned int eth_tx_clk_pins[]	= { PIN(GPIOH_9, 0) };
-
-static const unsigned int i2c_sda_b1_pins[]	= { PIN(GPIOH_3, 0) };
-static const unsigned int i2c_sck_b1_pins[]	= { PIN(GPIOH_4, 0) };
-static const unsigned int i2c_sda_c1_pins[]	= { PIN(GPIOH_5, 0) };
-static const unsigned int i2c_sck_c1_pins[]	= { PIN(GPIOH_6, 0) };
-static const unsigned int i2c_sda_d1_pins[]	= { PIN(GPIOH_7, 0) };
-static const unsigned int i2c_sck_d1_pins[]	= { PIN(GPIOH_8, 0) };
+static const unsigned int hdmi_hpd_pins[]	= { GPIOH_0 };
+static const unsigned int hdmi_sda_pins[]	= { GPIOH_1 };
+static const unsigned int hdmi_scl_pins[]	= { GPIOH_2 };
+static const unsigned int hdmi_cec_0_pins[]	= { GPIOH_3 };
+static const unsigned int eth_txd1_0_pins[]	= { GPIOH_5 };
+static const unsigned int eth_txd0_0_pins[]	= { GPIOH_6 };
+static const unsigned int clk_24m_out_pins[]	= { GPIOH_9 };
+
+static const unsigned int spi_ss1_pins[]	= { GPIOH_0 };
+static const unsigned int spi_ss2_pins[]	= { GPIOH_1 };
+static const unsigned int spi_ss0_1_pins[]	= { GPIOH_3 };
+static const unsigned int spi_miso_1_pins[]	= { GPIOH_4 };
+static const unsigned int spi_mosi_1_pins[]	= { GPIOH_5 };
+static const unsigned int spi_sclk_1_pins[]	= { GPIOH_6 };
+
+static const unsigned int eth_txd3_pins[]	= { GPIOH_7 };
+static const unsigned int eth_txd2_pins[]	= { GPIOH_8 };
+static const unsigned int eth_tx_clk_pins[]	= { GPIOH_9 };
+
+static const unsigned int i2c_sda_b1_pins[]	= { GPIOH_3 };
+static const unsigned int i2c_sck_b1_pins[]	= { GPIOH_4 };
+static const unsigned int i2c_sda_c1_pins[]	= { GPIOH_5 };
+static const unsigned int i2c_sck_c1_pins[]	= { GPIOH_6 };
+static const unsigned int i2c_sda_d1_pins[]	= { GPIOH_7 };
+static const unsigned int i2c_sck_d1_pins[]	= { GPIOH_8 };
 
 /* bank BOOT */
-static const unsigned int nand_io_pins[]	= { PIN(BOOT_0, 0), PIN(BOOT_1, 0),
-						    PIN(BOOT_2, 0), PIN(BOOT_3, 0),
-						    PIN(BOOT_4, 0), PIN(BOOT_5, 0),
-						    PIN(BOOT_6, 0), PIN(BOOT_7, 0) };
-static const unsigned int nand_io_ce0_pins[]	= { PIN(BOOT_8, 0) };
-static const unsigned int nand_io_ce1_pins[]	= { PIN(BOOT_9, 0) };
-static const unsigned int nand_io_rb0_pins[]	= { PIN(BOOT_10, 0) };
-static const unsigned int nand_ale_pins[]	= { PIN(BOOT_11, 0) };
-static const unsigned int nand_cle_pins[]	= { PIN(BOOT_12, 0) };
-static const unsigned int nand_wen_clk_pins[]	= { PIN(BOOT_13, 0) };
-static const unsigned int nand_ren_clk_pins[]	= { PIN(BOOT_14, 0) };
-static const unsigned int nand_dqs_15_pins[]	= { PIN(BOOT_15, 0) };
-static const unsigned int nand_dqs_18_pins[]	= { PIN(BOOT_18, 0) };
-
-static const unsigned int sdxc_d0_c_pins[]	= { PIN(BOOT_0, 0)};
-static const unsigned int sdxc_d13_c_pins[]	= { PIN(BOOT_1, 0), PIN(BOOT_2, 0),
-						    PIN(BOOT_3, 0) };
-static const unsigned int sdxc_d47_c_pins[]	= { PIN(BOOT_4, 0), PIN(BOOT_5, 0),
-						    PIN(BOOT_6, 0), PIN(BOOT_7, 0) };
-static const unsigned int sdxc_clk_c_pins[]	= { PIN(BOOT_8, 0) };
-static const unsigned int sdxc_cmd_c_pins[]	= { PIN(BOOT_10, 0) };
-static const unsigned int nor_d_pins[]		= { PIN(BOOT_11, 0) };
-static const unsigned int nor_q_pins[]		= { PIN(BOOT_12, 0) };
-static const unsigned int nor_c_pins[]		= { PIN(BOOT_13, 0) };
-static const unsigned int nor_cs_pins[]		= { PIN(BOOT_18, 0) };
-
-static const unsigned int sd_d0_c_pins[]	= { PIN(BOOT_0, 0) };
-static const unsigned int sd_d1_c_pins[]	= { PIN(BOOT_1, 0) };
-static const unsigned int sd_d2_c_pins[]	= { PIN(BOOT_2, 0) };
-static const unsigned int sd_d3_c_pins[]	= { PIN(BOOT_3, 0) };
-static const unsigned int sd_cmd_c_pins[]	= { PIN(BOOT_8, 0) };
-static const unsigned int sd_clk_c_pins[]	= { PIN(BOOT_10, 0) };
+static const unsigned int nand_io_pins[] = {
+	BOOT_0, BOOT_1, BOOT_2, BOOT_3, BOOT_4, BOOT_5, BOOT_6, BOOT_7
+};
+static const unsigned int nand_io_ce0_pins[]	= { BOOT_8 };
+static const unsigned int nand_io_ce1_pins[]	= { BOOT_9 };
+static const unsigned int nand_io_rb0_pins[]	= { BOOT_10 };
+static const unsigned int nand_ale_pins[]	= { BOOT_11 };
+static const unsigned int nand_cle_pins[]	= { BOOT_12 };
+static const unsigned int nand_wen_clk_pins[]	= { BOOT_13 };
+static const unsigned int nand_ren_clk_pins[]	= { BOOT_14 };
+static const unsigned int nand_dqs_15_pins[]	= { BOOT_15 };
+static const unsigned int nand_dqs_18_pins[]	= { BOOT_18 };
+
+static const unsigned int sdxc_d0_c_pins[]	= { BOOT_0};
+static const unsigned int sdxc_d13_c_pins[]	= { BOOT_1, BOOT_2,
+						    BOOT_3 };
+static const unsigned int sdxc_d47_c_pins[]	= { BOOT_4, BOOT_5,
+						    BOOT_6, BOOT_7 };
+static const unsigned int sdxc_clk_c_pins[]	= { BOOT_8 };
+static const unsigned int sdxc_cmd_c_pins[]	= { BOOT_10 };
+static const unsigned int nor_d_pins[]		= { BOOT_11 };
+static const unsigned int nor_q_pins[]		= { BOOT_12 };
+static const unsigned int nor_c_pins[]		= { BOOT_13 };
+static const unsigned int nor_cs_pins[]		= { BOOT_18 };
+
+static const unsigned int sd_d0_c_pins[]	= { BOOT_0 };
+static const unsigned int sd_d1_c_pins[]	= { BOOT_1 };
+static const unsigned int sd_d2_c_pins[]	= { BOOT_2 };
+static const unsigned int sd_d3_c_pins[]	= { BOOT_3 };
+static const unsigned int sd_cmd_c_pins[]	= { BOOT_8 };
+static const unsigned int sd_clk_c_pins[]	= { BOOT_10 };
 
 /* bank CARD */
-static const unsigned int sd_d1_b_pins[]	= { PIN(CARD_0, 0) };
-static const unsigned int sd_d0_b_pins[]	= { PIN(CARD_1, 0) };
-static const unsigned int sd_clk_b_pins[]	= { PIN(CARD_2, 0) };
-static const unsigned int sd_cmd_b_pins[]	= { PIN(CARD_3, 0) };
-static const unsigned int sd_d3_b_pins[]	= { PIN(CARD_4, 0) };
-static const unsigned int sd_d2_b_pins[]	= { PIN(CARD_5, 0) };
-
-static const unsigned int sdxc_d13_b_pins[]	= { PIN(CARD_0, 0), PIN(CARD_4, 0),
-						    PIN(CARD_5, 0) };
-static const unsigned int sdxc_d0_b_pins[]	= { PIN(CARD_1, 0) };
-static const unsigned int sdxc_clk_b_pins[]	= { PIN(CARD_2, 0) };
-static const unsigned int sdxc_cmd_b_pins[]	= { PIN(CARD_3, 0) };
+static const unsigned int sd_d1_b_pins[]	= { CARD_0 };
+static const unsigned int sd_d0_b_pins[]	= { CARD_1 };
+static const unsigned int sd_clk_b_pins[]	= { CARD_2 };
+static const unsigned int sd_cmd_b_pins[]	= { CARD_3 };
+static const unsigned int sd_d3_b_pins[]	= { CARD_4 };
+static const unsigned int sd_d2_b_pins[]	= { CARD_5 };
+
+static const unsigned int sdxc_d13_b_pins[]	= { CARD_0,  CARD_4,
+						    CARD_5 };
+static const unsigned int sdxc_d0_b_pins[]	= { CARD_1 };
+static const unsigned int sdxc_clk_b_pins[]	= { CARD_2 };
+static const unsigned int sdxc_cmd_b_pins[]	= { CARD_3 };
 
 /* bank AO */
-static const unsigned int uart_tx_ao_a_pins[]	= { PIN(GPIOAO_0, AO_OFF) };
-static const unsigned int uart_rx_ao_a_pins[]	= { PIN(GPIOAO_1, AO_OFF) };
-static const unsigned int uart_cts_ao_a_pins[]	= { PIN(GPIOAO_2, AO_OFF) };
-static const unsigned int uart_rts_ao_a_pins[]	= { PIN(GPIOAO_3, AO_OFF) };
-static const unsigned int i2c_mst_sck_ao_pins[] = { PIN(GPIOAO_4, AO_OFF) };
-static const unsigned int i2c_mst_sda_ao_pins[] = { PIN(GPIOAO_5, AO_OFF) };
-static const unsigned int clk_32k_in_out_pins[]	= { PIN(GPIOAO_6, AO_OFF) };
-static const unsigned int remote_input_pins[]	= { PIN(GPIOAO_7, AO_OFF) };
-static const unsigned int hdmi_cec_1_pins[]	= { PIN(GPIOAO_12, AO_OFF) };
-static const unsigned int ir_blaster_pins[]	= { PIN(GPIOAO_13, AO_OFF) };
-
-static const unsigned int pwm_c2_pins[]		= { PIN(GPIOAO_3, AO_OFF) };
-static const unsigned int i2c_sck_ao_pins[]	= { PIN(GPIOAO_4, AO_OFF) };
-static const unsigned int i2c_sda_ao_pins[]	= { PIN(GPIOAO_5, AO_OFF) };
-static const unsigned int ir_remote_out_pins[]	= { PIN(GPIOAO_7, AO_OFF) };
-static const unsigned int i2s_am_clk_out_pins[]	= { PIN(GPIOAO_8, AO_OFF) };
-static const unsigned int i2s_ao_clk_out_pins[]	= { PIN(GPIOAO_9, AO_OFF) };
-static const unsigned int i2s_lr_clk_out_pins[]	= { PIN(GPIOAO_10, AO_OFF) };
-static const unsigned int i2s_out_01_pins[]	= { PIN(GPIOAO_11, AO_OFF) };
-
-static const unsigned int uart_tx_ao_b0_pins[]	= { PIN(GPIOAO_0, AO_OFF) };
-static const unsigned int uart_rx_ao_b0_pins[]	= { PIN(GPIOAO_1, AO_OFF) };
-static const unsigned int uart_cts_ao_b_pins[]	= { PIN(GPIOAO_2, AO_OFF) };
-static const unsigned int uart_rts_ao_b_pins[]	= { PIN(GPIOAO_3, AO_OFF) };
-static const unsigned int uart_tx_ao_b1_pins[]	= { PIN(GPIOAO_4, AO_OFF) };
-static const unsigned int uart_rx_ao_b1_pins[]	= { PIN(GPIOAO_5, AO_OFF) };
-static const unsigned int spdif_out_1_pins[]	= { PIN(GPIOAO_6, AO_OFF) };
-
-static const unsigned int i2s_in_ch01_pins[]	= { PIN(GPIOAO_6, AO_OFF) };
-static const unsigned int i2s_ao_clk_in_pins[]	= { PIN(GPIOAO_9, AO_OFF) };
-static const unsigned int i2s_lr_clk_in_pins[]	= { PIN(GPIOAO_10, AO_OFF) };
+static const unsigned int uart_tx_ao_a_pins[]	= { GPIOAO_0 };
+static const unsigned int uart_rx_ao_a_pins[]	= { GPIOAO_1 };
+static const unsigned int uart_cts_ao_a_pins[]	= { GPIOAO_2 };
+static const unsigned int uart_rts_ao_a_pins[]	= { GPIOAO_3 };
+static const unsigned int i2c_mst_sck_ao_pins[] = { GPIOAO_4 };
+static const unsigned int i2c_mst_sda_ao_pins[] = { GPIOAO_5 };
+static const unsigned int clk_32k_in_out_pins[]	= { GPIOAO_6 };
+static const unsigned int remote_input_pins[]	= { GPIOAO_7 };
+static const unsigned int hdmi_cec_1_pins[]	= { GPIOAO_12 };
+static const unsigned int ir_blaster_pins[]	= { GPIOAO_13 };
+
+static const unsigned int pwm_c2_pins[]		= { GPIOAO_3 };
+static const unsigned int i2c_sck_ao_pins[]	= { GPIOAO_4 };
+static const unsigned int i2c_sda_ao_pins[]	= { GPIOAO_5 };
+static const unsigned int ir_remote_out_pins[]	= { GPIOAO_7 };
+static const unsigned int i2s_am_clk_out_pins[]	= { GPIOAO_8 };
+static const unsigned int i2s_ao_clk_out_pins[]	= { GPIOAO_9 };
+static const unsigned int i2s_lr_clk_out_pins[]	= { GPIOAO_10 };
+static const unsigned int i2s_out_01_pins[]	= { GPIOAO_11 };
+
+static const unsigned int uart_tx_ao_b0_pins[]	= { GPIOAO_0 };
+static const unsigned int uart_rx_ao_b0_pins[]	= { GPIOAO_1 };
+static const unsigned int uart_cts_ao_b_pins[]	= { GPIOAO_2 };
+static const unsigned int uart_rts_ao_b_pins[]	= { GPIOAO_3 };
+static const unsigned int uart_tx_ao_b1_pins[]	= { GPIOAO_4 };
+static const unsigned int uart_rx_ao_b1_pins[]	= { GPIOAO_5 };
+static const unsigned int spdif_out_1_pins[]	= { GPIOAO_6 };
+
+static const unsigned int i2s_in_ch01_pins[]	= { GPIOAO_6 };
+static const unsigned int i2s_ao_clk_in_pins[]	= { GPIOAO_9 };
+static const unsigned int i2s_lr_clk_in_pins[]	= { GPIOAO_10 };
 
 /* bank DIF */
-static const unsigned int eth_rxd1_pins[]	= { PIN(DIF_0_P, 0) };
-static const unsigned int eth_rxd0_pins[]	= { PIN(DIF_0_N, 0) };
-static const unsigned int eth_rx_dv_pins[]	= { PIN(DIF_1_P, 0) };
-static const unsigned int eth_rx_clk_pins[]	= { PIN(DIF_1_N, 0) };
-static const unsigned int eth_txd0_1_pins[]	= { PIN(DIF_2_P, 0) };
-static const unsigned int eth_txd1_1_pins[]	= { PIN(DIF_2_N, 0) };
-static const unsigned int eth_tx_en_pins[]	= { PIN(DIF_3_P, 0) };
-static const unsigned int eth_ref_clk_pins[]	= { PIN(DIF_3_N, 0) };
-static const unsigned int eth_mdc_pins[]	= { PIN(DIF_4_P, 0) };
-static const unsigned int eth_mdio_en_pins[]	= { PIN(DIF_4_N, 0) };
+static const unsigned int eth_rxd1_pins[]	= { DIF_0_P };
+static const unsigned int eth_rxd0_pins[]	= { DIF_0_N };
+static const unsigned int eth_rx_dv_pins[]	= { DIF_1_P };
+static const unsigned int eth_rx_clk_pins[]	= { DIF_1_N };
+static const unsigned int eth_txd0_1_pins[]	= { DIF_2_P };
+static const unsigned int eth_txd1_1_pins[]	= { DIF_2_N };
+static const unsigned int eth_tx_en_pins[]	= { DIF_3_P };
+static const unsigned int eth_ref_clk_pins[]	= { DIF_3_N };
+static const unsigned int eth_mdc_pins[]	= { DIF_4_P };
+static const unsigned int eth_mdio_en_pins[]	= { DIF_4_N };
 
 static struct meson_pmx_group meson8b_cbus_groups[] = {
-	GPIO_GROUP(GPIOX_0, 0),
-	GPIO_GROUP(GPIOX_1, 0),
-	GPIO_GROUP(GPIOX_2, 0),
-	GPIO_GROUP(GPIOX_3, 0),
-	GPIO_GROUP(GPIOX_4, 0),
-	GPIO_GROUP(GPIOX_5, 0),
-	GPIO_GROUP(GPIOX_6, 0),
-	GPIO_GROUP(GPIOX_7, 0),
-	GPIO_GROUP(GPIOX_8, 0),
-	GPIO_GROUP(GPIOX_9, 0),
-	GPIO_GROUP(GPIOX_10, 0),
-	GPIO_GROUP(GPIOX_11, 0),
-	GPIO_GROUP(GPIOX_16, 0),
-	GPIO_GROUP(GPIOX_17, 0),
-	GPIO_GROUP(GPIOX_18, 0),
-	GPIO_GROUP(GPIOX_19, 0),
-	GPIO_GROUP(GPIOX_20, 0),
-	GPIO_GROUP(GPIOX_21, 0),
-
-	GPIO_GROUP(GPIOY_0, 0),
-	GPIO_GROUP(GPIOY_1, 0),
-	GPIO_GROUP(GPIOY_3, 0),
-	GPIO_GROUP(GPIOY_6, 0),
-	GPIO_GROUP(GPIOY_7, 0),
-	GPIO_GROUP(GPIOY_8, 0),
-	GPIO_GROUP(GPIOY_9, 0),
-	GPIO_GROUP(GPIOY_10, 0),
-	GPIO_GROUP(GPIOY_11, 0),
-	GPIO_GROUP(GPIOY_12, 0),
-	GPIO_GROUP(GPIOY_13, 0),
-	GPIO_GROUP(GPIOY_14, 0),
-
-	GPIO_GROUP(GPIODV_9, 0),
-	GPIO_GROUP(GPIODV_24, 0),
-	GPIO_GROUP(GPIODV_25, 0),
-	GPIO_GROUP(GPIODV_26, 0),
-	GPIO_GROUP(GPIODV_27, 0),
-	GPIO_GROUP(GPIODV_28, 0),
-	GPIO_GROUP(GPIODV_29, 0),
-
-	GPIO_GROUP(GPIOH_0, 0),
-	GPIO_GROUP(GPIOH_1, 0),
-	GPIO_GROUP(GPIOH_2, 0),
-	GPIO_GROUP(GPIOH_3, 0),
-	GPIO_GROUP(GPIOH_4, 0),
-	GPIO_GROUP(GPIOH_5, 0),
-	GPIO_GROUP(GPIOH_6, 0),
-	GPIO_GROUP(GPIOH_7, 0),
-	GPIO_GROUP(GPIOH_8, 0),
-	GPIO_GROUP(GPIOH_9, 0),
-
-	GPIO_GROUP(DIF_0_P, 0),
-	GPIO_GROUP(DIF_0_N, 0),
-	GPIO_GROUP(DIF_1_P, 0),
-	GPIO_GROUP(DIF_1_N, 0),
-	GPIO_GROUP(DIF_2_P, 0),
-	GPIO_GROUP(DIF_2_N, 0),
-	GPIO_GROUP(DIF_3_P, 0),
-	GPIO_GROUP(DIF_3_N, 0),
-	GPIO_GROUP(DIF_4_P, 0),
-	GPIO_GROUP(DIF_4_N, 0),
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
+	GPIO_GROUP(GPIOX_16),
+	GPIO_GROUP(GPIOX_17),
+	GPIO_GROUP(GPIOX_18),
+	GPIO_GROUP(GPIOX_19),
+	GPIO_GROUP(GPIOX_20),
+	GPIO_GROUP(GPIOX_21),
+
+	GPIO_GROUP(GPIOY_0),
+	GPIO_GROUP(GPIOY_1),
+	GPIO_GROUP(GPIOY_3),
+	GPIO_GROUP(GPIOY_6),
+	GPIO_GROUP(GPIOY_7),
+	GPIO_GROUP(GPIOY_8),
+	GPIO_GROUP(GPIOY_9),
+	GPIO_GROUP(GPIOY_10),
+	GPIO_GROUP(GPIOY_11),
+	GPIO_GROUP(GPIOY_12),
+	GPIO_GROUP(GPIOY_13),
+	GPIO_GROUP(GPIOY_14),
+
+	GPIO_GROUP(GPIODV_9),
+	GPIO_GROUP(GPIODV_24),
+	GPIO_GROUP(GPIODV_25),
+	GPIO_GROUP(GPIODV_26),
+	GPIO_GROUP(GPIODV_27),
+	GPIO_GROUP(GPIODV_28),
+	GPIO_GROUP(GPIODV_29),
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
+	GPIO_GROUP(DIF_0_P),
+	GPIO_GROUP(DIF_0_N),
+	GPIO_GROUP(DIF_1_P),
+	GPIO_GROUP(DIF_1_N),
+	GPIO_GROUP(DIF_2_P),
+	GPIO_GROUP(DIF_2_N),
+	GPIO_GROUP(DIF_3_P),
+	GPIO_GROUP(DIF_3_N),
+	GPIO_GROUP(DIF_4_P),
+	GPIO_GROUP(DIF_4_N),
 
 	/* bank X */
 	GROUP(sd_d0_a,		8,	5),
@@ -577,22 +573,22 @@ static struct meson_pmx_group meson8b_cbus_groups[] = {
 };
 
 static struct meson_pmx_group meson8b_aobus_groups[] = {
-	GPIO_GROUP(GPIOAO_0, AO_OFF),
-	GPIO_GROUP(GPIOAO_1, AO_OFF),
-	GPIO_GROUP(GPIOAO_2, AO_OFF),
-	GPIO_GROUP(GPIOAO_3, AO_OFF),
-	GPIO_GROUP(GPIOAO_4, AO_OFF),
-	GPIO_GROUP(GPIOAO_5, AO_OFF),
-	GPIO_GROUP(GPIOAO_6, AO_OFF),
-	GPIO_GROUP(GPIOAO_7, AO_OFF),
-	GPIO_GROUP(GPIOAO_8, AO_OFF),
-	GPIO_GROUP(GPIOAO_9, AO_OFF),
-	GPIO_GROUP(GPIOAO_10, AO_OFF),
-	GPIO_GROUP(GPIOAO_11, AO_OFF),
-	GPIO_GROUP(GPIOAO_12, AO_OFF),
-	GPIO_GROUP(GPIOAO_13, AO_OFF),
-	GPIO_GROUP(GPIO_BSD_EN, AO_OFF),
-	GPIO_GROUP(GPIO_TEST_N, AO_OFF),
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
+	GPIO_GROUP(GPIOAO_10),
+	GPIO_GROUP(GPIOAO_11),
+	GPIO_GROUP(GPIOAO_12),
+	GPIO_GROUP(GPIOAO_13),
+	GPIO_GROUP(GPIO_BSD_EN),
+	GPIO_GROUP(GPIO_TEST_N),
 
 	/* bank AO */
 	GROUP(uart_tx_ao_a,	0,	12),
@@ -887,25 +883,25 @@ static struct meson_pmx_func meson8b_aobus_functions[] = {
 };
 
 static struct meson_bank meson8b_cbus_banks[] = {
-	/*   name    first                      last                irq      pullen  pull    dir     out     in  */
-	BANK("X",    PIN(GPIOX_0, 0),		PIN(GPIOX_21, 0),   97, 118, 4,  0,  4,  0,  0,  0,  1,  0,  2,  0),
-	BANK("Y",    PIN(GPIOY_0, 0),		PIN(GPIOY_14, 0),   80,  96, 3,  0,  3,  0,  3,  0,  4,  0,  5,  0),
-	BANK("DV",   PIN(GPIODV_9, 0),		PIN(GPIODV_29, 0),  59,  79, 0,  0,  0,  0,  7,  0,  8,  0,  9,  0),
-	BANK("H",    PIN(GPIOH_0, 0),		PIN(GPIOH_9, 0),    14,  23, 1, 16,  1, 16,  9, 19, 10, 19, 11, 19),
-	BANK("CARD", PIN(CARD_0, 0),		PIN(CARD_6, 0),     43,  49, 2, 20,  2, 20,  0, 22,  1, 22,  2, 22),
-	BANK("BOOT", PIN(BOOT_0, 0),		PIN(BOOT_18, 0),    24,  42, 2,  0,  2,  0,  9,  0, 10,  0, 11,  0),
+	/*   name    first              last        irq      pullen  pull    dir     out     in  */
+	BANK("X",    GPIOX_0,		GPIOX_21,   97, 118, 4,  0,  4,  0,  0,  0,  1,  0,  2,  0),
+	BANK("Y",    GPIOY_0,		GPIOY_14,   80,  96, 3,  0,  3,  0,  3,  0,  4,  0,  5,  0),
+	BANK("DV",   GPIODV_9,		GPIODV_29,  59,  79, 0,  0,  0,  0,  7,  0,  8,  0,  9,  0),
+	BANK("H",    GPIOH_0,		GPIOH_9,    14,  23, 1, 16,  1, 16,  9, 19, 10, 19, 11, 19),
+	BANK("CARD", CARD_0,		CARD_6,     43,  49, 2, 20,  2, 20,  0, 22,  1, 22,  2, 22),
+	BANK("BOOT", BOOT_0,		BOOT_18,    24,  42, 2,  0,  2,  0,  9,  0, 10,  0, 11,  0),
 
 	/*
 	 * The following bank is not mentionned in the public datasheet
 	 * There is no information whether it can be used with the gpio
 	 * interrupt controller
 	 */
-	BANK("DIF",  PIN(DIF_0_P, 0),		PIN(DIF_4_N, 0),    -1,  -1, 5,  8,  5,  8, 12, 12, 13, 12, 14, 12),
+	BANK("DIF",  DIF_0_P,		DIF_4_N,    -1,  -1, 5,  8,  5,  8, 12, 12, 13, 12, 14, 12),
 };
 
 static struct meson_bank meson8b_aobus_banks[] = {
-	/*   name    first                  last                      irq    pullen  pull    dir     out     in  */
-	BANK("AO",   PIN(GPIOAO_0, AO_OFF), PIN(GPIO_TEST_N, AO_OFF), 0, 13, 0,  0,  0, 16,  0,  0,  0, 16,  1,  0),
+	/*   name    first     lastc        irq    pullen  pull    dir     out     in  */
+	BANK("AO",   GPIOAO_0, GPIO_TEST_N, 0, 13, 0,  0,  0, 16,  0,  0,  0, 16,  1,  0),
 };
 
 struct meson_pinctrl_data meson8b_cbus_pinctrl_data = {
@@ -923,7 +919,7 @@ struct meson_pinctrl_data meson8b_cbus_pinctrl_data = {
 
 struct meson_pinctrl_data meson8b_aobus_pinctrl_data = {
 	.name		= "aobus-banks",
-	.pin_base	= 130,
+	.pin_base	= 0,
 	.pins		= meson8b_aobus_pins,
 	.groups		= meson8b_aobus_groups,
 	.funcs		= meson8b_aobus_functions,
-- 
2.13.5
