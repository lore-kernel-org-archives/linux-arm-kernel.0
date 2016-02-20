From: draakje197@gmail.com (hp197)
Date: Sat, 20 Feb 2016 22:28:25 +0100
Subject: [PATCH] Fix sun7i pin assignment for IRQ's
Message-ID: <1456003710-14807-1-git-send-email-henry@nitronetworks.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

IRQ pins are now according this page: http://linux-sunxi.org/A20/PIO

Signed-off-by: hp197 <henry@nitronetworks.nl>
---
 drivers/pinctrl/sunxi/pinctrl-sun7i-a20.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/pinctrl/sunxi/pinctrl-sun7i-a20.c b/drivers/pinctrl/sunxi/pinctrl-sun7i-a20.c
index cf1ce0c..4db5e19 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sun7i-a20.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sun7i-a20.c
@@ -344,25 +344,21 @@ static const struct sunxi_desc_pin sun7i_a20_pins[] = {
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "nand0"),		/* NCE4 */
 		  SUNXI_FUNCTION(0x3, "spi2"),		/* CS0 */
-		  SUNXI_FUNCTION_IRQ(0x6, 12)),		/* EINT12 */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 20),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "nand0"),		/* NCE5 */
 		  SUNXI_FUNCTION(0x3, "spi2"),		/* CLK */
-		  SUNXI_FUNCTION_IRQ(0x6, 13)),		/* EINT13 */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 21),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "nand0"),		/* NCE6 */
 		  SUNXI_FUNCTION(0x3, "spi2"),		/* MOSI */
-		  SUNXI_FUNCTION_IRQ(0x6, 14)),		/* EINT14 */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 22),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "nand0"),		/* NCE7 */
 		  SUNXI_FUNCTION(0x3, "spi2"),		/* MISO */
-		  SUNXI_FUNCTION_IRQ(0x6, 15)),		/* EINT15 */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 23),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
@@ -960,65 +956,55 @@ static const struct sunxi_desc_pin sun7i_a20_pins[] = {
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "spi0"),		/* CS0 */
 		  SUNXI_FUNCTION(0x3, "uart5"),		/* TX */
-		  SUNXI_FUNCTION_IRQ(0x5, 22)),		/* EINT22 */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(I, 11),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "spi0"),		/* CLK */
 		  SUNXI_FUNCTION(0x3, "uart5"),		/* RX */
-		  SUNXI_FUNCTION_IRQ(0x5, 23)),		/* EINT23 */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(I, 12),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "spi0"),		/* MOSI */
 		  SUNXI_FUNCTION(0x3, "uart6"),		/* TX */
 		  SUNXI_FUNCTION(0x4, "clk_out_a"),	/* CLK_OUT_A */
-		  SUNXI_FUNCTION_IRQ(0x5, 24)),		/* EINT24 */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(I, 13),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "spi0"),		/* MISO */
 		  SUNXI_FUNCTION(0x3, "uart6"),		/* RX */
 		  SUNXI_FUNCTION(0x4, "clk_out_b"),	/* CLK_OUT_B */
-		  SUNXI_FUNCTION_IRQ(0x5, 25)),		/* EINT25 */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(I, 14),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "spi0"),		/* CS1 */
 		  SUNXI_FUNCTION(0x3, "ps2"),		/* SCK1 */
 		  SUNXI_FUNCTION(0x4, "timer4"),	/* TCLKIN0 */
-		  SUNXI_FUNCTION_IRQ(0x5, 26)),		/* EINT26 */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(I, 15),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "spi1"),		/* CS1 */
 		  SUNXI_FUNCTION(0x3, "ps2"),		/* SDA1 */
 		  SUNXI_FUNCTION(0x4, "timer5"),	/* TCLKIN1 */
-		  SUNXI_FUNCTION_IRQ(0x5, 27)),		/* EINT27 */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(I, 16),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "spi1"),		/* CS0 */
 		  SUNXI_FUNCTION(0x3, "uart2"),		/* RTS */
-		  SUNXI_FUNCTION_IRQ(0x5, 28)),		/* EINT28 */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(I, 17),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "spi1"),		/* CLK */
 		  SUNXI_FUNCTION(0x3, "uart2"),		/* CTS */
-		  SUNXI_FUNCTION_IRQ(0x5, 29)),		/* EINT29 */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(I, 18),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "spi1"),		/* MOSI */
 		  SUNXI_FUNCTION(0x3, "uart2"),		/* TX */
-		  SUNXI_FUNCTION_IRQ(0x5, 30)),		/* EINT30 */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(I, 19),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "spi1"),		/* MISO */
 		  SUNXI_FUNCTION(0x3, "uart2"),		/* RX */
-		  SUNXI_FUNCTION_IRQ(0x5, 31)),		/* EINT31 */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(I, 20),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
-- 
2.5.0
