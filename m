From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  5 Jun 2013 17:25:32 +0900
Subject: [PATCH 041/130] ARM: shmobile: mackerel: Register pinctrl mapping for
 SMSC911x
In-Reply-To: <1370420821-28420-1-git-send-email-horms+renesas@verge.net.au>
References: <1370420821-28420-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1370420821-28420-42-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Replace the GPIO-based SMSC911x pinmux configuration by a pinctrl
mapping.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-mackerel.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-mackerel.c b/arch/arm/mach-shmobile/board-mackerel.c
index 4be236d..49b66a8 100644
--- a/arch/arm/mach-shmobile/board-mackerel.c
+++ b/arch/arm/mach-shmobile/board-mackerel.c
@@ -1379,6 +1379,11 @@ static const struct pinctrl_map mackerel_pinctrl_map[] = {
 				  "sdhi2_data4", "sdhi2"),
 	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.2", "pfc-sh7372",
 				  "sdhi2_ctrl", "sdhi2"),
+	/* SMSC911X */
+	PIN_MAP_MUX_GROUP_DEFAULT("smsc911x", "pfc-sh7372",
+				  "bsc_cs5a", "bsc"),
+	PIN_MAP_MUX_GROUP_DEFAULT("smsc911x", "pfc-sh7372",
+				  "intc_irq6_0", "intc"),
 };
 
 #define GPIO_PORT9CR	IOMEM(0xE6051009)
@@ -1422,10 +1427,6 @@ static void __init mackerel_init(void)
 				  ARRAY_SIZE(mackerel_pinctrl_map));
 	sh7372_pinmux_init();
 
-	/* enable SMSC911X */
-	gpio_request(GPIO_FN_CS5A,	NULL);
-	gpio_request(GPIO_FN_IRQ6_39,	NULL);
-
 	/* backlight, off by default */
 	gpio_request_one(31, GPIOF_OUT_INIT_LOW, NULL);
 
-- 
1.8.2.1
