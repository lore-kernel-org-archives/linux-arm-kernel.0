From: wens@csie.org (Chen-Yu Tsai)
Date: Wed,  1 Jan 2014 10:30:49 +0800
Subject: [PATCH v3 4/5] pinctrl: sunxi: Add Allwinner A20 clock output pin
 functions
In-Reply-To: <1388543450-16741-1-git-send-email-wens@csie.org>
References: <1388543450-16741-1-git-send-email-wens@csie.org>
Message-ID: <1388543450-16741-5-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the clock output pin functions on the A20.
The 2 pins can output a configurable clock to be used by
external modules. This is used on the CubieTruck, to supply
a 32768 Hz low power clock to the onboard Wifi+BT module.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/pinctrl/pinctrl-sunxi-pins.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pinctrl/pinctrl-sunxi-pins.h b/drivers/pinctrl/pinctrl-sunxi-pins.h
index 2c7446a..6fd8d4d 100644
--- a/drivers/pinctrl/pinctrl-sunxi-pins.h
+++ b/drivers/pinctrl/pinctrl-sunxi-pins.h
@@ -3774,12 +3774,14 @@ static const struct sunxi_desc_pin sun7i_a20_pins[] = {
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "spi0"),		/* MOSI */
 		  SUNXI_FUNCTION(0x3, "uart6"),		/* TX */
+		  SUNXI_FUNCTION(0x4, "clk_out_a"),	/* CLK_OUT_A */
 		  SUNXI_FUNCTION_IRQ(0x5, 24)),		/* EINT24 */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN_PI13,
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "spi0"),		/* MISO */
 		  SUNXI_FUNCTION(0x3, "uart6"),		/* RX */
+		  SUNXI_FUNCTION(0x4, "clk_out_b"),	/* CLK_OUT_B */
 		  SUNXI_FUNCTION_IRQ(0x5, 25)),		/* EINT25 */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN_PI14,
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
-- 
1.8.5.2
