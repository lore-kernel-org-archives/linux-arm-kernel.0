From: draakje197@gmail.com (Henry Paulissen)
Date: Mon, 22 Feb 2016 18:14:07 +0100
Subject: [PATCH v6] Fix sun7i pin assignment for IRQ's
Message-ID: <1456161251-2303-1-git-send-email-henry@nitronetworks.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After testing IRQ pins we found some bugs in the pinctrl declaration.
Both PI* and PC* pins didn't work. PI* pins seemed to be connected
to the wrong mux and PC* pins waren't working at all.

Please note that the A20 soc manual is contradicting between version
and even within the same document for both the PI and PC pins.

Patch is based on testing with the hardware itself.

Tested-by: Andre Przywara <andre.przywara@arm.com>
Reviewed-by: Andre Przywara <andre.przywara@arm.com>
Signed-off-by: Henry Paulissen <henry@nitronetworks.nl>

---

Changes in v2:
    After some more testing we found irq on PI pins.
    they where on mux6 so this is included in my patch.

    Also included is a warning for PI17, this pin was not working
    on apritzel his bPI and he thinks it might be correlated to
    GIC and IRQ 29.

Changes in v3:
    Changed name from nickname to realname in email and SoB.

Changes in v4:
    Added closing parenthesis for the C pins.

Changes in v5:
    Added a more detailed description.

Changes in v6:
    Removed extra comment about pin I17 (extra tests needed).
    Added tested and reviewed by tags.

---
 drivers/pinctrl/sunxi/pinctrl-sun7i-a20.c | 32 ++++++++++++++-----------------
 1 file changed, 14 insertions(+), 18 deletions(-)

diff --git a/drivers/pinctrl/sunxi/pinctrl-sun7i-a20.c b/drivers/pinctrl/sunxi/pinctrl-sun7i-a20.c
index cf1ce0c..435ad30 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sun7i-a20.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sun7i-a20.c
@@ -343,26 +343,22 @@ static const struct sunxi_desc_pin sun7i_a20_pins[] = {
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "nand0"),		/* NCE4 */
-		  SUNXI_FUNCTION(0x3, "spi2"),		/* CS0 */
-		  SUNXI_FUNCTION_IRQ(0x6, 12)),		/* EINT12 */
+		  SUNXI_FUNCTION(0x3, "spi2")),		/* CS0 */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 20),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "nand0"),		/* NCE5 */
-		  SUNXI_FUNCTION(0x3, "spi2"),		/* CLK */
-		  SUNXI_FUNCTION_IRQ(0x6, 13)),		/* EINT13 */
+		  SUNXI_FUNCTION(0x3, "spi2")),		/* CLK */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 21),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "nand0"),		/* NCE6 */
-		  SUNXI_FUNCTION(0x3, "spi2"),		/* MOSI */
-		  SUNXI_FUNCTION_IRQ(0x6, 14)),		/* EINT14 */
+		  SUNXI_FUNCTION(0x3, "spi2")),		/* MOSI */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 22),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "nand0"),		/* NCE7 */
-		  SUNXI_FUNCTION(0x3, "spi2"),		/* MISO */
-		  SUNXI_FUNCTION_IRQ(0x6, 15)),		/* EINT15 */
+		  SUNXI_FUNCTION(0x3, "spi2")),		/* MISO */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 23),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
@@ -960,65 +956,65 @@ static const struct sunxi_desc_pin sun7i_a20_pins[] = {
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "spi0"),		/* CS0 */
 		  SUNXI_FUNCTION(0x3, "uart5"),		/* TX */
-		  SUNXI_FUNCTION_IRQ(0x5, 22)),		/* EINT22 */
+		  SUNXI_FUNCTION_IRQ(0x6, 22)),		/* EINT22 */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(I, 11),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "spi0"),		/* CLK */
 		  SUNXI_FUNCTION(0x3, "uart5"),		/* RX */
-		  SUNXI_FUNCTION_IRQ(0x5, 23)),		/* EINT23 */
+		  SUNXI_FUNCTION_IRQ(0x6, 23)),		/* EINT23 */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(I, 12),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "spi0"),		/* MOSI */
 		  SUNXI_FUNCTION(0x3, "uart6"),		/* TX */
 		  SUNXI_FUNCTION(0x4, "clk_out_a"),	/* CLK_OUT_A */
-		  SUNXI_FUNCTION_IRQ(0x5, 24)),		/* EINT24 */
+		  SUNXI_FUNCTION_IRQ(0x6, 24)),		/* EINT24 */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(I, 13),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "spi0"),		/* MISO */
 		  SUNXI_FUNCTION(0x3, "uart6"),		/* RX */
 		  SUNXI_FUNCTION(0x4, "clk_out_b"),	/* CLK_OUT_B */
-		  SUNXI_FUNCTION_IRQ(0x5, 25)),		/* EINT25 */
+		  SUNXI_FUNCTION_IRQ(0x6, 25)),		/* EINT25 */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(I, 14),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "spi0"),		/* CS1 */
 		  SUNXI_FUNCTION(0x3, "ps2"),		/* SCK1 */
 		  SUNXI_FUNCTION(0x4, "timer4"),	/* TCLKIN0 */
-		  SUNXI_FUNCTION_IRQ(0x5, 26)),		/* EINT26 */
+		  SUNXI_FUNCTION_IRQ(0x6, 26)),		/* EINT26 */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(I, 15),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "spi1"),		/* CS1 */
 		  SUNXI_FUNCTION(0x3, "ps2"),		/* SDA1 */
 		  SUNXI_FUNCTION(0x4, "timer5"),	/* TCLKIN1 */
-		  SUNXI_FUNCTION_IRQ(0x5, 27)),		/* EINT27 */
+		  SUNXI_FUNCTION_IRQ(0x6, 27)),		/* EINT27 */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(I, 16),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "spi1"),		/* CS0 */
 		  SUNXI_FUNCTION(0x3, "uart2"),		/* RTS */
-		  SUNXI_FUNCTION_IRQ(0x5, 28)),		/* EINT28 */
+		  SUNXI_FUNCTION_IRQ(0x6, 28)),		/* EINT28 */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(I, 17),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "spi1"),		/* CLK */
 		  SUNXI_FUNCTION(0x3, "uart2"),		/* CTS */
-		  SUNXI_FUNCTION_IRQ(0x5, 29)),		/* EINT29 */
+		  SUNXI_FUNCTION_IRQ(0x6, 29)),		/* EINT29 */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(I, 18),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "spi1"),		/* MOSI */
 		  SUNXI_FUNCTION(0x3, "uart2"),		/* TX */
-		  SUNXI_FUNCTION_IRQ(0x5, 30)),		/* EINT30 */
+		  SUNXI_FUNCTION_IRQ(0x6, 30)),		/* EINT30 */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(I, 19),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "spi1"),		/* MISO */
 		  SUNXI_FUNCTION(0x3, "uart2"),		/* RX */
-		  SUNXI_FUNCTION_IRQ(0x5, 31)),		/* EINT31 */
+		  SUNXI_FUNCTION_IRQ(0x6, 31)),		/* EINT31 */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(I, 20),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
-- 
2.5.0
