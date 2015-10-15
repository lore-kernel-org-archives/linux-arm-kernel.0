From: hdegoede@redhat.com (Hans de Goede)
Date: Thu, 15 Oct 2015 16:27:26 +0200
Subject: [PATCH 2/2] pinctrl: sunxi: Add irq pinmuxing to sun6i "r"
 pincontroller
In-Reply-To: <1444919246-23694-1-git-send-email-hdegoede@redhat.com>
References: <1444919246-23694-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1444919246-23694-3-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add pinmuxing for external interrupt functionality through the
sun6i "r" pincontroller.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/pinctrl/sunxi/pinctrl-sun6i-a31-r.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/pinctrl/sunxi/pinctrl-sun6i-a31-r.c b/drivers/pinctrl/sunxi/pinctrl-sun6i-a31-r.c
index 9596b0a3..88bd20f 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sun6i-a31-r.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sun6i-a31-r.c
@@ -47,45 +47,57 @@ static const struct sunxi_desc_pin sun6i_a31_r_pins[] = {
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(L, 5),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION_IRQ_BANK(0x2, 0, 0),	/* PL_EINT0 */
 		  SUNXI_FUNCTION(0x3, "s_jtag")),	/* MS */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(L, 6),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION_IRQ_BANK(0x2, 0, 1),	/* PL_EINT1 */
 		  SUNXI_FUNCTION(0x3, "s_jtag")),	/* CK */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(L, 7),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION_IRQ_BANK(0x2, 0, 2),	/* PL_EINT2 */
 		  SUNXI_FUNCTION(0x3, "s_jtag")),	/* DO */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(L, 8),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION_IRQ_BANK(0x2, 0, 3),	/* PL_EINT3 */
 		  SUNXI_FUNCTION(0x3, "s_jtag")),	/* DI */
 	/* Hole */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(M, 0),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out")),
+		  SUNXI_FUNCTION_IRQ_BANK(0x2, 1, 0),	/* PM_EINT0 */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(M, 1),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out")),
+		  SUNXI_FUNCTION_IRQ_BANK(0x2, 1, 1),	/* PM_EINT1 */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(M, 2),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION_IRQ_BANK(0x2, 1, 2),	/* PM_EINT2 */
 		  SUNXI_FUNCTION(0x3, "1wire")),
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(M, 3),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out")),
+		  SUNXI_FUNCTION_IRQ_BANK(0x2, 1, 3),	/* PM_EINT3 */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(M, 4),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out")),
+		  SUNXI_FUNCTION_IRQ_BANK(0x2, 1, 4),	/* PM_EINT4 */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(M, 5),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out")),
+		  SUNXI_FUNCTION_IRQ_BANK(0x2, 1, 5),	/* PM_EINT5 */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(M, 6),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out")),
+		  SUNXI_FUNCTION_IRQ_BANK(0x2, 1, 6),	/* PM_EINT6 */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(M, 7),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION_IRQ_BANK(0x2, 1, 7),	/* PM_EINT7 */
 		  SUNXI_FUNCTION(0x3, "rtc")),		/* CLKO */
 };
 
-- 
2.5.0
