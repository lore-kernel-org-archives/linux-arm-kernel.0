From: andre.przywara@arm.com (Andre Przywara)
Date: Sat, 25 Nov 2017 12:19:48 +0000
Subject: [PATCH] pinctrl: sunxi: Fix A80 interrupt pin bank
Message-ID: <20171125121948.24012-1-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On the A80 the pins on port B can trigger interrupts, and those are
assigned to the second interrupt bank.
Having two pins assigned to the same interrupt bank/pin combination does
not look healthy (instead more like a copy&paste bug from pins PA14-PA16),
so fix the interrupt bank for pins PB14-PB16, which is actually 1.

I don't have any A80 board, so could not test this.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/pinctrl/sunxi/pinctrl-sun9i-a80.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/sunxi/pinctrl-sun9i-a80.c b/drivers/pinctrl/sunxi/pinctrl-sun9i-a80.c
index 472ef0d91b99..5553c0eb0f41 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sun9i-a80.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sun9i-a80.c
@@ -145,19 +145,19 @@ static const struct sunxi_desc_pin sun9i_a80_pins[] = {
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x3, "mcsi"),		/* MCLK */
-		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 14)),	/* PB_EINT14 */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 1, 14)),	/* PB_EINT14 */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 15),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x3, "mcsi"),		/* SCK */
 		  SUNXI_FUNCTION(0x4, "i2c4"),		/* SCK */
-		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 15)),	/* PB_EINT15 */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 1, 15)),	/* PB_EINT15 */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 16),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x3, "mcsi"),		/* SDA */
 		  SUNXI_FUNCTION(0x4, "i2c4"),		/* SDA */
-		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 16)),	/* PB_EINT16 */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 1, 16)),	/* PB_EINT16 */
 
 	/* Hole */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 0),
-- 
2.14.1
