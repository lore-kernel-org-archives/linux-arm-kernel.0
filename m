From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  5 Jun 2013 17:25:24 +0900
Subject: [PATCH 033/130] ARM: shmobile: mackerel: Register pinctrl mapping for
 the ADXL34X
In-Reply-To: <1370420821-28420-1-git-send-email-horms+renesas@verge.net.au>
References: <1370420821-28420-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1370420821-28420-34-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Replace the GPIO-based ADXL34X pinmux configuration by a pinctrl
mapping.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-mackerel.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-mackerel.c b/arch/arm/mach-shmobile/board-mackerel.c
index fa3407d..d40d9da 100644
--- a/arch/arm/mach-shmobile/board-mackerel.c
+++ b/arch/arm/mach-shmobile/board-mackerel.c
@@ -1309,6 +1309,9 @@ static struct i2c_board_info i2c1_devices[] = {
 };
 
 static const struct pinctrl_map mackerel_pinctrl_map[] = {
+	/* ADXL34X */
+	PIN_MAP_MUX_GROUP_DEFAULT("1-0053", "pfc-sh7372",
+				  "intc_irq21", "intc"),
 	/* SDHI0 */
 	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.0", "pfc-sh7372",
 				  "sdhi0_data4", "sdhi0"),
@@ -1460,8 +1463,7 @@ static void __init mackerel_init(void)
 	gpio_request(GPIO_FN_IRQ7_40,	NULL);
 	irq_set_irq_type(IRQ7, IRQ_TYPE_LEVEL_LOW);
 
-	/* enable Accelerometer */
-	gpio_request(GPIO_FN_IRQ21,	NULL);
+	/* Accelerometer */
 	irq_set_irq_type(IRQ21, IRQ_TYPE_LEVEL_HIGH);
 
 	/* SDHI0 PORT172 card-detect IRQ26 */
-- 
1.8.2.1
