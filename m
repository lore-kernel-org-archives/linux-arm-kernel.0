From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 18 Mar 2013 20:06:29 +0900
Subject: [PATCH 093/142] ARM: shmobile: kzm9g: Register pinctrl mappings for
 FSI
In-Reply-To: <1363604838-29359-1-git-send-email-horms+renesas@verge.net.au>
References: <1363604838-29359-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1363604838-29359-94-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Replace the GPIO-based FSI pinmux configuration by pinctrl mappings.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/mach-shmobile/board-kzm9g.c |   16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-kzm9g.c b/arch/arm/mach-shmobile/board-kzm9g.c
index df3c5ca..a628d1b 100644
--- a/arch/arm/mach-shmobile/board-kzm9g.c
+++ b/arch/arm/mach-shmobile/board-kzm9g.c
@@ -601,6 +601,15 @@ static struct platform_device *kzm_devices[] __initdata = {
 };
 
 static const struct pinctrl_map kzm_pinctrl_map[] = {
+	/* FSIA (AK4648) */
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_fsi2.0", "pfc-sh73a0",
+				  "fsia_mclk_in", "fsia"),
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_fsi2.0", "pfc-sh73a0",
+				  "fsia_sclk_in", "fsia"),
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_fsi2.0", "pfc-sh73a0",
+				  "fsia_data_in", "fsia"),
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_fsi2.0", "pfc-sh73a0",
+				  "fsia_data_out", "fsia"),
 	/* I2C3 */
 	PIN_MAP_MUX_GROUP_DEFAULT("i2c-sh_mobile.3", "pfc-sh73a0",
 				  "i2c3_1", "i2c3"),
@@ -727,13 +736,6 @@ static void __init kzm_init(void)
 	gpio_request(GPIO_FN_SDHICLK2,		NULL);
 	gpio_request_one(14, GPIOF_OUT_INIT_HIGH, NULL); /* power */
 
-	/* enable FSI2 port A (ak4648) */
-	gpio_request(GPIO_FN_FSIACK,	NULL);
-	gpio_request(GPIO_FN_FSIAILR,	NULL);
-	gpio_request(GPIO_FN_FSIAIBT,	NULL);
-	gpio_request(GPIO_FN_FSIAISLD,	NULL);
-	gpio_request(GPIO_FN_FSIAOSLD,	NULL);
-
 	/* enable USB */
 	gpio_request(GPIO_FN_VBUS_0,	NULL);
 
-- 
1.7.10.4
