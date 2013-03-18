From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 18 Mar 2013 20:06:17 +0900
Subject: [PATCH 081/142] ARM: shmobile: ag5evm: Register pinctrl mappings for
 IrDA
In-Reply-To: <1363604838-29359-1-git-send-email-horms+renesas@verge.net.au>
References: <1363604838-29359-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1363604838-29359-82-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Replace the GPIO-based IrDA pinmux configuration by pinctrl mappings.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/mach-shmobile/board-ag5evm.c |    8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ag5evm.c b/arch/arm/mach-shmobile/board-ag5evm.c
index 22b9655..c754071 100644
--- a/arch/arm/mach-shmobile/board-ag5evm.c
+++ b/arch/arm/mach-shmobile/board-ag5evm.c
@@ -571,6 +571,9 @@ static const struct pinctrl_map ag5evm_pinctrl_map[] = {
 				  "i2c2_0", "i2c2"),
 	PIN_MAP_MUX_GROUP_DEFAULT("i2c-sh_mobile.3", "pfc-sh73a0",
 				  "i2c3_0", "i2c3"),
+	/* IrDA */
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_irda.0", "pfc-sh73a0",
+				  "irda_0", "irda"),
 	/* KEYSC */
 	PIN_MAP_MUX_GROUP_DEFAULT("sh_keysc.0", "pfc-sh73a0",
 				  "keysc_in8", "keysc"),
@@ -639,11 +642,6 @@ static void __init ag5evm_init(void)
 	gpio_request_one(144, GPIOF_IN, NULL); /* PINTA2 */
 	gpio_request_one(145, GPIOF_OUT_INIT_HIGH, NULL); /* RESET */
 
-	/* IrDA */
-	gpio_request(GPIO_FN_PORT241_IRDA_OUT, NULL);
-	gpio_request(GPIO_FN_PORT242_IRDA_IN,  NULL);
-	gpio_request(GPIO_FN_PORT243_IRDA_FIRSEL, NULL);
-
 	/* LCD panel */
 	gpio_request_one(217, GPIOF_OUT_INIT_LOW, NULL); /* RESET */
 	mdelay(1);
-- 
1.7.10.4
