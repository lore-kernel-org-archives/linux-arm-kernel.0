From: hdegoede@redhat.com (Hans de Goede)
Date: Wed, 17 Dec 2014 18:18:12 +0100
Subject: [PATCH v2 01/13] pinctrl: sun6i: Add some missing functions
In-Reply-To: <1418836704-15689-1-git-send-email-hdegoede@redhat.com>
References: <1418836704-15689-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1418836704-15689-2-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

While working on pinctrl for the A31s, I noticed that function 4 of
PA15 - PA18 was missing, add these.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
-Drop the changes to the muxing of i2c3 this was based on
 "A31s Datasheet v1.40.pdf", but all other A31 related info puts them at the
 pins where we already have them, so leave this as is
---
 drivers/pinctrl/sunxi/pinctrl-sun6i-a31.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pinctrl/sunxi/pinctrl-sun6i-a31.c b/drivers/pinctrl/sunxi/pinctrl-sun6i-a31.c
index f42858e..18038f0 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sun6i-a31.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sun6i-a31.c
@@ -134,24 +134,28 @@ static const struct sunxi_desc_pin sun6i_a31_pins[] = {
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "gmac"),		/* RXD4 */
 		  SUNXI_FUNCTION(0x3, "lcd1"),		/* D15 */
+		  SUNXI_FUNCTION(0x4, "clk_out_a"),
 		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 15)),	/* PA_EINT15 */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 16),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "gmac"),		/* RXD5 */
 		  SUNXI_FUNCTION(0x3, "lcd1"),		/* D16 */
+		  SUNXI_FUNCTION(0x4, "dmic"),		/* CLK */
 		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 16)),	/* PA_EINT16 */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 17),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "gmac"),		/* RXD6 */
 		  SUNXI_FUNCTION(0x3, "lcd1"),		/* D17 */
+		  SUNXI_FUNCTION(0x4, "dmic"),		/* DIN */
 		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 17)),	/* PA_EINT17 */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 18),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "gmac"),		/* RXD7 */
 		  SUNXI_FUNCTION(0x3, "lcd1"),		/* D18 */
+		  SUNXI_FUNCTION(0x4, "clk_out_b"),
 		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 18)),	/* PA_EINT18 */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 19),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
@@ -207,6 +211,7 @@ static const struct sunxi_desc_pin sun6i_a31_pins[] = {
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "gmac"),		/* MDC */
 		  SUNXI_FUNCTION(0x3, "lcd1"),		/* HSYNC */
+		  SUNXI_FUNCTION(0x4, "clk_out_c"),
 		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 26)),	/* PA_EINT26 */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 27),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
-- 
2.1.0
