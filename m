From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  5 Jun 2013 17:25:31 +0900
Subject: [PATCH 040/130] ARM: shmobile: mackerel: Register IRQ pinctrl mapping
 for SDHI0
In-Reply-To: <1370420821-28420-1-git-send-email-horms+renesas@verge.net.au>
References: <1370420821-28420-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1370420821-28420-41-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Replace the GPIO-based SDHI0 IRQ pinmux configuration by a pinctrl
mapping.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-mackerel.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-mackerel.c b/arch/arm/mach-shmobile/board-mackerel.c
index bd3666b..4be236d 100644
--- a/arch/arm/mach-shmobile/board-mackerel.c
+++ b/arch/arm/mach-shmobile/board-mackerel.c
@@ -1359,6 +1359,8 @@ static const struct pinctrl_map mackerel_pinctrl_map[] = {
 				  "sdhi0_ctrl", "sdhi0"),
 	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.0", "pfc-sh7372",
 				  "sdhi0_wp", "sdhi0"),
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.0", "pfc-sh7372",
+				  "intc_irq26_1", "intc"),
 	/* SDHI1 */
 #if !IS_ENABLED(CONFIG_MMC_SH_MMCIF)
 	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.1", "pfc-sh7372",
@@ -1469,9 +1471,6 @@ static void __init mackerel_init(void)
 	/* Accelerometer */
 	irq_set_irq_type(IRQ21, IRQ_TYPE_LEVEL_HIGH);
 
-	/* SDHI0 PORT172 card-detect IRQ26 */
-	gpio_request(GPIO_FN_IRQ26_172, NULL);
-
 	/* Reset HDMI, must be held at least one EXTALR (32768Hz) period */
 	srcr4 = __raw_readl(SRCR4);
 	__raw_writel(srcr4 | (1 << 13), SRCR4);
-- 
1.8.2.1
