From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Tue, 23 Aug 2016 13:58:25 +0800
Subject: [PATCH 1/2] pinctrl: sunxi: fix uart1 CTS/RTS pins at PG on A23/A33
Message-ID: <20160823055826.20591-1-icenowy@aosc.xyz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PG8, PG9 is said to be the CTS/RTS pins for UART1 according to the A23/33
datasheets. However, the function is wrongly named "uart2" in the pinctrl
driver. This patch fixes this by modifying them to be named "uart1".

Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
---
 drivers/pinctrl/sunxi/pinctrl-sun8i-a23.c | 4 ++--
 drivers/pinctrl/sunxi/pinctrl-sun8i-a33.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/sunxi/pinctrl-sun8i-a23.c b/drivers/pinctrl/sunxi/pinctrl-sun8i-a23.c
index ce483b0..f9d661e 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sun8i-a23.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sun8i-a23.c
@@ -485,12 +485,12 @@ static const struct sunxi_desc_pin sun8i_a23_pins[] = {
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 8),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
-		  SUNXI_FUNCTION(0x2, "uart2"),		/* RTS */
+		  SUNXI_FUNCTION(0x2, "uart1"),		/* RTS */
 		  SUNXI_FUNCTION_IRQ_BANK(0x4, 2, 8)),	/* PG_EINT8 */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 9),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
-		  SUNXI_FUNCTION(0x2, "uart2"),		/* CTS */
+		  SUNXI_FUNCTION(0x2, "uart1"),		/* CTS */
 		  SUNXI_FUNCTION_IRQ_BANK(0x4, 2, 9)),	/* PG_EINT9 */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 10),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
diff --git a/drivers/pinctrl/sunxi/pinctrl-sun8i-a33.c b/drivers/pinctrl/sunxi/pinctrl-sun8i-a33.c
index 3040abe..3131cac 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sun8i-a33.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sun8i-a33.c
@@ -407,12 +407,12 @@ static const struct sunxi_desc_pin sun8i_a33_pins[] = {
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 8),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
-		  SUNXI_FUNCTION(0x2, "uart2"),		/* RTS */
+		  SUNXI_FUNCTION(0x2, "uart1"),		/* RTS */
 		  SUNXI_FUNCTION_IRQ_BANK(0x4, 1, 8)),	/* PG_EINT8 */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 9),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
-		  SUNXI_FUNCTION(0x2, "uart2"),		/* CTS */
+		  SUNXI_FUNCTION(0x2, "uart1"),		/* CTS */
 		  SUNXI_FUNCTION_IRQ_BANK(0x4, 1, 9)),	/* PG_EINT9 */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 10),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
-- 
2.9.3
