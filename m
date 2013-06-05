From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  5 Jun 2013 17:25:33 +0900
Subject: [PATCH 042/130] ARM: shmobile: mackerel: Register pinctrl mapping for
 ST1232
In-Reply-To: <1370420821-28420-1-git-send-email-horms+renesas@verge.net.au>
References: <1370420821-28420-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1370420821-28420-43-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Replace the GPIO-based ST1232 pinmux configuration by a pinctrl mapping.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-mackerel.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-mackerel.c b/arch/arm/mach-shmobile/board-mackerel.c
index 49b66a8..8350635 100644
--- a/arch/arm/mach-shmobile/board-mackerel.c
+++ b/arch/arm/mach-shmobile/board-mackerel.c
@@ -1384,6 +1384,9 @@ static const struct pinctrl_map mackerel_pinctrl_map[] = {
 				  "bsc_cs5a", "bsc"),
 	PIN_MAP_MUX_GROUP_DEFAULT("smsc911x", "pfc-sh7372",
 				  "intc_irq6_0", "intc"),
+	/* ST1232 */
+	PIN_MAP_MUX_GROUP_DEFAULT("0-0055", "pfc-sh7372",
+				  "intc_irq7_0", "intc"),
 };
 
 #define GPIO_PORT9CR	IOMEM(0xE6051009)
@@ -1465,8 +1468,7 @@ static void __init mackerel_init(void)
 	gpio_request(GPIO_FN_IRQ9_42,	NULL);
 	irq_set_irq_type(IRQ9, IRQ_TYPE_LEVEL_HIGH);
 
-	/* enable Touchscreen */
-	gpio_request(GPIO_FN_IRQ7_40,	NULL);
+	/* Touchscreen */
 	irq_set_irq_type(IRQ7, IRQ_TYPE_LEVEL_LOW);
 
 	/* Accelerometer */
-- 
1.8.2.1
