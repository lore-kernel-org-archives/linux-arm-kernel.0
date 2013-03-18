From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 18 Mar 2013 20:06:14 +0900
Subject: [PATCH 078/142] ARM: shmobile: ag5evm: Register pinctrl mappings for
 FSI
In-Reply-To: <1363604838-29359-1-git-send-email-horms+renesas@verge.net.au>
References: <1363604838-29359-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1363604838-29359-79-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Replace the GPIO-based FSI pinmux configuration by pinctrl mappings.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/mach-shmobile/board-ag5evm.c |   16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ag5evm.c b/arch/arm/mach-shmobile/board-ag5evm.c
index e19dade..178bfd1 100644
--- a/arch/arm/mach-shmobile/board-ag5evm.c
+++ b/arch/arm/mach-shmobile/board-ag5evm.c
@@ -552,6 +552,15 @@ static struct platform_device *ag5evm_devices[] __initdata = {
 };
 
 static const struct pinctrl_map ag5evm_pinctrl_map[] = {
+	/* FSIA */
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_fsi2.0", "pfc-sh73a0",
+				  "fsia_mclk_in", "fsia"),
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_fsi2.0", "pfc-sh73a0",
+				  "fsia_sclk_in", "fsia"),
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_fsi2.0", "pfc-sh73a0",
+				  "fsia_data_in", "fsia"),
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_fsi2.0", "pfc-sh73a0",
+				  "fsia_data_out", "fsia"),
 	/* I2C2 & I2C3 */
 	PIN_MAP_MUX_GROUP_DEFAULT("i2c-sh_mobile.2", "pfc-sh73a0",
 				  "i2c2_0", "i2c2"),
@@ -613,13 +622,6 @@ static void __init ag5evm_init(void)
 	gpio_request_one(144, GPIOF_IN, NULL); /* PINTA2 */
 	gpio_request_one(145, GPIOF_OUT_INIT_HIGH, NULL); /* RESET */
 
-	/* FSI A */
-	gpio_request(GPIO_FN_FSIACK, NULL);
-	gpio_request(GPIO_FN_FSIAILR, NULL);
-	gpio_request(GPIO_FN_FSIAIBT, NULL);
-	gpio_request(GPIO_FN_FSIAISLD, NULL);
-	gpio_request(GPIO_FN_FSIAOSLD, NULL);
-
 	/* IrDA */
 	gpio_request(GPIO_FN_PORT241_IRDA_OUT, NULL);
 	gpio_request(GPIO_FN_PORT242_IRDA_IN,  NULL);
-- 
1.7.10.4
