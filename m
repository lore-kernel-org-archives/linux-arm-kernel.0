From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 18 Mar 2013 20:06:36 +0900
Subject: [PATCH 100/142] ARM: shmobile: marzen: Register pinctrl mappings for
 HSPI
In-Reply-To: <1363604838-29359-1-git-send-email-horms+renesas@verge.net.au>
References: <1363604838-29359-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1363604838-29359-101-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Replace the GPIO-based HSPI pinmux configuration by pinctrl mappings.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/mach-shmobile/board-marzen.c |    9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-marzen.c b/arch/arm/mach-shmobile/board-marzen.c
index 4097366..8871af3 100644
--- a/arch/arm/mach-shmobile/board-marzen.c
+++ b/arch/arm/mach-shmobile/board-marzen.c
@@ -329,6 +329,9 @@ void __init marzen_init_late(void)
 }
 
 static const struct pinctrl_map marzen_pinctrl_map[] = {
+	/* HSPI0 */
+	PIN_MAP_MUX_GROUP_DEFAULT("sh-hspi.0", "pfc-r8a7779",
+				  "hspi0", "hspi0"),
 	/* SCIF2 (CN18: DEBUG0) */
 	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.2", "pfc-r8a7779",
 				  "scif2_data_c", "scif2"),
@@ -361,12 +364,6 @@ static void __init marzen_init(void)
 	gpio_request(GPIO_FN_EX_CS0, NULL); /* nCS */
 	gpio_request(GPIO_FN_IRQ1_B, NULL); /* IRQ + PME */
 
-	/* HSPI 0 */
-	gpio_request(GPIO_FN_HSPI_CLK0,	NULL);
-	gpio_request(GPIO_FN_HSPI_CS0,	NULL);
-	gpio_request(GPIO_FN_HSPI_TX0,	NULL);
-	gpio_request(GPIO_FN_HSPI_RX0,	NULL);
-
 	/* USB (CN21) */
 	gpio_request(GPIO_FN_USB_OVC0, NULL);
 	gpio_request(GPIO_FN_USB_OVC1, NULL);
-- 
1.7.10.4
