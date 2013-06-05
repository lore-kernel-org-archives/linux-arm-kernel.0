From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  5 Jun 2013 17:26:02 +0900
Subject: [PATCH 071/130] ARM: shmobile: armadillo800eva: Register pinctrl
 mapping for HDMI
In-Reply-To: <1370420821-28420-1-git-send-email-horms+renesas@verge.net.au>
References: <1370420821-28420-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1370420821-28420-72-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Replace the GPIO-based HDMI pinmux configuration by a pinctrl mapping.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-armadillo800eva.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-armadillo800eva.c b/arch/arm/mach-shmobile/board-armadillo800eva.c
index 4e1f8f3..dad4966 100644
--- a/arch/arm/mach-shmobile/board-armadillo800eva.c
+++ b/arch/arm/mach-shmobile/board-armadillo800eva.c
@@ -1072,6 +1072,9 @@ static const struct pinctrl_map eva_pinctrl_map[] = {
 				  "gether_mii", "gether"),
 	PIN_MAP_MUX_GROUP_DEFAULT("sh-eth", "pfc-r8a7740",
 				  "gether_int", "gether"),
+	/* HDMI */
+	PIN_MAP_MUX_GROUP_DEFAULT("sh-mobile-hdmi", "pfc-r8a7740",
+				  "hdmi", "hdmi"),
 	/* LCD0 */
 	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_lcdc_fb.0", "pfc-r8a7740",
 				  "lcd0_data24_0", "lcd0"),
@@ -1198,10 +1201,6 @@ static void __init eva_init(void)
 	gpio_direction_none(GPIO_PORT7CR); /* FSIAOBT needs no direction */
 	gpio_direction_none(GPIO_PORT8CR); /* FSIAOLR needs no direction */
 
-	/* HDMI */
-	gpio_request(GPIO_FN_HDMI_HPD,		NULL);
-	gpio_request(GPIO_FN_HDMI_CEC,		NULL);
-
 	/*
 	 * CAUTION
 	 *
-- 
1.8.2.1
