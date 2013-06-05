From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  5 Jun 2013 17:25:28 +0900
Subject: [PATCH 037/130] ARM: shmobile: mackerel: Register pinctrl mapping for
 HDMI
In-Reply-To: <1370420821-28420-1-git-send-email-horms+renesas@verge.net.au>
References: <1370420821-28420-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1370420821-28420-38-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Replace the GPIO-based HDMI pinmux configuration by a pinctrl mapping.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-mackerel.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-mackerel.c b/arch/arm/mach-shmobile/board-mackerel.c
index f2e8740..e5bcd18 100644
--- a/arch/arm/mach-shmobile/board-mackerel.c
+++ b/arch/arm/mach-shmobile/board-mackerel.c
@@ -1338,6 +1338,9 @@ static const struct pinctrl_map mackerel_pinctrl_map[] = {
 	/* FSIB (HDMI) */
 	PIN_MAP_MUX_GROUP_DEFAULT("asoc-simple-card.1", "pfc-sh7372",
 				  "fsib_mclk_in", "fsib"),
+	/* HDMI */
+	PIN_MAP_MUX_GROUP_DEFAULT("sh-mobile-hdmi", "pfc-sh7372",
+				  "hdmi", "hdmi"),
 	/* SDHI0 */
 	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.0", "pfc-sh7372",
 				  "sdhi0_data4", "sdhi0"),
@@ -1494,10 +1497,6 @@ static void __init mackerel_init(void)
 	gpio_request(GPIO_FN_SCIFA2_TXD1, NULL);
 	gpio_request(GPIO_FN_SCIFA2_RXD1, NULL);
 
-	/* HDMI */
-	gpio_request(GPIO_FN_HDMI_HPD, NULL);
-	gpio_request(GPIO_FN_HDMI_CEC, NULL);
-
 	/* Reset HDMI, must be held at least one EXTALR (32768Hz) period */
 	srcr4 = __raw_readl(SRCR4);
 	__raw_writel(srcr4 | (1 << 13), SRCR4);
-- 
1.8.2.1
