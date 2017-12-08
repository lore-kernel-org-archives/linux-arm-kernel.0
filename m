From: yixun.lan@amlogic.com (Yixun Lan)
Date: Fri, 8 Dec 2017 23:29:09 +0800
Subject: [PATCH] pinctrl: meson-axg: adjust spicc pin naming
Message-ID: <20171208152909.15632-1-yixun.lan@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to datasheet, we should use numbers for the pin naming
instead of letters. The patch here try to fix this to keep
the consistency.

This patch should not bring any functional change.

Fixes: 83c566806a68 ("pinctrl: meson-axg: Add new pinctrl driver for Meson AXG SoC")
Suggested-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>

---
The issue was raised by Kevin while review the SPI DT part patches, see [1]
[1] http://lists.infradead.org/pipermail/linux-amlogic/2017-December/005641.html

Note: the 'Fixes' is coming from pinctrl's tree 'for-next' branch
---
 drivers/pinctrl/meson/pinctrl-meson-axg.c | 86 +++++++++++++++----------------
 1 file changed, 43 insertions(+), 43 deletions(-)

diff --git a/drivers/pinctrl/meson/pinctrl-meson-axg.c b/drivers/pinctrl/meson/pinctrl-meson-axg.c
index a1a7d42afd42..1fda9d6c7ea3 100644
--- a/drivers/pinctrl/meson/pinctrl-meson-axg.c
+++ b/drivers/pinctrl/meson/pinctrl-meson-axg.c
@@ -156,25 +156,25 @@ static const unsigned int sdio_d3_pins[] = {GPIOX_3};
 static const unsigned int sdio_clk_pins[] = {GPIOX_4};
 static const unsigned int sdio_cmd_pins[] = {GPIOX_5};
 
-/* spi_a */
-static const unsigned int spi_clk_a_pins[] = {GPIOZ_0};
-static const unsigned int spi_mosi_a_pins[] = {GPIOZ_1};
-static const unsigned int spi_miso_a_pins[] = {GPIOZ_2};
-static const unsigned int spi_ss0_a_pins[] = {GPIOZ_3};
-static const unsigned int spi_ss1_a_pins[] = {GPIOZ_4};
-static const unsigned int spi_ss2_a_pins[] = {GPIOZ_5};
-
-/* spi_b */
-static const unsigned int spi_clk_b_x_pins[] = {GPIOX_19};
-static const unsigned int spi_mosi_b_x_pins[] = {GPIOX_17};
-static const unsigned int spi_miso_b_x_pins[] = {GPIOX_18};
-static const unsigned int spi_ss0_b_x_pins[] = {GPIOX_16};
-
-static const unsigned int spi_clk_b_a_pins[] = {GPIOA_4};
-static const unsigned int spi_mosi_b_a_pins[] = {GPIOA_2};
-static const unsigned int spi_miso_b_a_pins[] = {GPIOA_3};
-static const unsigned int spi_ss0_b_a_pins[] = {GPIOA_5};
-static const unsigned int spi_ss1_b_pins[] = {GPIOA_6};
+/* spi0 */
+static const unsigned int spi0_clk_pins[] = {GPIOZ_0};
+static const unsigned int spi0_mosi_pins[] = {GPIOZ_1};
+static const unsigned int spi0_miso_pins[] = {GPIOZ_2};
+static const unsigned int spi0_ss0_pins[] = {GPIOZ_3};
+static const unsigned int spi0_ss1_pins[] = {GPIOZ_4};
+static const unsigned int spi0_ss2_pins[] = {GPIOZ_5};
+
+/* spi1 */
+static const unsigned int spi1_clk_x_pins[] = {GPIOX_19};
+static const unsigned int spi1_mosi_x_pins[] = {GPIOX_17};
+static const unsigned int spi1_miso_x_pins[] = {GPIOX_18};
+static const unsigned int spi1_ss0_x_pins[] = {GPIOX_16};
+
+static const unsigned int spi1_clk_a_pins[] = {GPIOA_4};
+static const unsigned int spi1_mosi_a_pins[] = {GPIOA_2};
+static const unsigned int spi1_miso_a_pins[] = {GPIOA_3};
+static const unsigned int spi1_ss0_a_pins[] = {GPIOA_5};
+static const unsigned int spi1_ss1_pins[] = {GPIOA_6};
 
 /* i2c0 */
 static const unsigned int i2c0_sck_pins[] = {GPIOZ_6};
@@ -429,12 +429,12 @@ static struct meson_pmx_group meson_axg_periphs_groups[] = {
 	GROUP(nor_cs, 3),
 
 	/* bank GPIOZ */
-	GROUP(spi_clk_a, 1),
-	GROUP(spi_mosi_a, 1),
-	GROUP(spi_miso_a, 1),
-	GROUP(spi_ss0_a, 1),
-	GROUP(spi_ss1_a, 1),
-	GROUP(spi_ss2_a, 1),
+	GROUP(spi0_clk, 1),
+	GROUP(spi0_mosi, 1),
+	GROUP(spi0_miso, 1),
+	GROUP(spi0_ss0, 1),
+	GROUP(spi0_ss1, 1),
+	GROUP(spi0_ss2, 1),
 	GROUP(i2c0_sck, 1),
 	GROUP(i2c0_sda, 1),
 	GROUP(i2c1_sck_z, 1),
@@ -475,10 +475,10 @@ static struct meson_pmx_group meson_axg_periphs_groups[] = {
 	GROUP(jtag_tdi_x, 2),
 	GROUP(jtag_clk_x, 2),
 	GROUP(jtag_tms_x, 2),
-	GROUP(spi_clk_b_x, 4),
-	GROUP(spi_mosi_b_x, 4),
-	GROUP(spi_miso_b_x, 4),
-	GROUP(spi_ss0_b_x, 4),
+	GROUP(spi1_clk_x, 4),
+	GROUP(spi1_mosi_x, 4),
+	GROUP(spi1_miso_x, 4),
+	GROUP(spi1_ss0_x, 4),
 	GROUP(pwm_a_x18, 3),
 	GROUP(pwm_a_x20, 1),
 	GROUP(pwm_b_x, 3),
@@ -521,11 +521,11 @@ static struct meson_pmx_group meson_axg_periphs_groups[] = {
 	GROUP(spdif_in_a7, 3),
 	GROUP(spdif_in_a19, 1),
 	GROUP(spdif_in_a20, 2),
-	GROUP(spi_clk_b_a, 3),
-	GROUP(spi_mosi_b_a, 3),
-	GROUP(spi_miso_b_a, 3),
-	GROUP(spi_ss0_b_a, 3),
-	GROUP(spi_ss1_b, 3),
+	GROUP(spi1_clk_a, 3),
+	GROUP(spi1_mosi_a, 3),
+	GROUP(spi1_miso_a, 3),
+	GROUP(spi1_ss0_a, 3),
+	GROUP(spi1_ss1, 3),
 	GROUP(pwm_a_a, 3),
 	GROUP(pwm_b_a, 3),
 	GROUP(pwm_c_a, 3),
@@ -696,15 +696,15 @@ static const char * const sdio_groups[] = {
 	"sdio_cmd", "sdio_clk",
 };
 
-static const char * const spi_a_groups[] = {
-	"spi_clk_a", "spi_mosi_a", "spi_miso_a", "spi_ss0_a",
-	"spi_ss1_a", "spi_ss2_a"
+static const char * const spi0_groups[] = {
+	"spi0_clk", "spi0_mosi", "spi0_miso", "spi0_ss0",
+	"spi0_ss1", "spi0_ss2"
 };
 
-static const char * const spi_b_groups[] = {
-	"spi_clk_b_x", "spi_mosi_b_x", "spi_miso_b_x", "spi_ss0_b_x",
-	"spi_clk_b_a", "spi_mosi_b_a", "spi_miso_b_a", "spi_ss0_b_a",
-	"spi_ss1_b"
+static const char * const spi1_groups[] = {
+	"spi1_clk_x", "spi1_mosi_x", "spi1_miso_x", "spi1_ss0_x",
+	"spi1_clk_a", "spi1_mosi_a", "spi1_miso_a", "spi1_ss0_a",
+	"spi1_ss1"
 };
 
 static const char * const uart_a_groups[] = {
@@ -849,8 +849,8 @@ static struct meson_pmx_func meson_axg_periphs_functions[] = {
 	FUNCTION(gpio_periphs),
 	FUNCTION(emmc),
 	FUNCTION(nor),
-	FUNCTION(spi_a),
-	FUNCTION(spi_b),
+	FUNCTION(spi0),
+	FUNCTION(spi1),
 	FUNCTION(sdio),
 	FUNCTION(nand),
 	FUNCTION(uart_a),
-- 
2.15.1
