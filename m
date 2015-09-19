From: hdegoede@redhat.com (Hans de Goede)
Date: Sat, 19 Sep 2015 17:56:44 -0400
Subject: [PATCH] pinctrl: sun5i: Fix a10s pwm1 pinctrl mapping
Message-ID: <1442699804-15526-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The comment for PG14 mux setting 3 already correctly states that this
muxes PG13 to pwm1, but the text ascociated with it said uart3, fix this.

Note that we use "pwm" rather then "pwm1" to be consistent with pwm0
where the mux setting is also simply called "pwm" and to be consistent
with sun4i/sun7i which do the same.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/pinctrl/sunxi/pinctrl-sun5i-a10s.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/sunxi/pinctrl-sun5i-a10s.c b/drivers/pinctrl/sunxi/pinctrl-sun5i-a10s.c
index 6367661..f9a3f8f 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sun5i-a10s.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sun5i-a10s.c
@@ -653,7 +653,7 @@ static const struct sunxi_desc_pin sun5i_a10s_pins[] = {
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "spi1"),		/* CS1 */
-		  SUNXI_FUNCTION(0x3, "uart3"),		/* PWM1 */
+		  SUNXI_FUNCTION(0x3, "pwm"),		/* PWM1 */
 		  SUNXI_FUNCTION(0x5, "uart2"),		/* CTS */
 		  SUNXI_FUNCTION_IRQ(0x6, 13)),		/* EINT13 */
 };
-- 
2.4.3
