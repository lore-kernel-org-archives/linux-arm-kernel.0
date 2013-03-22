From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 22 Mar 2013 10:23:51 +0900
Subject: [PATCH 5/6] ARM: shmobile: kzm9g-reference: fix device-tree bindings
 and device names
In-Reply-To: <1363915432-21720-1-git-send-email-horms+renesas@verge.net.au>
References: <1363915432-21720-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1363915432-21720-6-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Fix several device-tree bindings, that haven't been updated for newest
versions of respective drivers, and device names and pin numbers, left over
from non-DT and old pinctrl versions.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/sh73a0.dtsi                  |   12 +++++------
 arch/arm/mach-shmobile/board-kzm9g-reference.c |   27 ++++++++++++------------
 2 files changed, 19 insertions(+), 20 deletions(-)

diff --git a/arch/arm/boot/dts/sh73a0.dtsi b/arch/arm/boot/dts/sh73a0.dtsi
index c89be38..3e4d383 100644
--- a/arch/arm/boot/dts/sh73a0.dtsi
+++ b/arch/arm/boot/dts/sh73a0.dtsi
@@ -109,36 +109,36 @@
 	};
 
 	sdhi0: sdhi at 0xee100000 {
-		compatible = "renesas,shmobile-sdhi";
+		compatible = "renesas,r8a7740-sdhi";
 		reg = <0xee100000 0x100>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 83 4
 				0 84 4
 				0 85 4>;
-		toshiba,mmc-has-idle-wait;
+		cap-sd-highspeed;
 		status = "disabled";
 	};
 
 	/* SDHI1 and SDHI2 have no CD pins, no need for CD IRQ */
 	sdhi1: sdhi at 0xee120000 {
-		compatible = "renesas,shmobile-sdhi";
+		compatible = "renesas,r8a7740-sdhi";
 		reg = <0xee120000 0x100>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 88 4
 				0 89 4>;
 		toshiba,mmc-wrprotect-disable;
-		toshiba,mmc-has-idle-wait;
+		cap-sd-highspeed;
 		status = "disabled";
 	};
 
 	sdhi2: sdhi at 0xee140000 {
-		compatible = "renesas,shmobile-sdhi";
+		compatible = "renesas,r8a7740-sdhi";
 		reg = <0xee140000 0x100>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 104 4
 				0 105 4>;
 		toshiba,mmc-wrprotect-disable;
-		toshiba,mmc-has-idle-wait;
+		cap-sd-highspeed;
 		status = "disabled";
 	};
 };
diff --git a/arch/arm/mach-shmobile/board-kzm9g-reference.c b/arch/arm/mach-shmobile/board-kzm9g-reference.c
index e93473c..aefa50d 100644
--- a/arch/arm/mach-shmobile/board-kzm9g-reference.c
+++ b/arch/arm/mach-shmobile/board-kzm9g-reference.c
@@ -40,16 +40,16 @@ static unsigned long pin_pullup_conf[] = {
 };
 
 static const struct pinctrl_map kzm_pinctrl_map[] = {
-	PIN_MAP_MUX_GROUP_DEFAULT("i2c-sh_mobile.3", "pfc-sh73a0",
+	PIN_MAP_MUX_GROUP_DEFAULT("e6826000.i2c", "pfc-sh73a0",
 				  "i2c3_1", "i2c3"),
 	/* MMCIF */
-	PIN_MAP_MUX_GROUP_DEFAULT("sh_mmcif.0", "pfc-sh73a0",
+	PIN_MAP_MUX_GROUP_DEFAULT("e6bd0000.mmcif", "pfc-sh73a0",
 				  "mmc0_data8_0", "mmc0"),
-	PIN_MAP_MUX_GROUP_DEFAULT("sh_mmcif.0", "pfc-sh73a0",
+	PIN_MAP_MUX_GROUP_DEFAULT("e6bd0000.mmcif", "pfc-sh73a0",
 				  "mmc0_ctrl_0", "mmc0"),
-	PIN_MAP_CONFIGS_PIN_DEFAULT("sh_mmcif.0", "pfc-sh73a0",
+	PIN_MAP_CONFIGS_PIN_DEFAULT("e6bd0000.mmcif", "pfc-sh73a0",
 				    "PORT279", pin_pullup_conf),
-	PIN_MAP_CONFIGS_GROUP_DEFAULT("sh_mmcif.0", "pfc-sh73a0",
+	PIN_MAP_CONFIGS_GROUP_DEFAULT("e6bd0000.mmcif", "pfc-sh73a0",
 				      "mmc0_data8_0", pin_pullup_conf),
 	/* SCIFA4 */
 	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.4", "pfc-sh73a0",
@@ -57,18 +57,18 @@ static const struct pinctrl_map kzm_pinctrl_map[] = {
 	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.4", "pfc-sh73a0",
 				  "scifa4_ctrl", "scifa4"),
 	/* SDHI0 */
-	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.0", "pfc-sh73a0",
+	PIN_MAP_MUX_GROUP_DEFAULT("ee100000.sdhi", "pfc-sh73a0",
 				  "sdhi0_data4", "sdhi0"),
-	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.0", "pfc-sh73a0",
+	PIN_MAP_MUX_GROUP_DEFAULT("ee100000.sdhi", "pfc-sh73a0",
 				  "sdhi0_ctrl", "sdhi0"),
-	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.0", "pfc-sh73a0",
+	PIN_MAP_MUX_GROUP_DEFAULT("ee100000.sdhi", "pfc-sh73a0",
 				  "sdhi0_cd", "sdhi0"),
-	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.0", "pfc-sh73a0",
+	PIN_MAP_MUX_GROUP_DEFAULT("ee100000.sdhi", "pfc-sh73a0",
 				  "sdhi0_wp", "sdhi0"),
 	/* SDHI2 */
-	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.2", "pfc-sh73a0",
+	PIN_MAP_MUX_GROUP_DEFAULT("ee140000.sdhi", "pfc-sh73a0",
 				  "sdhi2_data4", "sdhi2"),
-	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.2", "pfc-sh73a0",
+	PIN_MAP_MUX_GROUP_DEFAULT("ee140000.sdhi", "pfc-sh73a0",
 				  "sdhi2_ctrl", "sdhi2"),
 };
 
@@ -80,10 +80,9 @@ static void __init kzm_init(void)
 
 	/* enable SD */
 	gpio_request(GPIO_FN_SDHI0_VCCQ_MC0_ON,	NULL);
-	gpio_request_one(GPIO_PORT15, GPIOF_OUT_INIT_HIGH, NULL); /* power */
+	gpio_request_one(15, GPIOF_OUT_INIT_HIGH, NULL); /* power */
 
-	gpio_request(GPIO_FN_SDHICLK2,		NULL);
-	gpio_request_one(GPIO_PORT14, GPIOF_OUT_INIT_HIGH, NULL); /* power */
+	gpio_request_one(14, GPIOF_OUT_INIT_HIGH, NULL); /* power */
 
 #ifdef CONFIG_CACHE_L2X0
 	/* Early BRESP enable, Shared attribute override enable, 64K*8way */
-- 
1.7.10.4
