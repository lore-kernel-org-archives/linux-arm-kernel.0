From: icenowy@aosc.io (Icenowy Zheng)
Date: Thu, 28 Dec 2017 21:20:09 +0800
Subject: [PATCH] pinctrl: sunxi: fix a typo when merging A20 support to A10
 driver
Message-ID: <20171228132009.12839-1-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When merging A20 pinctrl support to A10 pinctrl driver, the I2C function
of PI3 is wrongly written as "i2c3" (it should be "i2c4").

Fix this typo.

Fixes: cad4e209c102 ("pinctrl: sunxi: add support of R40 to A10 pinctrl driver")
Reported-by: Mark Kettenis <mark.kettenis@xs4all.nl>
Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 drivers/pinctrl/sunxi/pinctrl-sun4i-a10.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/sunxi/pinctrl-sun4i-a10.c b/drivers/pinctrl/sunxi/pinctrl-sun4i-a10.c
index 295e48fc94bc..0c7c361ebac5 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sun4i-a10.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sun4i-a10.c
@@ -1167,7 +1167,7 @@ static const struct sunxi_desc_pin sun4i_a10_pins[] = {
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "pwm"),		/* PWM1 */
-		  SUNXI_FUNCTION_VARIANT(0x3, "i2c3",	/* SDA */
+		  SUNXI_FUNCTION_VARIANT(0x3, "i2c4",	/* SDA */
 					 PINCTRL_SUN7I_A20 |
 					 PINCTRL_SUN8I_R40)),
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(I, 4),
-- 
2.14.2
