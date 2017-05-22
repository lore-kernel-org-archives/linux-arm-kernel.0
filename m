From: narmstrong@baylibre.com (Neil Armstrong)
Date: Mon, 22 May 2017 14:59:26 +0200
Subject: [PATCH 2/2] pinctrl: meson-gxbb: Add SPI pins for SPICC controller
In-Reply-To: <1495457966-2359-1-git-send-email-narmstrong@baylibre.com>
References: <1495457966-2359-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1495457966-2359-3-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The SPICC controller has dedicated SPI pins, this patchs add the pins
definition in the GXBB pinctrl driver

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/pinctrl/meson/pinctrl-meson-gxbb.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/pinctrl/meson/pinctrl-meson-gxbb.c b/drivers/pinctrl/meson/pinctrl-meson-gxbb.c
index 9b00be1..3ccb0f4f 100644
--- a/drivers/pinctrl/meson/pinctrl-meson-gxbb.c
+++ b/drivers/pinctrl/meson/pinctrl-meson-gxbb.c
@@ -161,6 +161,11 @@
 static const unsigned int nor_c_pins[]		= { PIN(BOOT_13, EE_OFF) };
 static const unsigned int nor_cs_pins[]		= { PIN(BOOT_15, EE_OFF) };
 
+static const unsigned int spi_sclk_pins[]	= { PIN(GPIOZ_6, EE_OFF) };
+static const unsigned int spi_ss0_pins[]	= { PIN(GPIOZ_7, EE_OFF) };
+static const unsigned int spi_miso_pins[]	= { PIN(GPIOZ_12, EE_OFF) };
+static const unsigned int spi_mosi_pins[]	= { PIN(GPIOZ_13, EE_OFF) };
+
 static const unsigned int sdcard_d0_pins[] = { PIN(CARD_1, EE_OFF) };
 static const unsigned int sdcard_d1_pins[] = { PIN(CARD_0, EE_OFF) };
 static const unsigned int sdcard_d2_pins[] = { PIN(CARD_5, EE_OFF) };
@@ -462,6 +467,10 @@
 	GROUP(eth_txd1,		6,	4),
 	GROUP(eth_txd2,		6,	3),
 	GROUP(eth_txd3,		6,	2),
+	GROUP(spi_ss0,		5,	26),
+	GROUP(spi_sclk,		5,	27),
+	GROUP(spi_miso,		5,	28),
+	GROUP(spi_mosi,		5,	29),
 
 	/* Bank H */
 	GROUP(hdmi_hpd,		1,	26),
@@ -598,6 +607,10 @@
 	"nor_d", "nor_q", "nor_c", "nor_cs",
 };
 
+static const char * const spi_groups[] = {
+	"spi_mosi", "spi_miso", "spi_ss0", "spi_sclk",
+};
+
 static const char * const sdcard_groups[] = {
 	"sdcard_d0", "sdcard_d1", "sdcard_d2", "sdcard_d3",
 	"sdcard_cmd", "sdcard_clk",
@@ -743,6 +756,7 @@
 	FUNCTION(gpio_periphs),
 	FUNCTION(emmc),
 	FUNCTION(nor),
+	FUNCTION(spi),
 	FUNCTION(sdcard),
 	FUNCTION(sdio),
 	FUNCTION(nand),
-- 
1.9.1
