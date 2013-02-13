From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 13 Feb 2013 12:26:26 +0900
Subject: [PATCH 08/21] ARM: shmobile: kzm9g: reference: Register pinctrl
 mappings for SCIF
In-Reply-To: <1360725999-14514-1-git-send-email-horms+renesas@verge.net.au>
References: <1360725999-14514-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1360725999-14514-9-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace the GPIO-based SCIF pinmux configuration by pinctrl mappings.

This change is for the kzm9g reference DT implementation and
is in keeping with a similar change for the default kzm9g implementation
made by Laurent Pinchart.

Reported-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-kzm9g-reference.c |   10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-kzm9g-reference.c b/arch/arm/mach-shmobile/board-kzm9g-reference.c
index 543019f..7282048 100644
--- a/arch/arm/mach-shmobile/board-kzm9g-reference.c
+++ b/arch/arm/mach-shmobile/board-kzm9g-reference.c
@@ -36,6 +36,10 @@
 static const struct pinctrl_map kzm_pinctrl_map[] = {
 	PIN_MAP_MUX_GROUP_DEFAULT("i2c-sh_mobile.3", "pfc-sh73a0",
 				  "i2c3_1", "i2c3"),
+	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.4", "pfc-sh73a0",
+				  "scifa4_data", "scifa4"),
+	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.4", "pfc-sh73a0",
+				  "scifa4_ctrl", "scifa4"),
 };
 
 static void __init kzm_init(void)
@@ -44,12 +48,6 @@ static void __init kzm_init(void)
 	pinctrl_register_mappings(kzm_pinctrl_map, ARRAY_SIZE(kzm_pinctrl_map));
 	sh73a0_pinmux_init();
 
-	/* enable SCIFA4 */
-	gpio_request(GPIO_FN_SCIFA4_TXD, NULL);
-	gpio_request(GPIO_FN_SCIFA4_RXD, NULL);
-	gpio_request(GPIO_FN_SCIFA4_RTS_, NULL);
-	gpio_request(GPIO_FN_SCIFA4_CTS_, NULL);
-
 	/* enable MMCIF */
 	gpio_request(GPIO_FN_MMCCLK0,		NULL);
 	gpio_request(GPIO_FN_MMCCMD0_PU,	NULL);
-- 
1.7.10.4
