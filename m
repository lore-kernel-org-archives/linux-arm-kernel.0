From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 18 Mar 2013 20:06:13 +0900
Subject: [PATCH 077/142] ARM: shmobile: ag5evm: Register pinctrl mappings for
 I2C
In-Reply-To: <1363604838-29359-1-git-send-email-horms+renesas@verge.net.au>
References: <1363604838-29359-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1363604838-29359-78-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Replace the GPIO-based I2C pinmux configuration by pinctrl mappings.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/mach-shmobile/board-ag5evm.c |   11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ag5evm.c b/arch/arm/mach-shmobile/board-ag5evm.c
index 5b8dcdc..e19dade 100644
--- a/arch/arm/mach-shmobile/board-ag5evm.c
+++ b/arch/arm/mach-shmobile/board-ag5evm.c
@@ -552,6 +552,11 @@ static struct platform_device *ag5evm_devices[] __initdata = {
 };
 
 static const struct pinctrl_map ag5evm_pinctrl_map[] = {
+	/* I2C2 & I2C3 */
+	PIN_MAP_MUX_GROUP_DEFAULT("i2c-sh_mobile.2", "pfc-sh73a0",
+				  "i2c2_0", "i2c2"),
+	PIN_MAP_MUX_GROUP_DEFAULT("i2c-sh_mobile.3", "pfc-sh73a0",
+				  "i2c3_0", "i2c3"),
 	/* SCIFA2 */
 	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.2", "pfc-sh73a0",
 				  "scifa2_data_0", "scifa2"),
@@ -591,12 +596,6 @@ static void __init ag5evm_init(void)
 	gpio_request(GPIO_FN_KEYOUT8, NULL);
 	gpio_request(GPIO_FN_PORT149_KEYOUT9, NULL);
 
-	/* enable I2C channel 2 and 3 */
-	gpio_request(GPIO_FN_PORT236_I2C_SDA2, NULL);
-	gpio_request(GPIO_FN_PORT237_I2C_SCL2, NULL);
-	gpio_request(GPIO_FN_PORT248_I2C_SCL3, NULL);
-	gpio_request(GPIO_FN_PORT249_I2C_SDA3, NULL);
-
 	/* enable MMCIF */
 	gpio_request(GPIO_FN_MMCCLK0, NULL);
 	gpio_request(GPIO_FN_MMCCMD0_PU, NULL);
-- 
1.7.10.4
