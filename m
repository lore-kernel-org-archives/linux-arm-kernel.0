From: andre.przywara@arm.com (Andre Przywara)
Date: Sat, 25 Nov 2017 12:12:30 +0000
Subject: [PATCH] pinctrl: sunxi: Fix A64 UART mux value
Message-ID: <20171125121230.23555-1-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To use pin PF4 as the RX signal of UART0, we have to write 0b011 into
the respective pin controller register.
Fix the wrong value we had in our table so far.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/pinctrl/sunxi/pinctrl-sun50i-a64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/sunxi/pinctrl-sun50i-a64.c b/drivers/pinctrl/sunxi/pinctrl-sun50i-a64.c
index 4f2a726bbaeb..f5f77432ce6f 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sun50i-a64.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sun50i-a64.c
@@ -428,7 +428,7 @@ static const struct sunxi_desc_pin a64_pins[] = {
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "mmc0"),		/* D3 */
-		  SUNXI_FUNCTION(0x4, "uart0")),	/* RX */
+		  SUNXI_FUNCTION(0x3, "uart0")),	/* RX */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(F, 5),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
-- 
2.14.1
