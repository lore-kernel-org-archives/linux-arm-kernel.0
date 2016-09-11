From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Sun, 11 Sep 2016 14:39:02 +0200
Subject: [PATCH v2 1/2] pinctrl: meson-gxbb: add the missing SDIO interrupt pin
In-Reply-To: <20160911123903.20027-1-martin.blumenstingl@googlemail.com>
References: <20160828164725.19429-1-martin.blumenstingl@googlemail.com>
 <20160911123903.20027-1-martin.blumenstingl@googlemail.com>
Message-ID: <20160911123903.20027-2-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the SDIO interrupt pin which can be used by sd_emmc_a.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Suggested-by: Neil Armstrong <narmstrong@baylibre.com>

Fixes: 29885a656511 ("pinctrl: meson-gxbb: add the pins for the
SDIO/sd_emmc_a controller")
---
 drivers/pinctrl/meson/pinctrl-meson-gxbb.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/meson/pinctrl-meson-gxbb.c b/drivers/pinctrl/meson/pinctrl-meson-gxbb.c
index fb479b8..4a27ae0 100644
--- a/drivers/pinctrl/meson/pinctrl-meson-gxbb.c
+++ b/drivers/pinctrl/meson/pinctrl-meson-gxbb.c
@@ -169,6 +169,7 @@ static const unsigned int sdio_d2_pins[] = { PIN(GPIOX_2, EE_OFF) };
 static const unsigned int sdio_d3_pins[] = { PIN(GPIOX_3, EE_OFF) };
 static const unsigned int sdio_cmd_pins[] = { PIN(GPIOX_4, EE_OFF) };
 static const unsigned int sdio_clk_pins[] = { PIN(GPIOX_5, EE_OFF) };
+static const unsigned int sdio_irq_pins[] = { PIN(GPIOX_7, EE_OFF) };
 
 static const unsigned int uart_tx_a_pins[]	= { PIN(GPIOX_12, EE_OFF) };
 static const unsigned int uart_rx_a_pins[]	= { PIN(GPIOX_13, EE_OFF) };
@@ -383,6 +384,7 @@ static struct meson_pmx_group meson_gxbb_periphs_groups[] = {
 	GROUP(sdio_d3,		8,	2),
 	GROUP(sdio_cmd,		8,	1),
 	GROUP(sdio_clk,		8,	0),
+	GROUP(sdio_irq,		8,	11),
 	GROUP(uart_tx_a,	4,	13),
 	GROUP(uart_rx_a,	4,	12),
 	GROUP(uart_cts_a,	4,	11),
@@ -522,7 +524,7 @@ static const char * const sdcard_groups[] = {
 
 static const char * const sdio_groups[] = {
 	"sdio_d0", "sdio_d1", "sdio_d2", "sdio_d3",
-	"sdio_cmd", "sdio_clk",
+	"sdio_cmd", "sdio_clk", "sdio_irq",
 };
 
 static const char * const uart_a_groups[] = {
-- 
2.9.3
