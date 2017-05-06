From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Sat,  6 May 2017 18:57:50 +0200
Subject: [PATCH v2 3/4] pinctrl: meson: meson8: add support for the AO remote
 output pin
In-Reply-To: <20170506165751.12442-1-martin.blumenstingl@googlemail.com>
References: <20170504184932.5372-1-martin.blumenstingl@googlemail.com>
 <20170506165751.12442-1-martin.blumenstingl@googlemail.com>
Message-ID: <20170506165751.12442-4-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds another missing pin found in the Meson8 SoCs. Currently
there's no driver which would use this pin yet.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/pinctrl/meson/pinctrl-meson8.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/meson/pinctrl-meson8.c b/drivers/pinctrl/meson/pinctrl-meson8.c
index 6e36a9602999..2716d991af8c 100644
--- a/drivers/pinctrl/meson/pinctrl-meson8.c
+++ b/drivers/pinctrl/meson/pinctrl-meson8.c
@@ -395,6 +395,7 @@ static const unsigned int uart_cts_ao_a_pins[] = { PIN(GPIOAO_2, AO_OFF) };
 static const unsigned int uart_rts_ao_a_pins[] = { PIN(GPIOAO_3, AO_OFF) };
 
 static const unsigned int remote_input_pins[] = { PIN(GPIOAO_7, AO_OFF) };
+static const unsigned int remote_output_ao_pins[] = { PIN(GPIOAO_13, AO_OFF) };
 
 static const unsigned int i2c_slave_sck_ao_pins[] = { PIN(GPIOAO_4, AO_OFF) };
 static const unsigned int i2c_slave_sda_ao_pins[] = { PIN(GPIOAO_5, AO_OFF) };
@@ -748,6 +749,7 @@ static struct meson_pmx_group meson8_aobus_groups[] = {
 	GROUP(uart_rts_ao_a,		0,	9),
 
 	GROUP(remote_input,		0,	0),
+	GROUP(remote_output_ao,		0,	31),
 
 	GROUP(i2c_slave_sck_ao,		0,	2),
 	GROUP(i2c_slave_sda_ao,		0,	1),
@@ -959,7 +961,7 @@ static const char * const uart_ao_groups[] = {
 };
 
 static const char * const remote_groups[] = {
-	"remote_input"
+	"remote_input", "remote_output_ao"
 };
 
 static const char * const i2c_slave_ao_groups[] = {
-- 
2.12.2
