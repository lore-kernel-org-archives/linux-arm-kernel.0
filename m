From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  5 Jun 2013 17:25:45 +0900
Subject: [PATCH 054/130] ARM: shmobile: ap4evb: Register pinctrl mapping for
 USBHS
In-Reply-To: <1370420821-28420-1-git-send-email-horms+renesas@verge.net.au>
References: <1370420821-28420-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1370420821-28420-55-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Replace the GPIO-based USBHS pinmux configuration by a pinctrl mapping.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-ap4evb.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ap4evb.c b/arch/arm/mach-shmobile/board-ap4evb.c
index 152a5f7..297bf5e 100644
--- a/arch/arm/mach-shmobile/board-ap4evb.c
+++ b/arch/arm/mach-shmobile/board-ap4evb.c
@@ -1137,6 +1137,13 @@ static const struct pinctrl_map ap4evb_pinctrl_map[] = {
 	PIN_MAP_MUX_GROUP_DEFAULT("1-0048", "pfc-sh7372",
 				  "intc_irq7_0", "intc"),
 #endif
+	/* USBHS1 */
+	PIN_MAP_MUX_GROUP_DEFAULT("r8a66597_hcd.1", "pfc-sh7372",
+				  "usb1_vbus", "usb1"),
+	PIN_MAP_MUX_GROUP_DEFAULT("r8a66597_hcd.1", "pfc-sh7372",
+				  "usb1_otg_id_0", "usb1"),
+	PIN_MAP_MUX_GROUP_DEFAULT("r8a66597_hcd.1", "pfc-sh7372",
+				  "usb1_otg_ctrl_0", "usb1"),
 };
 
 #define GPIO_PORT9CR	IOMEM(0xE6051009)
@@ -1175,14 +1182,6 @@ static void __init ap4evb_init(void)
 	gpio_request_one(34, GPIOF_IN | GPIOF_EXPORT, NULL);
 	gpio_request_one(35, GPIOF_IN | GPIOF_EXPORT, NULL);
 
-	/* USB enable */
-	gpio_request(GPIO_FN_VBUS0_1,    NULL);
-	gpio_request(GPIO_FN_IDIN_1_18,  NULL);
-	gpio_request(GPIO_FN_PWEN_1_115, NULL);
-	gpio_request(GPIO_FN_OVCN_1_114, NULL);
-	gpio_request(GPIO_FN_EXTLP_1,    NULL);
-	gpio_request(GPIO_FN_OVCN2_1,    NULL);
-
 	/* setup USB phy */
 	__raw_writew(0x8a0a, IOMEM(0xE6058130));	/* USBCR4 */
 
-- 
1.8.2.1
