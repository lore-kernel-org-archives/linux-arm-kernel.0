From: hdegoede@redhat.com (Hans de Goede)
Date: Mon, 17 Feb 2014 22:19:41 +0100
Subject: [PATCH 1/4] pinctrl-sunxi: Fix sun5i-a13 port F multiplexing
In-Reply-To: <1392671984-29872-1-git-send-email-hdegoede@redhat.com>
References: <1392671984-29872-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1392671984-29872-2-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The correct value for selecting the mmc0 function on port F pins is 2 not 4,
as per the data-sheet:
http://dl.linux-sunxi.org/A13/A13%20Datasheet%20-%20v1.12%20%282012-03-29%29.pdf

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/pinctrl/pinctrl-sunxi-pins.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-sunxi-pins.h b/drivers/pinctrl/pinctrl-sunxi-pins.h
index 6fd8d4d..3d60669 100644
--- a/drivers/pinctrl/pinctrl-sunxi-pins.h
+++ b/drivers/pinctrl/pinctrl-sunxi-pins.h
@@ -1932,27 +1932,27 @@ static const struct sunxi_desc_pin sun5i_a13_pins[] = {
 	SUNXI_PIN(SUNXI_PINCTRL_PIN_PF0,
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
-		  SUNXI_FUNCTION(0x4, "mmc0")),		/* D1 */
+		  SUNXI_FUNCTION(0x2, "mmc0")),		/* D1 */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN_PF1,
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
-		  SUNXI_FUNCTION(0x4, "mmc0")),		/* D0 */
+		  SUNXI_FUNCTION(0x2, "mmc0")),		/* D0 */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN_PF2,
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
-		  SUNXI_FUNCTION(0x4, "mmc0")),		/* CLK */
+		  SUNXI_FUNCTION(0x2, "mmc0")),		/* CLK */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN_PF3,
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
-		  SUNXI_FUNCTION(0x4, "mmc0")),		/* CMD */
+		  SUNXI_FUNCTION(0x2, "mmc0")),		/* CMD */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN_PF4,
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
-		  SUNXI_FUNCTION(0x4, "mmc0")),		/* D3 */
+		  SUNXI_FUNCTION(0x2, "mmc0")),		/* D3 */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN_PF5,
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
-		  SUNXI_FUNCTION(0x4, "mmc0")),		/* D2 */
+		  SUNXI_FUNCTION(0x2, "mmc0")),		/* D2 */
 	/* Hole */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN_PG0,
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
-- 
1.8.5.3
