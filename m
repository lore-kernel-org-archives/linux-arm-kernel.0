From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  5 Jun 2013 17:26:00 +0900
Subject: [PATCH 069/130] ARM: shmobile: armadillo800eva: Register pinctrl
 mapping for CEU0
In-Reply-To: <1370420821-28420-1-git-send-email-horms+renesas@verge.net.au>
References: <1370420821-28420-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1370420821-28420-70-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Replace the GPIO-based CEU0 pinmux configuration by a pinctrl mapping.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-armadillo800eva.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-armadillo800eva.c b/arch/arm/mach-shmobile/board-armadillo800eva.c
index 328f650..4327f7e 100644
--- a/arch/arm/mach-shmobile/board-armadillo800eva.c
+++ b/arch/arm/mach-shmobile/board-armadillo800eva.c
@@ -1046,6 +1046,15 @@ static struct platform_device *eva_devices[] __initdata = {
 };
 
 static const struct pinctrl_map eva_pinctrl_map[] = {
+	/* CEU0 */
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_ceu.0", "pfc-r8a7740",
+				  "ceu0_data_0_7", "ceu0"),
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_ceu.0", "pfc-r8a7740",
+				  "ceu0_clk_0", "ceu0"),
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_ceu.0", "pfc-r8a7740",
+				  "ceu0_sync", "ceu0"),
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_ceu.0", "pfc-r8a7740",
+				  "ceu0_field", "ceu0"),
 	/* GETHER */
 	PIN_MAP_MUX_GROUP_DEFAULT("sh-eth", "pfc-r8a7740",
 				  "gether_mii", "gether"),
@@ -1165,21 +1174,6 @@ static void __init eva_init(void)
 		usb = &usbhsf_device;
 	}
 
-	/* CEU0 */
-	gpio_request(GPIO_FN_VIO0_D7,		NULL);
-	gpio_request(GPIO_FN_VIO0_D6,		NULL);
-	gpio_request(GPIO_FN_VIO0_D5,		NULL);
-	gpio_request(GPIO_FN_VIO0_D4,		NULL);
-	gpio_request(GPIO_FN_VIO0_D3,		NULL);
-	gpio_request(GPIO_FN_VIO0_D2,		NULL);
-	gpio_request(GPIO_FN_VIO0_D1,		NULL);
-	gpio_request(GPIO_FN_VIO0_D0,		NULL);
-	gpio_request(GPIO_FN_VIO0_CLK,		NULL);
-	gpio_request(GPIO_FN_VIO0_HD,		NULL);
-	gpio_request(GPIO_FN_VIO0_VD,		NULL);
-	gpio_request(GPIO_FN_VIO0_FIELD,	NULL);
-	gpio_request(GPIO_FN_VIO_CKO,		NULL);
-
 	/* CON1/CON15 Camera */
 	gpio_request_one(173, GPIOF_OUT_INIT_LOW, NULL);  /* STANDBY */
 	gpio_request_one(172, GPIOF_OUT_INIT_HIGH, NULL); /* RST */
-- 
1.8.2.1
