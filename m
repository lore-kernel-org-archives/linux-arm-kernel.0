From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 10 Dec 2012 23:08:17 +0100
Subject: [PATCH 2/6] ARM: pinctrl: sunxi: Add the pinctrl pin set for sun5i
In-Reply-To: <1355177301-31928-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1355177301-31928-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1355177301-31928-3-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since the Allwinner SoCs variants don't have the same set of pins to
handle, we need to declare the pin ranges available.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/pinctrl/pinctrl-sunxi.c |  120 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 120 insertions(+)

diff --git a/drivers/pinctrl/pinctrl-sunxi.c b/drivers/pinctrl/pinctrl-sunxi.c
index 1da6d3e..df7e3b7 100644
--- a/drivers/pinctrl/pinctrl-sunxi.c
+++ b/drivers/pinctrl/pinctrl-sunxi.c
@@ -26,6 +26,125 @@
 #include "core.h"
 #include "pinctrl-sunxi.h"
 
+static const struct pinctrl_pin_desc sun5i_pinctrl_pins[] = {
+	/* Hole */
+	SUNXI_PINCTRL_PIN_PB0,
+	SUNXI_PINCTRL_PIN_PB1,
+	SUNXI_PINCTRL_PIN_PB2,
+	SUNXI_PINCTRL_PIN_PB3,
+	SUNXI_PINCTRL_PIN_PB4,
+	/* Hole */
+	SUNXI_PINCTRL_PIN_PB10,
+	/* Hole */
+	SUNXI_PINCTRL_PIN_PB15,
+	SUNXI_PINCTRL_PIN_PB16,
+	SUNXI_PINCTRL_PIN_PB17,
+	SUNXI_PINCTRL_PIN_PB18,
+	/* Hole */
+	SUNXI_PINCTRL_PIN_PC0,
+	SUNXI_PINCTRL_PIN_PC1,
+	SUNXI_PINCTRL_PIN_PC2,
+	SUNXI_PINCTRL_PIN_PC3,
+	SUNXI_PINCTRL_PIN_PC4,
+	SUNXI_PINCTRL_PIN_PC5,
+	SUNXI_PINCTRL_PIN_PC6,
+	SUNXI_PINCTRL_PIN_PC7,
+	SUNXI_PINCTRL_PIN_PC8,
+	SUNXI_PINCTRL_PIN_PC9,
+	SUNXI_PINCTRL_PIN_PC10,
+	SUNXI_PINCTRL_PIN_PC11,
+	SUNXI_PINCTRL_PIN_PC12,
+	SUNXI_PINCTRL_PIN_PC13,
+	SUNXI_PINCTRL_PIN_PC14,
+	SUNXI_PINCTRL_PIN_PC15,
+	/* Hole */
+	SUNXI_PINCTRL_PIN_PC19,
+	/* Hole */
+	SUNXI_PINCTRL_PIN_PD2,
+	SUNXI_PINCTRL_PIN_PD3,
+	SUNXI_PINCTRL_PIN_PD4,
+	SUNXI_PINCTRL_PIN_PD5,
+	SUNXI_PINCTRL_PIN_PD6,
+	SUNXI_PINCTRL_PIN_PD7,
+	/* Hole */
+	SUNXI_PINCTRL_PIN_PD10,
+	SUNXI_PINCTRL_PIN_PD11,
+	SUNXI_PINCTRL_PIN_PD12,
+	SUNXI_PINCTRL_PIN_PD13,
+	SUNXI_PINCTRL_PIN_PD14,
+	SUNXI_PINCTRL_PIN_PD15,
+	/* Hole */
+	SUNXI_PINCTRL_PIN_PD18,
+	SUNXI_PINCTRL_PIN_PD19,
+	SUNXI_PINCTRL_PIN_PD20,
+	SUNXI_PINCTRL_PIN_PD21,
+	SUNXI_PINCTRL_PIN_PD22,
+	SUNXI_PINCTRL_PIN_PD23,
+	SUNXI_PINCTRL_PIN_PD24,
+	SUNXI_PINCTRL_PIN_PD25,
+	SUNXI_PINCTRL_PIN_PD26,
+	SUNXI_PINCTRL_PIN_PD27,
+	/* Hole */
+	SUNXI_PINCTRL_PIN_PE0,
+	SUNXI_PINCTRL_PIN_PE1,
+	SUNXI_PINCTRL_PIN_PE2,
+	SUNXI_PINCTRL_PIN_PE3,
+	SUNXI_PINCTRL_PIN_PE4,
+	SUNXI_PINCTRL_PIN_PE5,
+	SUNXI_PINCTRL_PIN_PE6,
+	SUNXI_PINCTRL_PIN_PE7,
+	SUNXI_PINCTRL_PIN_PE8,
+	SUNXI_PINCTRL_PIN_PE9,
+	SUNXI_PINCTRL_PIN_PE10,
+	SUNXI_PINCTRL_PIN_PE11,
+	/* Hole */
+	SUNXI_PINCTRL_PIN_PF0,
+	SUNXI_PINCTRL_PIN_PF1,
+	SUNXI_PINCTRL_PIN_PF2,
+	SUNXI_PINCTRL_PIN_PF3,
+	SUNXI_PINCTRL_PIN_PF4,
+	SUNXI_PINCTRL_PIN_PF5,
+	/* Hole */
+	SUNXI_PINCTRL_PIN_PG0,
+	SUNXI_PINCTRL_PIN_PG1,
+	SUNXI_PINCTRL_PIN_PG2,
+	SUNXI_PINCTRL_PIN_PG3,
+	SUNXI_PINCTRL_PIN_PG4,
+	/* Hole */
+	SUNXI_PINCTRL_PIN_PG9,
+	SUNXI_PINCTRL_PIN_PG10,
+	SUNXI_PINCTRL_PIN_PG11,
+	SUNXI_PINCTRL_PIN_PG12,
+};
+
+static struct pinctrl_gpio_range sun5i_pinctrl_ranges[] = {
+	/* PB */
+	SUNXI_GPIO_RANGE(1, 32, 5),
+	SUNXI_GPIO_RANGE(2, 42, 1),
+	SUNXI_GPIO_RANGE(3, 47, 4),
+	/* PC */
+	SUNXI_GPIO_RANGE(4, 64, 16),
+	SUNXI_GPIO_RANGE(5, 83, 1),
+	/* PD */
+	SUNXI_GPIO_RANGE(6, 98, 8),
+	SUNXI_GPIO_RANGE(7, 106, 6),
+	SUNXI_GPIO_RANGE(8, 114, 10),
+	/* PE */
+	SUNXI_GPIO_RANGE(9, 128, 12),
+	/* PF */
+	SUNXI_GPIO_RANGE(10, 160, 6),
+	/* PG */
+	SUNXI_GPIO_RANGE(11, 192, 5),
+	SUNXI_GPIO_RANGE(12, 201, 4),
+};
+
+static const struct sunxi_pinctrl_data sun5i_pinctrl_data = {
+	.ranges = sun5i_pinctrl_ranges,
+	.nranges = ARRAY_SIZE(sun5i_pinctrl_ranges),
+	.pins = sun5i_pinctrl_pins,
+	.npins = ARRAY_SIZE(sun5i_pinctrl_pins),
+};
+
 static int sunxi_pctrl_get_groups_count(struct pinctrl_dev *pctldev)
 {
 	struct sunxi_pinctrl *pctl = pinctrl_dev_get_drvdata(pctldev);
@@ -251,6 +370,7 @@ static struct pinctrl_desc sunxi_pctrl_desc = {
 };
 
 static struct of_device_id sunxi_pinctrl_match[] __devinitconst = {
+	{ .compatible = "allwinner,sun5i-pinctrl", .data = (void *)&sun5i_pinctrl_data },
 	{}
 };
 MODULE_DEVICE_TABLE(of, sunxi_pinctrl_match);
-- 
1.7.9.5
