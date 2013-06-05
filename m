From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  5 Jun 2013 17:25:35 +0900
Subject: [PATCH 044/130] ARM: shmobile: mackerel: Register pinctrl mapping for
 USBHS
In-Reply-To: <1370420821-28420-1-git-send-email-horms+renesas@verge.net.au>
References: <1370420821-28420-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1370420821-28420-45-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Replace the GPIO-based USBHS pinmux configuration by a pinctrl mapping.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-mackerel.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-mackerel.c b/arch/arm/mach-shmobile/board-mackerel.c
index 397e73c..85f51a8 100644
--- a/arch/arm/mach-shmobile/board-mackerel.c
+++ b/arch/arm/mach-shmobile/board-mackerel.c
@@ -1390,6 +1390,14 @@ static const struct pinctrl_map mackerel_pinctrl_map[] = {
 	/* TCA6416 */
 	PIN_MAP_MUX_GROUP_DEFAULT("0-0020", "pfc-sh7372",
 				  "intc_irq9_0", "intc"),
+	/* USBHS0 */
+	PIN_MAP_MUX_GROUP_DEFAULT("renesas_usbhs.0", "pfc-sh7372",
+				  "usb0_vbus", "usb0"),
+	/* USBHS1 */
+	PIN_MAP_MUX_GROUP_DEFAULT("renesas_usbhs.1", "pfc-sh7372",
+				  "usb1_vbus", "usb1"),
+	PIN_MAP_MUX_GROUP_DEFAULT("renesas_usbhs.1", "pfc-sh7372",
+				  "usb1_otg_id_0", "usb1"),
 };
 
 #define GPIO_PORT9CR	IOMEM(0xE6051009)
@@ -1439,13 +1447,10 @@ static void __init mackerel_init(void)
 	gpio_request_one(151, GPIOF_OUT_INIT_HIGH, NULL); /* LCDDON */
 
 	/* USBHS0 */
-	gpio_request(GPIO_FN_VBUS0_0, NULL);
 	gpio_request_pulldown(GPIO_PORT168CR); /* VBUS0_0 pull down */
 
 	/* USBHS1 */
-	gpio_request(GPIO_FN_VBUS0_1, NULL);
 	gpio_request_pulldown(GPIO_PORT167CR); /* VBUS0_1 pull down */
-	gpio_request(GPIO_FN_IDIN_1_113, NULL);
 
 	/* FSI2 port A (ak4643) */
 	gpio_request_one(161, GPIOF_OUT_INIT_LOW, NULL); /* slave */
-- 
1.8.2.1
