From: jbrunet@baylibre.com (Jerome Brunet)
Date: Wed, 20 Sep 2017 15:39:23 +0200
Subject: [PATCH 4/8] pinctrl: meson: remove offset continued - meson8
In-Reply-To: <20170920133927.17390-1-jbrunet@baylibre.com>
References: <20170920133927.17390-1-jbrunet@baylibre.com>
Message-ID: <20170920133927.17390-5-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tested-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/pinctrl/meson/pinctrl-meson8.c | 964 ++++++++++++++++-----------------
 1 file changed, 476 insertions(+), 488 deletions(-)

diff --git a/drivers/pinctrl/meson/pinctrl-meson8.c b/drivers/pinctrl/meson/pinctrl-meson8.c
index 970f6f14502c..7344f8577467 100644
--- a/drivers/pinctrl/meson/pinctrl-meson8.c
+++ b/drivers/pinctrl/meson/pinctrl-meson8.c
@@ -14,505 +14,493 @@
 #include <dt-bindings/gpio/meson8-gpio.h>
 #include "pinctrl-meson.h"
 
-#define AO_OFF	120
-
 static const struct pinctrl_pin_desc meson8_cbus_pins[] = {
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
-	MESON_PIN(GPIOX_12, 0),
-	MESON_PIN(GPIOX_13, 0),
-	MESON_PIN(GPIOX_14, 0),
-	MESON_PIN(GPIOX_15, 0),
-	MESON_PIN(GPIOX_16, 0),
-	MESON_PIN(GPIOX_17, 0),
-	MESON_PIN(GPIOX_18, 0),
-	MESON_PIN(GPIOX_19, 0),
-	MESON_PIN(GPIOX_20, 0),
-	MESON_PIN(GPIOX_21, 0),
-	MESON_PIN(GPIOY_0, 0),
-	MESON_PIN(GPIOY_1, 0),
-	MESON_PIN(GPIOY_2, 0),
-	MESON_PIN(GPIOY_3, 0),
-	MESON_PIN(GPIOY_4, 0),
-	MESON_PIN(GPIOY_5, 0),
-	MESON_PIN(GPIOY_6, 0),
-	MESON_PIN(GPIOY_7, 0),
-	MESON_PIN(GPIOY_8, 0),
-	MESON_PIN(GPIOY_9, 0),
-	MESON_PIN(GPIOY_10, 0),
-	MESON_PIN(GPIOY_11, 0),
-	MESON_PIN(GPIOY_12, 0),
-	MESON_PIN(GPIOY_13, 0),
-	MESON_PIN(GPIOY_14, 0),
-	MESON_PIN(GPIOY_15, 0),
-	MESON_PIN(GPIOY_16, 0),
-	MESON_PIN(GPIODV_0, 0),
-	MESON_PIN(GPIODV_1, 0),
-	MESON_PIN(GPIODV_2, 0),
-	MESON_PIN(GPIODV_3, 0),
-	MESON_PIN(GPIODV_4, 0),
-	MESON_PIN(GPIODV_5, 0),
-	MESON_PIN(GPIODV_6, 0),
-	MESON_PIN(GPIODV_7, 0),
-	MESON_PIN(GPIODV_8, 0),
-	MESON_PIN(GPIODV_9, 0),
-	MESON_PIN(GPIODV_10, 0),
-	MESON_PIN(GPIODV_11, 0),
-	MESON_PIN(GPIODV_12, 0),
-	MESON_PIN(GPIODV_13, 0),
-	MESON_PIN(GPIODV_14, 0),
-	MESON_PIN(GPIODV_15, 0),
-	MESON_PIN(GPIODV_16, 0),
-	MESON_PIN(GPIODV_17, 0),
-	MESON_PIN(GPIODV_18, 0),
-	MESON_PIN(GPIODV_19, 0),
-	MESON_PIN(GPIODV_20, 0),
-	MESON_PIN(GPIODV_21, 0),
-	MESON_PIN(GPIODV_22, 0),
-	MESON_PIN(GPIODV_23, 0),
-	MESON_PIN(GPIODV_24, 0),
-	MESON_PIN(GPIODV_25, 0),
-	MESON_PIN(GPIODV_26, 0),
-	MESON_PIN(GPIODV_27, 0),
-	MESON_PIN(GPIODV_28, 0),
-	MESON_PIN(GPIODV_29, 0),
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
-	MESON_PIN(GPIOZ_0, 0),
-	MESON_PIN(GPIOZ_1, 0),
-	MESON_PIN(GPIOZ_2, 0),
-	MESON_PIN(GPIOZ_3, 0),
-	MESON_PIN(GPIOZ_4, 0),
-	MESON_PIN(GPIOZ_5, 0),
-	MESON_PIN(GPIOZ_6, 0),
-	MESON_PIN(GPIOZ_7, 0),
-	MESON_PIN(GPIOZ_8, 0),
-	MESON_PIN(GPIOZ_9, 0),
-	MESON_PIN(GPIOZ_10, 0),
-	MESON_PIN(GPIOZ_11, 0),
-	MESON_PIN(GPIOZ_12, 0),
-	MESON_PIN(GPIOZ_13, 0),
-	MESON_PIN(GPIOZ_14, 0),
-	MESON_PIN(CARD_0, 0),
-	MESON_PIN(CARD_1, 0),
-	MESON_PIN(CARD_2, 0),
-	MESON_PIN(CARD_3, 0),
-	MESON_PIN(CARD_4, 0),
-	MESON_PIN(CARD_5, 0),
-	MESON_PIN(CARD_6, 0),
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
+	MESON_PIN(GPIOX_19),
+	MESON_PIN(GPIOX_20),
+	MESON_PIN(GPIOX_21),
+	MESON_PIN(GPIOY_0),
+	MESON_PIN(GPIOY_1),
+	MESON_PIN(GPIOY_2),
+	MESON_PIN(GPIOY_3),
+	MESON_PIN(GPIOY_4),
+	MESON_PIN(GPIOY_5),
+	MESON_PIN(GPIOY_6),
+	MESON_PIN(GPIOY_7),
+	MESON_PIN(GPIOY_8),
+	MESON_PIN(GPIOY_9),
+	MESON_PIN(GPIOY_10),
+	MESON_PIN(GPIOY_11),
+	MESON_PIN(GPIOY_12),
+	MESON_PIN(GPIOY_13),
+	MESON_PIN(GPIOY_14),
+	MESON_PIN(GPIOY_15),
+	MESON_PIN(GPIOY_16),
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
+	MESON_PIN(CARD_0),
+	MESON_PIN(CARD_1),
+	MESON_PIN(CARD_2),
+	MESON_PIN(CARD_3),
+	MESON_PIN(CARD_4),
+	MESON_PIN(CARD_5),
+	MESON_PIN(CARD_6),
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
 };
 
 static const struct pinctrl_pin_desc meson8_aobus_pins[] = {
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
-	MESON_PIN(GPIO_BSD_EN, AO_OFF),
-	MESON_PIN(GPIO_TEST_N, AO_OFF),
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
+	MESON_PIN(GPIO_BSD_EN),
+	MESON_PIN(GPIO_TEST_N),
 };
 
 /* bank X */
-static const unsigned int sd_d0_a_pins[] = { PIN(GPIOX_0, 0) };
-static const unsigned int sd_d1_a_pins[] = { PIN(GPIOX_1, 0) };
-static const unsigned int sd_d2_a_pins[] = { PIN(GPIOX_2, 0) };
-static const unsigned int sd_d3_a_pins[] = { PIN(GPIOX_3, 0) };
-static const unsigned int sd_clk_a_pins[] = { PIN(GPIOX_8, 0) };
-static const unsigned int sd_cmd_a_pins[] = { PIN(GPIOX_9, 0) };
-
-static const unsigned int sdxc_d0_a_pins[] = { PIN(GPIOX_0, 0) };
-static const unsigned int sdxc_d13_a_pins[] = { PIN(GPIOX_1, 0), PIN(GPIOX_2, 0),
-						PIN(GPIOX_3, 0) };
-static const unsigned int sdxc_d47_a_pins[] = { PIN(GPIOX_4, 0), PIN(GPIOX_5, 0),
-						PIN(GPIOX_6, 0), PIN(GPIOX_7, 0) };
-static const unsigned int sdxc_clk_a_pins[] = { PIN(GPIOX_8, 0) };
-static const unsigned int sdxc_cmd_a_pins[] = { PIN(GPIOX_9, 0) };
-
-static const unsigned int pcm_out_a_pins[] = { PIN(GPIOX_4, 0) };
-static const unsigned int pcm_in_a_pins[] = { PIN(GPIOX_5, 0) };
-static const unsigned int pcm_fs_a_pins[] = { PIN(GPIOX_6, 0) };
-static const unsigned int pcm_clk_a_pins[] = { PIN(GPIOX_7, 0) };
-
-static const unsigned int uart_tx_a0_pins[] = { PIN(GPIOX_4, 0) };
-static const unsigned int uart_rx_a0_pins[] = { PIN(GPIOX_5, 0) };
-static const unsigned int uart_cts_a0_pins[] = { PIN(GPIOX_6, 0) };
-static const unsigned int uart_rts_a0_pins[] = { PIN(GPIOX_7, 0) };
-
-static const unsigned int uart_tx_a1_pins[] = { PIN(GPIOX_12, 0) };
-static const unsigned int uart_rx_a1_pins[] = { PIN(GPIOX_13, 0) };
-static const unsigned int uart_cts_a1_pins[] = { PIN(GPIOX_14, 0) };
-static const unsigned int uart_rts_a1_pins[] = { PIN(GPIOX_15, 0) };
-
-static const unsigned int uart_tx_b0_pins[] = { PIN(GPIOX_16, 0) };
-static const unsigned int uart_rx_b0_pins[] = { PIN(GPIOX_17, 0) };
-static const unsigned int uart_cts_b0_pins[] = { PIN(GPIOX_18, 0) };
-static const unsigned int uart_rts_b0_pins[] = { PIN(GPIOX_19, 0) };
-
-static const unsigned int iso7816_det_pins[] = { PIN(GPIOX_16, 0) };
-static const unsigned int iso7816_reset_pins[] = { PIN(GPIOX_17, 0) };
-static const unsigned int iso7816_clk_pins[] = { PIN(GPIOX_18, 0) };
-static const unsigned int iso7816_data_pins[] = { PIN(GPIOX_19, 0) };
-
-static const unsigned int i2c_sda_d0_pins[] = { PIN(GPIOX_16, 0) };
-static const unsigned int i2c_sck_d0_pins[] = { PIN(GPIOX_17, 0) };
-
-static const unsigned int xtal_32k_out_pins[] = { PIN(GPIOX_10, 0) };
-static const unsigned int xtal_24m_out_pins[] = { PIN(GPIOX_11, 0) };
-
-static const unsigned int pwm_e_pins[] = { PIN(GPIOX_10, 0) };
-static const unsigned int pwm_b_x_pins[] = { PIN(GPIOX_11, 0) };
+static const unsigned int sd_d0_a_pins[]	= { GPIOX_0 };
+static const unsigned int sd_d1_a_pins[]	= { GPIOX_1 };
+static const unsigned int sd_d2_a_pins[]	= { GPIOX_2 };
+static const unsigned int sd_d3_a_pins[]	= { GPIOX_3 };
+static const unsigned int sd_clk_a_pins[]	= { GPIOX_8 };
+static const unsigned int sd_cmd_a_pins[]	= { GPIOX_9 };
+
+static const unsigned int sdxc_d0_a_pins[]	= { GPIOX_0 };
+static const unsigned int sdxc_d13_a_pins[]	= { GPIOX_1, GPIOX_2, GPIOX_3 };
+static const unsigned int sdxc_d47_a_pins[]	= { GPIOX_4, GPIOX_5, GPIOX_6,
+						    GPIOX_7 };
+static const unsigned int sdxc_clk_a_pins[]	= { GPIOX_8 };
+static const unsigned int sdxc_cmd_a_pins[]	= { GPIOX_9 };
+
+static const unsigned int pcm_out_a_pins[]	= { GPIOX_4 };
+static const unsigned int pcm_in_a_pins[]	= { GPIOX_5 };
+static const unsigned int pcm_fs_a_pins[]	= { GPIOX_6 };
+static const unsigned int pcm_clk_a_pins[]	= { GPIOX_7 };
+
+static const unsigned int uart_tx_a0_pins[]	= { GPIOX_4 };
+static const unsigned int uart_rx_a0_pins[]	= { GPIOX_5 };
+static const unsigned int uart_cts_a0_pins[]	= { GPIOX_6 };
+static const unsigned int uart_rts_a0_pins[]	= { GPIOX_7 };
+
+static const unsigned int uart_tx_a1_pins[]	= { GPIOX_12 };
+static const unsigned int uart_rx_a1_pins[]	= { GPIOX_13 };
+static const unsigned int uart_cts_a1_pins[]	= { GPIOX_14 };
+static const unsigned int uart_rts_a1_pins[]	= { GPIOX_15 };
+
+static const unsigned int uart_tx_b0_pins[]	= { GPIOX_16 };
+static const unsigned int uart_rx_b0_pins[]	= { GPIOX_17 };
+static const unsigned int uart_cts_b0_pins[]	= { GPIOX_18 };
+static const unsigned int uart_rts_b0_pins[]	= { GPIOX_19 };
+
+static const unsigned int iso7816_det_pins[]	= { GPIOX_16 };
+static const unsigned int iso7816_reset_pins[]	= { GPIOX_17 };
+static const unsigned int iso7816_clk_pins[]	= { GPIOX_18 };
+static const unsigned int iso7816_data_pins[]	= { GPIOX_19 };
+
+static const unsigned int i2c_sda_d0_pins[]	= { GPIOX_16 };
+static const unsigned int i2c_sck_d0_pins[]	= { GPIOX_17 };
+
+static const unsigned int xtal_32k_out_pins[]	= { GPIOX_10 };
+static const unsigned int xtal_24m_out_pins[]	= { GPIOX_11 };
+
+static const unsigned int pwm_e_pins[]		= { GPIOX_10 };
+static const unsigned int pwm_b_x_pins[]	= { GPIOX_11 };
 
 /* bank Y */
-static const unsigned int uart_tx_c_pins[] = { PIN(GPIOY_0, 0) };
-static const unsigned int uart_rx_c_pins[] = { PIN(GPIOY_1, 0) };
-static const unsigned int uart_cts_c_pins[] = { PIN(GPIOY_2, 0) };
-static const unsigned int uart_rts_c_pins[] = { PIN(GPIOY_3, 0) };
+static const unsigned int uart_tx_c_pins[]	= { GPIOY_0 };
+static const unsigned int uart_rx_c_pins[]	= { GPIOY_1 };
+static const unsigned int uart_cts_c_pins[]	= { GPIOY_2 };
+static const unsigned int uart_rts_c_pins[]	= { GPIOY_3 };
 
-static const unsigned int pcm_out_b_pins[] = { PIN(GPIOY_4, 0) };
-static const unsigned int pcm_in_b_pins[] = { PIN(GPIOY_5, 0) };
-static const unsigned int pcm_fs_b_pins[] = { PIN(GPIOY_6, 0) };
-static const unsigned int pcm_clk_b_pins[] = { PIN(GPIOY_7, 0) };
+static const unsigned int pcm_out_b_pins[]	= { GPIOY_4 };
+static const unsigned int pcm_in_b_pins[]	= { GPIOY_5 };
+static const unsigned int pcm_fs_b_pins[]	= { GPIOY_6 };
+static const unsigned int pcm_clk_b_pins[]	= { GPIOY_7 };
 
-static const unsigned int i2c_sda_c0_pins[] = { PIN(GPIOY_0, 0) };
-static const unsigned int i2c_sck_c0_pins[] = { PIN(GPIOY_1, 0) };
+static const unsigned int i2c_sda_c0_pins[]	= { GPIOY_0 };
+static const unsigned int i2c_sck_c0_pins[]	= { GPIOY_1 };
 
-static const unsigned int pwm_a_y_pins[] = { PIN(GPIOY_16, 0) };
+static const unsigned int pwm_a_y_pins[]	= { GPIOY_16 };
 
-static const unsigned int i2s_out_ch45_pins[] = { PIN(GPIOY_0, 0) };
-static const unsigned int i2s_out_ch23_pins[] = { PIN(GPIOY_1, 0) };
-static const unsigned int i2s_out_ch01_pins[] = { PIN(GPIOY_4, 0) };
-static const unsigned int i2s_in_ch01_pins[] = { PIN(GPIOY_5, 0) };
-static const unsigned int i2s_lr_clk_in_pins[] = { PIN(GPIOY_6, 0) };
-static const unsigned int i2s_ao_clk_in_pins[] = { PIN(GPIOY_7, 0) };
-static const unsigned int i2s_am_clk_pins[] = { PIN(GPIOY_8, 0) };
-static const unsigned int i2s_out_ch78_pins[] = { PIN(GPIOY_9, 0) };
+static const unsigned int i2s_out_ch45_pins[]	= { GPIOY_0 };
+static const unsigned int i2s_out_ch23_pins[]	= { GPIOY_1 };
+static const unsigned int i2s_out_ch01_pins[]	= { GPIOY_4 };
+static const unsigned int i2s_in_ch01_pins[]	= { GPIOY_5 };
+static const unsigned int i2s_lr_clk_in_pins[]	= { GPIOY_6 };
+static const unsigned int i2s_ao_clk_in_pins[]	= { GPIOY_7 };
+static const unsigned int i2s_am_clk_pins[]	= { GPIOY_8 };
+static const unsigned int i2s_out_ch78_pins[]	= { GPIOY_9 };
 
-static const unsigned int spdif_in_pins[] = { PIN(GPIOY_2, 0) };
-static const unsigned int spdif_out_pins[] = { PIN(GPIOY_3, 0) };
+static const unsigned int spdif_in_pins[]	= { GPIOY_2 };
+static const unsigned int spdif_out_pins[]	= { GPIOY_3 };
 
 /* bank DV */
-static const unsigned int dvin_rgb_pins[] = { PIN(GPIODV_0, 0), PIN(GPIODV_1, 0),
-					      PIN(GPIODV_2, 0), PIN(GPIODV_3, 0),
-					      PIN(GPIODV_4, 0), PIN(GPIODV_5, 0),
-					      PIN(GPIODV_6, 0), PIN(GPIODV_7, 0),
-					      PIN(GPIODV_8, 0), PIN(GPIODV_9, 0),
-					      PIN(GPIODV_10, 0), PIN(GPIODV_11, 0),
-					      PIN(GPIODV_12, 0), PIN(GPIODV_13, 0),
-					      PIN(GPIODV_14, 0), PIN(GPIODV_15, 0),
-					      PIN(GPIODV_16, 0), PIN(GPIODV_17, 0),
-					      PIN(GPIODV_18, 0), PIN(GPIODV_19, 0),
-					      PIN(GPIODV_20, 0), PIN(GPIODV_21, 0),
-					      PIN(GPIODV_22, 0), PIN(GPIODV_23, 0) };
-static const unsigned int dvin_vs_pins[] = { PIN(GPIODV_24, 0) };
-static const unsigned int dvin_hs_pins[] = { PIN(GPIODV_25, 0) };
-static const unsigned int dvin_clk_pins[] = { PIN(GPIODV_26, 0) };
-static const unsigned int dvin_de_pins[] = { PIN(GPIODV_27, 0) };
-
-static const unsigned int enc_0_pins[] = { PIN(GPIODV_0, 0) };
-static const unsigned int enc_1_pins[] = { PIN(GPIODV_1, 0) };
-static const unsigned int enc_2_pins[] = { PIN(GPIODV_2, 0) };
-static const unsigned int enc_3_pins[] = { PIN(GPIODV_3, 0) };
-static const unsigned int enc_4_pins[] = { PIN(GPIODV_4, 0) };
-static const unsigned int enc_5_pins[] = { PIN(GPIODV_5, 0) };
-static const unsigned int enc_6_pins[] = { PIN(GPIODV_6, 0) };
-static const unsigned int enc_7_pins[] = { PIN(GPIODV_7, 0) };
-static const unsigned int enc_8_pins[] = { PIN(GPIODV_8, 0) };
-static const unsigned int enc_9_pins[] = { PIN(GPIODV_9, 0) };
-static const unsigned int enc_10_pins[] = { PIN(GPIODV_10, 0) };
-static const unsigned int enc_11_pins[] = { PIN(GPIODV_11, 0) };
-static const unsigned int enc_12_pins[] = { PIN(GPIODV_12, 0) };
-static const unsigned int enc_13_pins[] = { PIN(GPIODV_13, 0) };
-static const unsigned int enc_14_pins[] = { PIN(GPIODV_14, 0) };
-static const unsigned int enc_15_pins[] = { PIN(GPIODV_15, 0) };
-static const unsigned int enc_16_pins[] = { PIN(GPIODV_16, 0) };
-static const unsigned int enc_17_pins[] = { PIN(GPIODV_17, 0) };
-
-static const unsigned int uart_tx_b1_pins[] = { PIN(GPIODV_24, 0) };
-static const unsigned int uart_rx_b1_pins[] = { PIN(GPIODV_25, 0) };
-static const unsigned int uart_cts_b1_pins[] = { PIN(GPIODV_26, 0) };
-static const unsigned int uart_rts_b1_pins[] = { PIN(GPIODV_27, 0) };
-
-static const unsigned int vga_vs_pins[] = { PIN(GPIODV_24, 0) };
-static const unsigned int vga_hs_pins[] = { PIN(GPIODV_25, 0) };
-
-static const unsigned int pwm_c_dv9_pins[] = { PIN(GPIODV_9, 0) };
-static const unsigned int pwm_c_dv29_pins[] = { PIN(GPIODV_29, 0) };
-static const unsigned int pwm_d_pins[] = { PIN(GPIODV_28, 0) };
+static const unsigned int dvin_rgb_pins[] = {
+	GPIODV_0, GPIODV_1, GPIODV_2, GPIODV_3, GPIODV_4, GPIODV_5,
+	GPIODV_6, GPIODV_7, GPIODV_8, GPIODV_9, GPIODV_10, GPIODV_11,
+	GPIODV_12, GPIODV_13, GPIODV_14, GPIODV_15, GPIODV_16, GPIODV_17,
+	GPIODV_18, GPIODV_19, GPIODV_20, GPIODV_21, GPIODV_22, GPIODV_23
+};
+static const unsigned int dvin_vs_pins[]	= { GPIODV_24 };
+static const unsigned int dvin_hs_pins[]	= { GPIODV_25 };
+static const unsigned int dvin_clk_pins[]	= { GPIODV_26 };
+static const unsigned int dvin_de_pins[]	= { GPIODV_27 };
+
+static const unsigned int enc_0_pins[]		= { GPIODV_0 };
+static const unsigned int enc_1_pins[]		= { GPIODV_1 };
+static const unsigned int enc_2_pins[]		= { GPIODV_2 };
+static const unsigned int enc_3_pins[]		= { GPIODV_3 };
+static const unsigned int enc_4_pins[]		= { GPIODV_4 };
+static const unsigned int enc_5_pins[]		= { GPIODV_5 };
+static const unsigned int enc_6_pins[]		= { GPIODV_6 };
+static const unsigned int enc_7_pins[]		= { GPIODV_7 };
+static const unsigned int enc_8_pins[]		= { GPIODV_8 };
+static const unsigned int enc_9_pins[]		= { GPIODV_9 };
+static const unsigned int enc_10_pins[]		= { GPIODV_10 };
+static const unsigned int enc_11_pins[]		= { GPIODV_11 };
+static const unsigned int enc_12_pins[]		= { GPIODV_12 };
+static const unsigned int enc_13_pins[]		= { GPIODV_13 };
+static const unsigned int enc_14_pins[]		= { GPIODV_14 };
+static const unsigned int enc_15_pins[]		= { GPIODV_15 };
+static const unsigned int enc_16_pins[]		= { GPIODV_16 };
+static const unsigned int enc_17_pins[]		= { GPIODV_17 };
+
+static const unsigned int uart_tx_b1_pins[]	= { GPIODV_24 };
+static const unsigned int uart_rx_b1_pins[]	= { GPIODV_25 };
+static const unsigned int uart_cts_b1_pins[]	= { GPIODV_26 };
+static const unsigned int uart_rts_b1_pins[]	= { GPIODV_27 };
+
+static const unsigned int vga_vs_pins[]		= { GPIODV_24 };
+static const unsigned int vga_hs_pins[]		= { GPIODV_25 };
+
+static const unsigned int pwm_c_dv9_pins[]	= { GPIODV_9 };
+static const unsigned int pwm_c_dv29_pins[]	= { GPIODV_29 };
+static const unsigned int pwm_d_pins[]		= { GPIODV_28 };
 
 /* bank H */
-static const unsigned int hdmi_hpd_pins[] = { PIN(GPIOH_0, 0) };
-static const unsigned int hdmi_sda_pins[] = { PIN(GPIOH_1, 0) };
-static const unsigned int hdmi_scl_pins[] = { PIN(GPIOH_2, 0) };
-static const unsigned int hdmi_cec_pins[] = { PIN(GPIOH_3, 0) };
+static const unsigned int hdmi_hpd_pins[]	= { GPIOH_0 };
+static const unsigned int hdmi_sda_pins[]	= { GPIOH_1 };
+static const unsigned int hdmi_scl_pins[]	= { GPIOH_2 };
+static const unsigned int hdmi_cec_pins[]	= { GPIOH_3 };
 
-static const unsigned int spi_ss0_0_pins[] = { PIN(GPIOH_3, 0) };
-static const unsigned int spi_miso_0_pins[] = { PIN(GPIOH_4, 0) };
-static const unsigned int spi_mosi_0_pins[] = { PIN(GPIOH_5, 0) };
-static const unsigned int spi_sclk_0_pins[] = { PIN(GPIOH_6, 0) };
+static const unsigned int spi_ss0_0_pins[]	= { GPIOH_3 };
+static const unsigned int spi_miso_0_pins[]	= { GPIOH_4 };
+static const unsigned int spi_mosi_0_pins[]	= { GPIOH_5 };
+static const unsigned int spi_sclk_0_pins[]	= { GPIOH_6 };
 
-static const unsigned int i2c_sda_d1_pins[] = { PIN(GPIOH_7, 0) };
-static const unsigned int i2c_sck_d1_pins[] = { PIN(GPIOH_8, 0) };
+static const unsigned int i2c_sda_d1_pins[]	= { GPIOH_7 };
+static const unsigned int i2c_sck_d1_pins[]	= { GPIOH_8 };
 
 /* bank Z */
-static const unsigned int spi_ss0_1_pins[] = { PIN(GPIOZ_9, 0) };
-static const unsigned int spi_ss1_1_pins[] = { PIN(GPIOZ_10, 0) };
-static const unsigned int spi_sclk_1_pins[] = { PIN(GPIOZ_11, 0) };
-static const unsigned int spi_mosi_1_pins[] = { PIN(GPIOZ_12, 0) };
-static const unsigned int spi_miso_1_pins[] = { PIN(GPIOZ_13, 0) };
-static const unsigned int spi_ss2_1_pins[] = { PIN(GPIOZ_14, 0) };
-
-static const unsigned int eth_tx_clk_50m_pins[] = { PIN(GPIOZ_4, 0) };
-static const unsigned int eth_tx_en_pins[] = { PIN(GPIOZ_5, 0) };
-static const unsigned int eth_txd1_pins[] = { PIN(GPIOZ_6, 0) };
-static const unsigned int eth_txd0_pins[] = { PIN(GPIOZ_7, 0) };
-static const unsigned int eth_rx_clk_in_pins[] = { PIN(GPIOZ_8, 0) };
-static const unsigned int eth_rx_dv_pins[] = { PIN(GPIOZ_9, 0) };
-static const unsigned int eth_rxd1_pins[] = { PIN(GPIOZ_10, 0) };
-static const unsigned int eth_rxd0_pins[] = { PIN(GPIOZ_11, 0) };
-static const unsigned int eth_mdio_pins[] = { PIN(GPIOZ_12, 0) };
-static const unsigned int eth_mdc_pins[] = { PIN(GPIOZ_13, 0) };
-
-static const unsigned int i2c_sda_a0_pins[] = { PIN(GPIOZ_0, 0) };
-static const unsigned int i2c_sck_a0_pins[] = { PIN(GPIOZ_1, 0) };
-
-static const unsigned int i2c_sda_b_pins[] = { PIN(GPIOZ_2, 0) };
-static const unsigned int i2c_sck_b_pins[] = { PIN(GPIOZ_3, 0) };
-
-static const unsigned int i2c_sda_c1_pins[] = { PIN(GPIOZ_4, 0) };
-static const unsigned int i2c_sck_c1_pins[] = { PIN(GPIOZ_5, 0) };
-
-static const unsigned int i2c_sda_a1_pins[] = { PIN(GPIOZ_0, 0) };
-static const unsigned int i2c_sck_a1_pins[] = { PIN(GPIOZ_1, 0) };
-
-static const unsigned int i2c_sda_a2_pins[] = { PIN(GPIOZ_0, 0) };
-static const unsigned int i2c_sck_a2_pins[] = { PIN(GPIOZ_1, 0) };
-
-static const unsigned int pwm_a_z0_pins[] = { PIN(GPIOZ_0, 0) };
-static const unsigned int pwm_a_z7_pins[] = { PIN(GPIOZ_7, 0) };
-static const unsigned int pwm_b_z_pins[] = { PIN(GPIOZ_1, 0) };
-static const unsigned int pwm_c_z_pins[] = { PIN(GPIOZ_8, 0) };
+static const unsigned int spi_ss0_1_pins[]	= { GPIOZ_9 };
+static const unsigned int spi_ss1_1_pins[]	= { GPIOZ_10 };
+static const unsigned int spi_sclk_1_pins[]	= { GPIOZ_11 };
+static const unsigned int spi_mosi_1_pins[]	= { GPIOZ_12 };
+static const unsigned int spi_miso_1_pins[]	= { GPIOZ_13 };
+static const unsigned int spi_ss2_1_pins[]	= { GPIOZ_14 };
+
+static const unsigned int eth_tx_clk_50m_pins[]	= { GPIOZ_4 };
+static const unsigned int eth_tx_en_pins[]	= { GPIOZ_5 };
+static const unsigned int eth_txd1_pins[]	= { GPIOZ_6 };
+static const unsigned int eth_txd0_pins[]	= { GPIOZ_7 };
+static const unsigned int eth_rx_clk_in_pins[]	= { GPIOZ_8 };
+static const unsigned int eth_rx_dv_pins[]	= { GPIOZ_9 };
+static const unsigned int eth_rxd1_pins[]	= { GPIOZ_10 };
+static const unsigned int eth_rxd0_pins[]	= { GPIOZ_11 };
+static const unsigned int eth_mdio_pins[]	= { GPIOZ_12 };
+static const unsigned int eth_mdc_pins[]	= { GPIOZ_13 };
+
+static const unsigned int i2c_sda_a0_pins[]	= { GPIOZ_0 };
+static const unsigned int i2c_sck_a0_pins[]	= { GPIOZ_1 };
+
+static const unsigned int i2c_sda_b_pins[]	= { GPIOZ_2 };
+static const unsigned int i2c_sck_b_pins[]	= { GPIOZ_3 };
+
+static const unsigned int i2c_sda_c1_pins[]	= { GPIOZ_4 };
+static const unsigned int i2c_sck_c1_pins[]	= { GPIOZ_5 };
+
+static const unsigned int i2c_sda_a1_pins[]	= { GPIOZ_0 };
+static const unsigned int i2c_sck_a1_pins[]	= { GPIOZ_1 };
+
+static const unsigned int i2c_sda_a2_pins[]	= { GPIOZ_0 };
+static const unsigned int i2c_sck_a2_pins[]	= { GPIOZ_1 };
+
+static const unsigned int pwm_a_z0_pins[]	= { GPIOZ_0 };
+static const unsigned int pwm_a_z7_pins[]	= { GPIOZ_7 };
+static const unsigned int pwm_b_z_pins[]	= { GPIOZ_1 };
+static const unsigned int pwm_c_z_pins[]	= { GPIOZ_8 };
 
 /* bank BOOT */
-static const unsigned int sd_d0_c_pins[] = { PIN(BOOT_0, 0) };
-static const unsigned int sd_d1_c_pins[] = { PIN(BOOT_1, 0) };
-static const unsigned int sd_d2_c_pins[] = { PIN(BOOT_2, 0) };
-static const unsigned int sd_d3_c_pins[] = { PIN(BOOT_3, 0) };
-static const unsigned int sd_cmd_c_pins[] = { PIN(BOOT_16, 0) };
-static const unsigned int sd_clk_c_pins[] = { PIN(BOOT_17, 0) };
-
-static const unsigned int sdxc_d0_c_pins[] = { PIN(BOOT_0, 0)};
-static const unsigned int sdxc_d13_c_pins[] = { PIN(BOOT_1, 0), PIN(BOOT_2, 0),
-						PIN(BOOT_3, 0) };
-static const unsigned int sdxc_d47_c_pins[] = { PIN(BOOT_4, 0), PIN(BOOT_5, 0),
-						PIN(BOOT_6, 0), PIN(BOOT_7, 0) };
-static const unsigned int sdxc_cmd_c_pins[] = { PIN(BOOT_16, 0) };
-static const unsigned int sdxc_clk_c_pins[] = { PIN(BOOT_17, 0) };
-
-static const unsigned int nand_io_pins[] = { PIN(BOOT_0, 0), PIN(BOOT_1, 0),
-					     PIN(BOOT_2, 0), PIN(BOOT_3, 0),
-					     PIN(BOOT_4, 0), PIN(BOOT_5, 0),
-					     PIN(BOOT_6, 0), PIN(BOOT_7, 0) };
-static const unsigned int nand_io_ce0_pins[] = { PIN(BOOT_8, 0) };
-static const unsigned int nand_io_ce1_pins[] = { PIN(BOOT_9, 0) };
-static const unsigned int nand_io_rb0_pins[] = { PIN(BOOT_10, 0) };
-static const unsigned int nand_ale_pins[] = { PIN(BOOT_11, 0) };
-static const unsigned int nand_cle_pins[] = { PIN(BOOT_12, 0) };
-static const unsigned int nand_wen_clk_pins[] = { PIN(BOOT_13, 0) };
-static const unsigned int nand_ren_clk_pins[] = { PIN(BOOT_14, 0) };
-static const unsigned int nand_dqs_pins[] = { PIN(BOOT_15, 0) };
-static const unsigned int nand_ce2_pins[] = { PIN(BOOT_16, 0) };
-static const unsigned int nand_ce3_pins[] = { PIN(BOOT_17, 0) };
-
-static const unsigned int nor_d_pins[] = { PIN(BOOT_11, 0) };
-static const unsigned int nor_q_pins[] = { PIN(BOOT_12, 0) };
-static const unsigned int nor_c_pins[] = { PIN(BOOT_13, 0) };
-static const unsigned int nor_cs_pins[] = { PIN(BOOT_18, 0) };
+static const unsigned int sd_d0_c_pins[]	= { BOOT_0 };
+static const unsigned int sd_d1_c_pins[]	= { BOOT_1 };
+static const unsigned int sd_d2_c_pins[]	= { BOOT_2 };
+static const unsigned int sd_d3_c_pins[]	= { BOOT_3 };
+static const unsigned int sd_cmd_c_pins[]	= { BOOT_16 };
+static const unsigned int sd_clk_c_pins[]	= { BOOT_17 };
+
+static const unsigned int sdxc_d0_c_pins[]	= { BOOT_0};
+static const unsigned int sdxc_d13_c_pins[]	= { BOOT_1, BOOT_2, BOOT_3 };
+static const unsigned int sdxc_d47_c_pins[]	= { BOOT_4, BOOT_5, BOOT_6,
+						    BOOT_7 };
+static const unsigned int sdxc_cmd_c_pins[]	= { BOOT_16 };
+static const unsigned int sdxc_clk_c_pins[]	= { BOOT_17 };
+
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
+static const unsigned int nand_dqs_pins[]	= { BOOT_15 };
+static const unsigned int nand_ce2_pins[]	= { BOOT_16 };
+static const unsigned int nand_ce3_pins[]	= { BOOT_17 };
+
+static const unsigned int nor_d_pins[]		= { BOOT_11 };
+static const unsigned int nor_q_pins[]		= { BOOT_12 };
+static const unsigned int nor_c_pins[]		= { BOOT_13 };
+static const unsigned int nor_cs_pins[]		= { BOOT_18 };
 
 /* bank CARD */
-static const unsigned int sd_d1_b_pins[] = { PIN(CARD_0, 0) };
-static const unsigned int sd_d0_b_pins[] = { PIN(CARD_1, 0) };
-static const unsigned int sd_clk_b_pins[] = { PIN(CARD_2, 0) };
-static const unsigned int sd_cmd_b_pins[] = { PIN(CARD_3, 0) };
-static const unsigned int sd_d3_b_pins[] = { PIN(CARD_4, 0) };
-static const unsigned int sd_d2_b_pins[] = { PIN(CARD_5, 0) };
-
-static const unsigned int sdxc_d13_b_pins[] = { PIN(CARD_0, 0), PIN(CARD_4, 0),
-						PIN(CARD_5, 0) };
-static const unsigned int sdxc_d0_b_pins[] = { PIN(CARD_1, 0) };
-static const unsigned int sdxc_clk_b_pins[] = { PIN(CARD_2, 0) };
-static const unsigned int sdxc_cmd_b_pins[] = { PIN(CARD_3, 0) };
+static const unsigned int sd_d1_b_pins[]	= { CARD_0 };
+static const unsigned int sd_d0_b_pins[]	= { CARD_1 };
+static const unsigned int sd_clk_b_pins[]	= { CARD_2 };
+static const unsigned int sd_cmd_b_pins[]	= { CARD_3 };
+static const unsigned int sd_d3_b_pins[]	= { CARD_4 };
+static const unsigned int sd_d2_b_pins[]	= { CARD_5 };
+
+static const unsigned int sdxc_d13_b_pins[]	= { CARD_0, CARD_4, CARD_5 };
+static const unsigned int sdxc_d0_b_pins[]	= { CARD_1 };
+static const unsigned int sdxc_clk_b_pins[]	= { CARD_2 };
+static const unsigned int sdxc_cmd_b_pins[]	= { CARD_3 };
 
 /* bank AO */
-static const unsigned int uart_tx_ao_a_pins[] = { PIN(GPIOAO_0, AO_OFF) };
-static const unsigned int uart_rx_ao_a_pins[] = { PIN(GPIOAO_1, AO_OFF) };
-static const unsigned int uart_cts_ao_a_pins[] = { PIN(GPIOAO_2, AO_OFF) };
-static const unsigned int uart_rts_ao_a_pins[] = { PIN(GPIOAO_3, AO_OFF) };
+static const unsigned int uart_tx_ao_a_pins[]	= { GPIOAO_0 };
+static const unsigned int uart_rx_ao_a_pins[]	= { GPIOAO_1 };
+static const unsigned int uart_cts_ao_a_pins[]	= { GPIOAO_2 };
+static const unsigned int uart_rts_ao_a_pins[]	= { GPIOAO_3 };
 
-static const unsigned int remote_input_pins[] = { PIN(GPIOAO_7, AO_OFF) };
-static const unsigned int remote_output_ao_pins[] = { PIN(GPIOAO_13, AO_OFF) };
+static const unsigned int remote_input_pins[]	= { GPIOAO_7 };
+static const unsigned int remote_output_ao_pins[] = { GPIOAO_13 };
 
-static const unsigned int i2c_slave_sck_ao_pins[] = { PIN(GPIOAO_4, AO_OFF) };
-static const unsigned int i2c_slave_sda_ao_pins[] = { PIN(GPIOAO_5, AO_OFF) };
+static const unsigned int i2c_slave_sck_ao_pins[] = { GPIOAO_4 };
+static const unsigned int i2c_slave_sda_ao_pins[] = { GPIOAO_5 };
 
-static const unsigned int uart_tx_ao_b0_pins[] = { PIN(GPIOAO_0, AO_OFF) };
-static const unsigned int uart_rx_ao_b0_pins[] = { PIN(GPIOAO_1, AO_OFF) };
+static const unsigned int uart_tx_ao_b0_pins[]	= { GPIOAO_0 };
+static const unsigned int uart_rx_ao_b0_pins[]	= { GPIOAO_1 };
 
-static const unsigned int uart_tx_ao_b1_pins[] = { PIN(GPIOAO_4, AO_OFF) };
-static const unsigned int uart_rx_ao_b1_pins[] = { PIN(GPIOAO_5, AO_OFF) };
+static const unsigned int uart_tx_ao_b1_pins[]	= { GPIOAO_4 };
+static const unsigned int uart_rx_ao_b1_pins[]	= { GPIOAO_5 };
 
-static const unsigned int i2c_mst_sck_ao_pins[] = { PIN(GPIOAO_4, AO_OFF) };
-static const unsigned int i2c_mst_sda_ao_pins[] = { PIN(GPIOAO_5, AO_OFF) };
+static const unsigned int i2c_mst_sck_ao_pins[]	= { GPIOAO_4 };
+static const unsigned int i2c_mst_sda_ao_pins[]	= { GPIOAO_5 };
 
-static const unsigned int pwm_f_ao_pins[] = { PIN(GPIO_TEST_N, AO_OFF) };
+static const unsigned int pwm_f_ao_pins[]	= { GPIO_TEST_N };
 
-static const unsigned int i2s_am_clk_out_ao_pins[] = { PIN(GPIOAO_8, AO_OFF) };
-static const unsigned int i2s_ao_clk_out_ao_pins[] = { PIN(GPIOAO_9, AO_OFF) };
-static const unsigned int i2s_lr_clk_out_ao_pins[] = { PIN(GPIOAO_10, AO_OFF) };
-static const unsigned int i2s_out_ch01_ao_pins[] = { PIN(GPIOAO_11, AO_OFF) };
+static const unsigned int i2s_am_clk_out_ao_pins[] = { GPIOAO_8 };
+static const unsigned int i2s_ao_clk_out_ao_pins[] = { GPIOAO_9 };
+static const unsigned int i2s_lr_clk_out_ao_pins[] = { GPIOAO_10 };
+static const unsigned int i2s_out_ch01_ao_pins[] = { GPIOAO_11 };
 
-static const unsigned int hdmi_cec_ao_pins[] = { PIN(GPIOAO_12, AO_OFF) };
+static const unsigned int hdmi_cec_ao_pins[]	= { GPIOAO_12 };
 
 static struct meson_pmx_group meson8_cbus_groups[] = {
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
-	GPIO_GROUP(GPIOX_12, 0),
-	GPIO_GROUP(GPIOX_13, 0),
-	GPIO_GROUP(GPIOX_14, 0),
-	GPIO_GROUP(GPIOX_15, 0),
-	GPIO_GROUP(GPIOX_16, 0),
-	GPIO_GROUP(GPIOX_17, 0),
-	GPIO_GROUP(GPIOX_18, 0),
-	GPIO_GROUP(GPIOX_19, 0),
-	GPIO_GROUP(GPIOX_20, 0),
-	GPIO_GROUP(GPIOX_21, 0),
-	GPIO_GROUP(GPIOY_0, 0),
-	GPIO_GROUP(GPIOY_1, 0),
-	GPIO_GROUP(GPIOY_2, 0),
-	GPIO_GROUP(GPIOY_3, 0),
-	GPIO_GROUP(GPIOY_4, 0),
-	GPIO_GROUP(GPIOY_5, 0),
-	GPIO_GROUP(GPIOY_6, 0),
-	GPIO_GROUP(GPIOY_7, 0),
-	GPIO_GROUP(GPIOY_8, 0),
-	GPIO_GROUP(GPIOY_9, 0),
-	GPIO_GROUP(GPIOY_10, 0),
-	GPIO_GROUP(GPIOY_11, 0),
-	GPIO_GROUP(GPIOY_12, 0),
-	GPIO_GROUP(GPIOY_13, 0),
-	GPIO_GROUP(GPIOY_14, 0),
-	GPIO_GROUP(GPIOY_15, 0),
-	GPIO_GROUP(GPIOY_16, 0),
-	GPIO_GROUP(GPIODV_0, 0),
-	GPIO_GROUP(GPIODV_1, 0),
-	GPIO_GROUP(GPIODV_2, 0),
-	GPIO_GROUP(GPIODV_3, 0),
-	GPIO_GROUP(GPIODV_4, 0),
-	GPIO_GROUP(GPIODV_5, 0),
-	GPIO_GROUP(GPIODV_6, 0),
-	GPIO_GROUP(GPIODV_7, 0),
-	GPIO_GROUP(GPIODV_8, 0),
-	GPIO_GROUP(GPIODV_9, 0),
-	GPIO_GROUP(GPIODV_10, 0),
-	GPIO_GROUP(GPIODV_11, 0),
-	GPIO_GROUP(GPIODV_12, 0),
-	GPIO_GROUP(GPIODV_13, 0),
-	GPIO_GROUP(GPIODV_14, 0),
-	GPIO_GROUP(GPIODV_15, 0),
-	GPIO_GROUP(GPIODV_16, 0),
-	GPIO_GROUP(GPIODV_17, 0),
-	GPIO_GROUP(GPIODV_18, 0),
-	GPIO_GROUP(GPIODV_19, 0),
-	GPIO_GROUP(GPIODV_20, 0),
-	GPIO_GROUP(GPIODV_21, 0),
-	GPIO_GROUP(GPIODV_22, 0),
-	GPIO_GROUP(GPIODV_23, 0),
-	GPIO_GROUP(GPIODV_24, 0),
-	GPIO_GROUP(GPIODV_25, 0),
-	GPIO_GROUP(GPIODV_26, 0),
-	GPIO_GROUP(GPIODV_27, 0),
-	GPIO_GROUP(GPIODV_28, 0),
-	GPIO_GROUP(GPIODV_29, 0),
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
-	GPIO_GROUP(GPIOZ_0, 0),
-	GPIO_GROUP(GPIOZ_1, 0),
-	GPIO_GROUP(GPIOZ_2, 0),
-	GPIO_GROUP(GPIOZ_3, 0),
-	GPIO_GROUP(GPIOZ_4, 0),
-	GPIO_GROUP(GPIOZ_5, 0),
-	GPIO_GROUP(GPIOZ_6, 0),
-	GPIO_GROUP(GPIOZ_7, 0),
-	GPIO_GROUP(GPIOZ_8, 0),
-	GPIO_GROUP(GPIOZ_9, 0),
-	GPIO_GROUP(GPIOZ_10, 0),
-	GPIO_GROUP(GPIOZ_11, 0),
-	GPIO_GROUP(GPIOZ_12, 0),
-	GPIO_GROUP(GPIOZ_13, 0),
-	GPIO_GROUP(GPIOZ_14, 0),
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
+	GPIO_GROUP(GPIOX_19),
+	GPIO_GROUP(GPIOX_20),
+	GPIO_GROUP(GPIOX_21),
+	GPIO_GROUP(GPIOY_0),
+	GPIO_GROUP(GPIOY_1),
+	GPIO_GROUP(GPIOY_2),
+	GPIO_GROUP(GPIOY_3),
+	GPIO_GROUP(GPIOY_4),
+	GPIO_GROUP(GPIOY_5),
+	GPIO_GROUP(GPIOY_6),
+	GPIO_GROUP(GPIOY_7),
+	GPIO_GROUP(GPIOY_8),
+	GPIO_GROUP(GPIOY_9),
+	GPIO_GROUP(GPIOY_10),
+	GPIO_GROUP(GPIOY_11),
+	GPIO_GROUP(GPIOY_12),
+	GPIO_GROUP(GPIOY_13),
+	GPIO_GROUP(GPIOY_14),
+	GPIO_GROUP(GPIOY_15),
+	GPIO_GROUP(GPIOY_16),
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
+	GPIO_GROUP(GPIODV_18),
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
 
 	/* bank X */
 	GROUP(sd_d0_a,		8,	5),
@@ -727,22 +715,22 @@ static struct meson_pmx_group meson8_cbus_groups[] = {
 };
 
 static struct meson_pmx_group meson8_aobus_groups[] = {
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
 	GROUP(uart_tx_ao_a,		0,	12),
@@ -1041,19 +1029,19 @@ static struct meson_pmx_func meson8_aobus_functions[] = {
 };
 
 static struct meson_bank meson8_cbus_banks[] = {
-	/*   name    first             last                 irq       pullen  pull    dir     out     in  */
-	BANK("X",    PIN(GPIOX_0, 0),  PIN(GPIOX_21, 0),    112, 133, 4,  0,  4,  0,  0,  0,  1,  0,  2,  0),
-	BANK("Y",    PIN(GPIOY_0, 0),  PIN(GPIOY_16, 0),    95,  111, 3,  0,  3,  0,  3,  0,  4,  0,  5,  0),
-	BANK("DV",   PIN(GPIODV_0, 0), PIN(GPIODV_29, 0),   65,   94, 0,  0,  0,  0,  7,  0,  8,  0,  9,  0),
-	BANK("H",    PIN(GPIOH_0, 0),  PIN(GPIOH_9, 0),     29,   38, 1, 16,  1, 16,  9, 19, 10, 19, 11, 19),
-	BANK("Z",    PIN(GPIOZ_0, 0),  PIN(GPIOZ_14, 0),    14,   28, 1,  0,  1,  0,  3, 17,  4, 17,  5, 17),
-	BANK("CARD", PIN(CARD_0, 0),   PIN(CARD_6, 0),      58,   64, 2, 20,  2, 20,  0, 22,  1, 22,  2, 22),
-	BANK("BOOT", PIN(BOOT_0, 0),   PIN(BOOT_18, 0),     39,   57, 2,  0,  2,  0,  9,  0, 10,  0, 11,  0),
+	/*   name    first     last         irq       pullen  pull    dir     out     in  */
+	BANK("X",    GPIOX_0,  GPIOX_21,    112, 133, 4,  0,  4,  0,  0,  0,  1,  0,  2,  0),
+	BANK("Y",    GPIOY_0,  GPIOY_16,    95,  111, 3,  0,  3,  0,  3,  0,  4,  0,  5,  0),
+	BANK("DV",   GPIODV_0, GPIODV_29,   65,   94, 0,  0,  0,  0,  7,  0,  8,  0,  9,  0),
+	BANK("H",    GPIOH_0,  GPIOH_9,     29,   38, 1, 16,  1, 16,  9, 19, 10, 19, 11, 19),
+	BANK("Z",    GPIOZ_0,  GPIOZ_14,    14,   28, 1,  0,  1,  0,  3, 17,  4, 17,  5, 17),
+	BANK("CARD", CARD_0,   CARD_6,      58,   64, 2, 20,  2, 20,  0, 22,  1, 22,  2, 22),
+	BANK("BOOT", BOOT_0,   BOOT_18,     39,   57, 2,  0,  2,  0,  9,  0, 10,  0, 11,  0),
 };
 
 static struct meson_bank meson8_aobus_banks[] = {
-	/*   name    first                  last                      irq    pullen  pull    dir     out     in  */
-	BANK("AO",   PIN(GPIOAO_0, AO_OFF), PIN(GPIO_TEST_N, AO_OFF), 0, 13, 0,  0,  0, 16,  0,  0,  0, 16,  1,  0),
+	/*   name    first     last         irq    pullen  pull    dir     out     in  */
+	BANK("AO",   GPIOAO_0, GPIO_TEST_N, 0, 13, 0,  0,  0, 16,  0,  0,  0, 16,  1,  0),
 };
 
 struct meson_pinctrl_data meson8_cbus_pinctrl_data = {
@@ -1071,7 +1059,7 @@ struct meson_pinctrl_data meson8_cbus_pinctrl_data = {
 
 struct meson_pinctrl_data meson8_aobus_pinctrl_data = {
 	.name		= "ao-bank",
-	.pin_base	= 120,
+	.pin_base	= 0,
 	.pins		= meson8_aobus_pins,
 	.groups		= meson8_aobus_groups,
 	.funcs		= meson8_aobus_functions,
-- 
2.13.5
