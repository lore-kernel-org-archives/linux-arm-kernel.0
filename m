From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 18 Mar 2013 20:06:35 +0900
Subject: [PATCH 099/142] ARM: shmobile: marzen: Register pinctrl mappings for
 SCIF
In-Reply-To: <1363604838-29359-1-git-send-email-horms+renesas@verge.net.au>
References: <1363604838-29359-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1363604838-29359-100-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Replace the GPIO-based SCIF pinmux configuration by pinctrl mappings.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/mach-shmobile/board-marzen.c |   14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-marzen.c b/arch/arm/mach-shmobile/board-marzen.c
index f00677f..4097366 100644
--- a/arch/arm/mach-shmobile/board-marzen.c
+++ b/arch/arm/mach-shmobile/board-marzen.c
@@ -329,6 +329,12 @@ void __init marzen_init_late(void)
 }
 
 static const struct pinctrl_map marzen_pinctrl_map[] = {
+	/* SCIF2 (CN18: DEBUG0) */
+	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.2", "pfc-r8a7779",
+				  "scif2_data_c", "scif2"),
+	/* SCIF4 (CN19: DEBUG1) */
+	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.4", "pfc-r8a7779",
+				  "scif4_data", "scif4"),
 	/* SDHI0 */
 	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.0", "pfc-r8a7779",
 				  "sdhi0_data4", "sdhi0"),
@@ -351,14 +357,6 @@ static void __init marzen_init(void)
 				  ARRAY_SIZE(marzen_pinctrl_map));
 	r8a7779_pinmux_init();
 
-	/* SCIF2 (CN18: DEBUG0) */
-	gpio_request(GPIO_FN_TX2_C, NULL);
-	gpio_request(GPIO_FN_RX2_C, NULL);
-
-	/* SCIF4 (CN19: DEBUG1) */
-	gpio_request(GPIO_FN_TX4, NULL);
-	gpio_request(GPIO_FN_RX4, NULL);
-
 	/* LAN89218 */
 	gpio_request(GPIO_FN_EX_CS0, NULL); /* nCS */
 	gpio_request(GPIO_FN_IRQ1_B, NULL); /* IRQ + PME */
-- 
1.7.10.4
