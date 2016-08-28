From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Sun, 28 Aug 2016 18:47:24 +0200
Subject: [PATCH 1/2] pinctrl: meson-gxbb: add the pins for the SDIO/sd_emmc_a
 controller
In-Reply-To: <20160828164725.19429-1-martin.blumenstingl@googlemail.com>
References: <20160828164725.19429-1-martin.blumenstingl@googlemail.com>
Message-ID: <20160828164725.19429-2-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

sd_emmc_a is used a controller for the SDIO modules. This adds the pin
configuration for the SDIO controller.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/pinctrl/meson/pinctrl-meson-gxbb.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/pinctrl/meson/pinctrl-meson-gxbb.c b/drivers/pinctrl/meson/pinctrl-meson-gxbb.c
index 77da6dd..fb479b8 100644
--- a/drivers/pinctrl/meson/pinctrl-meson-gxbb.c
+++ b/drivers/pinctrl/meson/pinctrl-meson-gxbb.c
@@ -163,6 +163,13 @@ static const unsigned int sdcard_d3_pins[] = { PIN(CARD_4, EE_OFF) };
 static const unsigned int sdcard_cmd_pins[] = { PIN(CARD_3, EE_OFF) };
 static const unsigned int sdcard_clk_pins[] = { PIN(CARD_2, EE_OFF) };
 
+static const unsigned int sdio_d0_pins[] = { PIN(GPIOX_0, EE_OFF) };
+static const unsigned int sdio_d1_pins[] = { PIN(GPIOX_1, EE_OFF) };
+static const unsigned int sdio_d2_pins[] = { PIN(GPIOX_2, EE_OFF) };
+static const unsigned int sdio_d3_pins[] = { PIN(GPIOX_3, EE_OFF) };
+static const unsigned int sdio_cmd_pins[] = { PIN(GPIOX_4, EE_OFF) };
+static const unsigned int sdio_clk_pins[] = { PIN(GPIOX_5, EE_OFF) };
+
 static const unsigned int uart_tx_a_pins[]	= { PIN(GPIOX_12, EE_OFF) };
 static const unsigned int uart_rx_a_pins[]	= { PIN(GPIOX_13, EE_OFF) };
 static const unsigned int uart_cts_a_pins[]	= { PIN(GPIOX_14, EE_OFF) };
@@ -370,6 +377,12 @@ static struct meson_pmx_group meson_gxbb_periphs_groups[] = {
 	GPIO_GROUP(GPIO_TEST_N, EE_OFF),
 
 	/* Bank X */
+	GROUP(sdio_d0,		8,	5),
+	GROUP(sdio_d1,		8,	4),
+	GROUP(sdio_d2,		8,	3),
+	GROUP(sdio_d3,		8,	2),
+	GROUP(sdio_cmd,		8,	1),
+	GROUP(sdio_clk,		8,	0),
 	GROUP(uart_tx_a,	4,	13),
 	GROUP(uart_rx_a,	4,	12),
 	GROUP(uart_cts_a,	4,	11),
@@ -507,6 +520,11 @@ static const char * const sdcard_groups[] = {
 	"sdcard_cmd", "sdcard_clk",
 };
 
+static const char * const sdio_groups[] = {
+	"sdio_d0", "sdio_d1", "sdio_d2", "sdio_d3",
+	"sdio_cmd", "sdio_clk",
+};
+
 static const char * const uart_a_groups[] = {
 	"uart_tx_a", "uart_rx_a", "uart_cts_a", "uart_rts_a",
 };
@@ -600,6 +618,7 @@ static struct meson_pmx_func meson_gxbb_periphs_functions[] = {
 	FUNCTION(gpio_periphs),
 	FUNCTION(emmc),
 	FUNCTION(sdcard),
+	FUNCTION(sdio),
 	FUNCTION(uart_a),
 	FUNCTION(uart_b),
 	FUNCTION(uart_c),
-- 
2.9.3
