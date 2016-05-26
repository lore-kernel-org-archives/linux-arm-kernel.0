From: khilman@baylibre.com (Kevin Hilman)
Date: Thu, 26 May 2016 14:24:22 -0700
Subject: [PATCH v2 1/4] pinctrl: amlogic: gxbb: add UART_AO_B, I2C
In-Reply-To: <1464297865-8965-1-git-send-email-khilman@baylibre.com>
References: <1464297865-8965-1-git-send-email-khilman@baylibre.com>
Message-ID: <1464297865-8965-2-git-send-email-khilman@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add pins for some more AO domain devices: UART_AO_B and I2C master &
slave.

Acked-by: Carlo Caione <carlo@endlessm.com>
Signed-off-by: Kevin Hilman <khilman@baylibre.com>
---
 drivers/pinctrl/meson/pinctrl-meson-gxbb.c | 35 +++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/meson/pinctrl-meson-gxbb.c b/drivers/pinctrl/meson/pinctrl-meson-gxbb.c
index eeabafbbf598..a188d9dae0f2 100644
--- a/drivers/pinctrl/meson/pinctrl-meson-gxbb.c
+++ b/drivers/pinctrl/meson/pinctrl-meson-gxbb.c
@@ -168,6 +168,16 @@ static const unsigned int uart_tx_ao_a_pins[]	= { PIN(GPIOAO_0, 0) };
 static const unsigned int uart_rx_ao_a_pins[]	= { PIN(GPIOAO_1, 0) };
 static const unsigned int uart_cts_ao_a_pins[]	= { PIN(GPIOAO_2, 0) };
 static const unsigned int uart_rts_ao_a_pins[]	= { PIN(GPIOAO_3, 0) };
+static const unsigned int uart_tx_ao_b_pins[]	= { PIN(GPIOAO_0, 0) };
+static const unsigned int uart_rx_ao_b_pins[]	= { PIN(GPIOAO_1, 0),
+						    PIN(GPIOAO_5, 0) };
+static const unsigned int uart_cts_ao_b_pins[]	= { PIN(GPIOAO_2, 0) };
+static const unsigned int uart_rts_ao_b_pins[]	= { PIN(GPIOAO_3, 0) };
+
+static const unsigned int i2c_sck_ao_pins[] = {PIN(GPIOAO_4, 0) };
+static const unsigned int i2c_sda_ao_pins[] = {PIN(GPIOAO_5, 0) };
+static const unsigned int i2c_slave_sck_ao_pins[] = {PIN(GPIOAO_4, 0) };
+static const unsigned int i2c_slave_sda_ao_pins[] = {PIN(GPIOAO_5, 0) };
 
 static struct meson_pmx_group meson_gxbb_periphs_groups[] = {
 	GPIO_GROUP(GPIOZ_0, EE_OFF),
@@ -316,10 +326,18 @@ static struct meson_pmx_group meson_gxbb_aobus_groups[] = {
 	GPIO_GROUP(GPIOAO_13, 0),
 
 	/* bank AO */
+	GROUP(uart_tx_ao_b,	0,	26),
+	GROUP(uart_rx_ao_b,	0,	25),
 	GROUP(uart_tx_ao_a,	0,	12),
 	GROUP(uart_rx_ao_a,	0,	11),
 	GROUP(uart_cts_ao_a,	0,	10),
 	GROUP(uart_rts_ao_a,	0,	9),
+	GROUP(uart_cts_ao_b,	0,	8),
+	GROUP(uart_rts_ao_b,	0,	7),
+	GROUP(i2c_sck_ao,	0,	6),
+	GROUP(i2c_sda_ao,	0,	5),
+	GROUP(i2c_slave_sck_ao, 0,	2),
+	GROUP(i2c_slave_sda_ao, 0,	1),
 };
 
 static const char * const gpio_periphs_groups[] = {
@@ -366,7 +384,19 @@ static const char * const gpio_aobus_groups[] = {
 };
 
 static const char * const uart_ao_groups[] = {
-	"uart_tx_ao_a", "uart_rx_ao_a", "uart_cts_ao_a", "uart_rts_ao_a"
+	"uart_tx_ao_a", "uart_rx_ao_a", "uart_cts_ao_a", "uart_rts_ao_a",
+};
+
+static const char * const uart_ao_b_groups[] = {
+	"uart_tx_ao_b", "uart_rx_ao_b", "uart_cts_ao_b", "uart_rts_ao_b",
+};
+
+static const char * const i2c_ao_groups[] = {
+	"i2c_sdk_ao", "i2c_sda_ao",
+};
+
+static const char * const i2c_slave_ao_groups[] = {
+	"i2c_slave_sdk_ao", "i2c_slave_sda_ao",
 };
 
 static struct meson_pmx_func meson_gxbb_periphs_functions[] = {
@@ -376,6 +406,9 @@ static struct meson_pmx_func meson_gxbb_periphs_functions[] = {
 static struct meson_pmx_func meson_gxbb_aobus_functions[] = {
 	FUNCTION(gpio_aobus),
 	FUNCTION(uart_ao),
+	FUNCTION(uart_ao_b),
+	FUNCTION(i2c_ao),
+	FUNCTION(i2c_slave_ao),
 };
 
 static struct meson_bank meson_gxbb_periphs_banks[] = {
-- 
2.7.4
