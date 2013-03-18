From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 18 Mar 2013 20:06:25 +0900
Subject: [PATCH 089/142] ARM: shmobile: kota2: Register pinctrl mappings for
 BSC
In-Reply-To: <1363604838-29359-1-git-send-email-horms+renesas@verge.net.au>
References: <1363604838-29359-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1363604838-29359-90-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Replace the GPIO-based BSC pinmux configuration by pinctrl mappings.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/mach-shmobile/board-kota2.c |   27 +++++++++------------------
 1 file changed, 9 insertions(+), 18 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-kota2.c b/arch/arm/mach-shmobile/board-kota2.c
index 3f36557..ef5ca0e 100644
--- a/arch/arm/mach-shmobile/board-kota2.c
+++ b/arch/arm/mach-shmobile/board-kota2.c
@@ -503,6 +503,15 @@ static const struct pinctrl_map kota2_pinctrl_map[] = {
 				      "sdhi1_data4", pin_pullup_conf),
 	PIN_MAP_CONFIGS_PIN_DEFAULT("sh_mobile_sdhi.1", "pfc-sh73a0",
 				    "PORT263", pin_pullup_conf),
+	/* SMSC911X */
+	PIN_MAP_MUX_GROUP_DEFAULT("smsc911x.0", "pfc-sh73a0",
+				  "bsc_data_0_7", "bsc"),
+	PIN_MAP_MUX_GROUP_DEFAULT("smsc911x.0", "pfc-sh73a0",
+				  "bsc_data_8_15", "bsc"),
+	PIN_MAP_MUX_GROUP_DEFAULT("smsc911x.0", "pfc-sh73a0",
+				  "bsc_cs5_a", "bsc"),
+	PIN_MAP_MUX_GROUP_DEFAULT("smsc911x.0", "pfc-sh73a0",
+				  "bsc_we0", "bsc"),
 };
 
 static void __init kota2_init(void)
@@ -518,24 +527,6 @@ static void __init kota2_init(void)
 	sh73a0_pinmux_init();
 
 	/* SMSC911X */
-	gpio_request(GPIO_FN_D0_NAF0, NULL);
-	gpio_request(GPIO_FN_D1_NAF1, NULL);
-	gpio_request(GPIO_FN_D2_NAF2, NULL);
-	gpio_request(GPIO_FN_D3_NAF3, NULL);
-	gpio_request(GPIO_FN_D4_NAF4, NULL);
-	gpio_request(GPIO_FN_D5_NAF5, NULL);
-	gpio_request(GPIO_FN_D6_NAF6, NULL);
-	gpio_request(GPIO_FN_D7_NAF7, NULL);
-	gpio_request(GPIO_FN_D8_NAF8, NULL);
-	gpio_request(GPIO_FN_D9_NAF9, NULL);
-	gpio_request(GPIO_FN_D10_NAF10, NULL);
-	gpio_request(GPIO_FN_D11_NAF11, NULL);
-	gpio_request(GPIO_FN_D12_NAF12, NULL);
-	gpio_request(GPIO_FN_D13_NAF13, NULL);
-	gpio_request(GPIO_FN_D14_NAF14, NULL);
-	gpio_request(GPIO_FN_D15_NAF15, NULL);
-	gpio_request(GPIO_FN_CS5A_, NULL);
-	gpio_request(GPIO_FN_WE0__FWE, NULL);
 	gpio_request_one(144, GPIOF_IN, NULL); /* PINTA2 */
 	gpio_request_one(145, GPIOF_OUT_INIT_HIGH, NULL); /* RESET */
 
-- 
1.7.10.4
