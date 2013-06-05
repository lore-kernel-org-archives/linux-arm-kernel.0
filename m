From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  5 Jun 2013 17:25:42 +0900
Subject: [PATCH 051/130] ARM: shmobile: ap4evb: Register pinctrl mapping for
 SMSC911x
In-Reply-To: <1370420821-28420-1-git-send-email-horms+renesas@verge.net.au>
References: <1370420821-28420-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1370420821-28420-52-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Replace the GPIO-based SMSC911x pinmux configuration by a pinctrl
mapping.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-ap4evb.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ap4evb.c b/arch/arm/mach-shmobile/board-ap4evb.c
index 3163983..9ee8bcd 100644
--- a/arch/arm/mach-shmobile/board-ap4evb.c
+++ b/arch/arm/mach-shmobile/board-ap4evb.c
@@ -1136,6 +1136,11 @@ static const struct pinctrl_map ap4evb_pinctrl_map[] = {
 				  "sdhi1_data4", "sdhi1"),
 	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.1", "pfc-sh7372",
 				  "sdhi1_ctrl", "sdhi1"),
+	/* SMSC911X */
+	PIN_MAP_MUX_GROUP_DEFAULT("smsc911x", "pfc-sh7372",
+				  "bsc_cs5a", "bsc"),
+	PIN_MAP_MUX_GROUP_DEFAULT("smsc911x", "pfc-sh7372",
+				  "intc_irq6_0", "intc"),
 };
 
 #define GPIO_PORT9CR	IOMEM(0xE6051009)
@@ -1168,10 +1173,6 @@ static void __init ap4evb_init(void)
 				  ARRAY_SIZE(ap4evb_pinctrl_map));
 	sh7372_pinmux_init();
 
-	/* enable SMSC911X */
-	gpio_request(GPIO_FN_CS5A,	NULL);
-	gpio_request(GPIO_FN_IRQ6_39,	NULL);
-
 	/* enable Debug switch (S6) */
 	gpio_request_one(32, GPIOF_IN | GPIOF_EXPORT, NULL);
 	gpio_request_one(33, GPIOF_IN | GPIOF_EXPORT, NULL);
-- 
1.8.2.1
