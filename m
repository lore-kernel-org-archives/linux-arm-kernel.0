From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 18 Mar 2013 20:06:28 +0900
Subject: [PATCH 092/142] ARM: shmobile: kzm9g: Register pinctrl mappings for
 I2C
In-Reply-To: <1363604838-29359-1-git-send-email-horms+renesas@verge.net.au>
References: <1363604838-29359-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1363604838-29359-93-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Replace the GPIO-based I2C pinmux configuration by pinctrl mappings.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/mach-shmobile/board-kzm9g.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-kzm9g.c b/arch/arm/mach-shmobile/board-kzm9g.c
index 3d2cdc4..df3c5ca 100644
--- a/arch/arm/mach-shmobile/board-kzm9g.c
+++ b/arch/arm/mach-shmobile/board-kzm9g.c
@@ -601,6 +601,9 @@ static struct platform_device *kzm_devices[] __initdata = {
 };
 
 static const struct pinctrl_map kzm_pinctrl_map[] = {
+	/* I2C3 */
+	PIN_MAP_MUX_GROUP_DEFAULT("i2c-sh_mobile.3", "pfc-sh73a0",
+				  "i2c3_1", "i2c3"),
 	/* LCD */
 	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_lcdc_fb.0", "pfc-sh73a0",
 				  "lcd_data24", "lcd"),
@@ -724,10 +727,6 @@ static void __init kzm_init(void)
 	gpio_request(GPIO_FN_SDHICLK2,		NULL);
 	gpio_request_one(14, GPIOF_OUT_INIT_HIGH, NULL); /* power */
 
-	/* I2C 3 */
-	gpio_request(GPIO_FN_PORT27_I2C_SCL3, NULL);
-	gpio_request(GPIO_FN_PORT28_I2C_SDA3, NULL);
-
 	/* enable FSI2 port A (ak4648) */
 	gpio_request(GPIO_FN_FSIACK,	NULL);
 	gpio_request(GPIO_FN_FSIAILR,	NULL);
-- 
1.7.10.4
