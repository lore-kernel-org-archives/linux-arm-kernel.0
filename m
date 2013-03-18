From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 18 Mar 2013 20:06:37 +0900
Subject: [PATCH 101/142] ARM: shmobile: marzen: Register pinctrl mappings for
 USB
In-Reply-To: <1363604838-29359-1-git-send-email-horms+renesas@verge.net.au>
References: <1363604838-29359-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1363604838-29359-102-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Replace the GPIO-based USB pinmux configuration by pinctrl mappings.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/mach-shmobile/board-marzen.c |   17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-marzen.c b/arch/arm/mach-shmobile/board-marzen.c
index 8871af3..04bcf88 100644
--- a/arch/arm/mach-shmobile/board-marzen.c
+++ b/arch/arm/mach-shmobile/board-marzen.c
@@ -347,6 +347,15 @@ static const struct pinctrl_map marzen_pinctrl_map[] = {
 				  "sdhi0_cd", "sdhi0"),
 	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.0", "pfc-r8a7779",
 				  "sdhi0_wp", "sdhi0"),
+	/* USB0 */
+	PIN_MAP_MUX_GROUP_DEFAULT("ehci-platform.0", "pfc-r8a7779",
+				  "usb0", "usb0"),
+	/* USB1 */
+	PIN_MAP_MUX_GROUP_DEFAULT("ehci-platform.0", "pfc-r8a7779",
+				  "usb1", "usb1"),
+	/* USB2 */
+	PIN_MAP_MUX_GROUP_DEFAULT("ehci-platform.1", "pfc-r8a7779",
+				  "usb2", "usb2"),
 };
 
 static void __init marzen_init(void)
@@ -364,14 +373,6 @@ static void __init marzen_init(void)
 	gpio_request(GPIO_FN_EX_CS0, NULL); /* nCS */
 	gpio_request(GPIO_FN_IRQ1_B, NULL); /* IRQ + PME */
 
-	/* USB (CN21) */
-	gpio_request(GPIO_FN_USB_OVC0, NULL);
-	gpio_request(GPIO_FN_USB_OVC1, NULL);
-	gpio_request(GPIO_FN_USB_OVC2, NULL);
-
-	/* USB (CN22) */
-	gpio_request(GPIO_FN_USB_PENC2, NULL);
-
 	r8a7779_add_standard_devices();
 	platform_add_devices(marzen_devices, ARRAY_SIZE(marzen_devices));
 }
-- 
1.7.10.4
