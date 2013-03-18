From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 18 Mar 2013 20:06:16 +0900
Subject: [PATCH 080/142] ARM: shmobile: ag5evm: Register pinctrl mappings for
 KEYSC
In-Reply-To: <1363604838-29359-1-git-send-email-horms+renesas@verge.net.au>
References: <1363604838-29359-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1363604838-29359-81-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Replace the GPIO-based KEYSC pinmux configuration by pinctrl mappings.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/mach-shmobile/board-ag5evm.c |   37 +++++++++++++++------------------
 1 file changed, 17 insertions(+), 20 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ag5evm.c b/arch/arm/mach-shmobile/board-ag5evm.c
index 987b9b6..22b9655 100644
--- a/arch/arm/mach-shmobile/board-ag5evm.c
+++ b/arch/arm/mach-shmobile/board-ag5evm.c
@@ -571,6 +571,23 @@ static const struct pinctrl_map ag5evm_pinctrl_map[] = {
 				  "i2c2_0", "i2c2"),
 	PIN_MAP_MUX_GROUP_DEFAULT("i2c-sh_mobile.3", "pfc-sh73a0",
 				  "i2c3_0", "i2c3"),
+	/* KEYSC */
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_keysc.0", "pfc-sh73a0",
+				  "keysc_in8", "keysc"),
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_keysc.0", "pfc-sh73a0",
+				  "keysc_out04", "keysc"),
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_keysc.0", "pfc-sh73a0",
+				  "keysc_out5", "keysc"),
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_keysc.0", "pfc-sh73a0",
+				  "keysc_out6_0", "keysc"),
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_keysc.0", "pfc-sh73a0",
+				  "keysc_out7_0", "keysc"),
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_keysc.0", "pfc-sh73a0",
+				  "keysc_out8_0", "keysc"),
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_keysc.0", "pfc-sh73a0",
+				  "keysc_out9_2", "keysc"),
+	PIN_MAP_CONFIGS_GROUP_DEFAULT("sh_keysc.0", "pfc-sh73a0",
+				      "keysc_in8", pin_pullup_conf),
 	/* MMCIF */
 	PIN_MAP_MUX_GROUP_DEFAULT("sh_mmcif.0", "pfc-sh73a0",
 				  "mmc0_data8_0", "mmc0"),
@@ -615,26 +632,6 @@ static void __init ag5evm_init(void)
 				  ARRAY_SIZE(ag5evm_pinctrl_map));
 	sh73a0_pinmux_init();
 
-	/* enable KEYSC */
-	gpio_request(GPIO_FN_KEYIN0_PU, NULL);
-	gpio_request(GPIO_FN_KEYIN1_PU, NULL);
-	gpio_request(GPIO_FN_KEYIN2_PU, NULL);
-	gpio_request(GPIO_FN_KEYIN3_PU, NULL);
-	gpio_request(GPIO_FN_KEYIN4_PU, NULL);
-	gpio_request(GPIO_FN_KEYIN5_PU, NULL);
-	gpio_request(GPIO_FN_KEYIN6_PU, NULL);
-	gpio_request(GPIO_FN_KEYIN7_PU, NULL);
-	gpio_request(GPIO_FN_KEYOUT0, NULL);
-	gpio_request(GPIO_FN_KEYOUT1, NULL);
-	gpio_request(GPIO_FN_KEYOUT2, NULL);
-	gpio_request(GPIO_FN_KEYOUT3, NULL);
-	gpio_request(GPIO_FN_KEYOUT4, NULL);
-	gpio_request(GPIO_FN_KEYOUT5, NULL);
-	gpio_request(GPIO_FN_PORT59_KEYOUT6, NULL);
-	gpio_request(GPIO_FN_PORT58_KEYOUT7, NULL);
-	gpio_request(GPIO_FN_KEYOUT8, NULL);
-	gpio_request(GPIO_FN_PORT149_KEYOUT9, NULL);
-
 	/* enable MMCIF */
 	gpio_request_one(208, GPIOF_OUT_INIT_HIGH, NULL); /* Reset */
 
-- 
1.7.10.4
