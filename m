From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Sun, 22 Jan 2017 22:05:27 +0100
Subject: [PATCH 2/3] pinctrl: meson: meson-gxl: add the pwm_ao_b pin
In-Reply-To: <20170122210528.892-1-martin.blumenstingl@googlemail.com>
References: <20170122210528.892-1-martin.blumenstingl@googlemail.com>
Message-ID: <20170122210528.892-3-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds support for the pwm_ao_b pin. Unfortunately the registers for
the pwm_ao pins are not documented at all. The source for the pwm_ao_b
pin from this patch is the Khadas VIM GPL kernel source, which sets bit
3 and unsets bits 4 and 31 to enable the PWM LEDs.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/pinctrl/meson/pinctrl-meson-gxl.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pinctrl/meson/pinctrl-meson-gxl.c b/drivers/pinctrl/meson/pinctrl-meson-gxl.c
index 25694f7094c7..6ff321a7366d 100644
--- a/drivers/pinctrl/meson/pinctrl-meson-gxl.c
+++ b/drivers/pinctrl/meson/pinctrl-meson-gxl.c
@@ -222,6 +222,8 @@ static const unsigned int uart_rts_ao_b_pins[]	= { PIN(GPIOAO_3, 0) };
 
 static const unsigned int remote_input_ao_pins[] = {PIN(GPIOAO_7, 0) };
 
+static const unsigned int pwm_ao_b_pins[]	= { PIN(GPIOAO_9, 0) };
+
 static struct meson_pmx_group meson_gxl_periphs_groups[] = {
 	GPIO_GROUP(GPIOZ_0, EE_OFF),
 	GPIO_GROUP(GPIOZ_1, EE_OFF),
@@ -418,6 +420,7 @@ static struct meson_pmx_group meson_gxl_aobus_groups[] = {
 	GROUP(uart_cts_ao_b,	0,	8),
 	GROUP(uart_rts_ao_b,	0,	7),
 	GROUP(remote_input_ao,	0,	0),
+	GROUP(pwm_ao_b,		0,	3),
 };
 
 static const char * const gpio_periphs_groups[] = {
@@ -523,6 +526,10 @@ static const char * const remote_input_ao_groups[] = {
 	"remote_input_ao",
 };
 
+static const char * const pwm_ao_b_groups[] = {
+	"pwm_ao_b",
+};
+
 static struct meson_pmx_func meson_gxl_periphs_functions[] = {
 	FUNCTION(gpio_periphs),
 	FUNCTION(emmc),
@@ -544,6 +551,7 @@ static struct meson_pmx_func meson_gxl_aobus_functions[] = {
 	FUNCTION(uart_ao),
 	FUNCTION(uart_ao_b),
 	FUNCTION(remote_input_ao),
+	FUNCTION(pwm_ao_b),
 };
 
 static struct meson_bank meson_gxl_periphs_banks[] = {
-- 
2.11.0
