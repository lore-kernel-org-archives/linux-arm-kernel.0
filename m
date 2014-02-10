From: Ying.Liu@freescale.com (Liu Ying)
Date: Mon, 10 Feb 2014 15:05:46 +0800
Subject: [PATCH v2] ARM: dts: i.MX51 babbage: Support diagnostic LED
Message-ID: <1392015946-22419-1-git-send-email-Ying.Liu@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The D25 LED controlled by gpio on the i.MX51 babbage
board is a diagnostic LED according to the board design.
This patch adds the relevant device tree nodes to the
i.MX51 babbage device tree file to support this LED.

Signed-off-by: Liu Ying <Ying.Liu@freescale.com>
---
v1->v2:
* Rebase the patch from 3.14-rc2 to linux-next(d371ca32be).
* Rename the pinctrl name for the LED to be more generic.
* Switch to use the standard GPIO flag GPIO_ACTIVE_HIGH.

 arch/arm/boot/dts/imx51-babbage.dts |   17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/boot/dts/imx51-babbage.dts b/arch/arm/boot/dts/imx51-babbage.dts
index ea5c67e..121dadd 100644
--- a/arch/arm/boot/dts/imx51-babbage.dts
+++ b/arch/arm/boot/dts/imx51-babbage.dts
@@ -81,6 +81,17 @@
 		};
 	};
 
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_gpio_leds>;
+
+		led-diagnostic {
+			label = "diagnostic";
+			gpios = <&gpio2 6 GPIO_ACTIVE_HIGH>;
+		};
+	};
+
 	sound {
 		compatible = "fsl,imx51-babbage-sgtl5000",
 			     "fsl,imx-audio-sgtl5000";
@@ -344,6 +355,12 @@
 			>;
 		};
 
+		pinctrl_gpio_leds: gpioledsgrp {
+			fsl,pins = <
+				MX51_PAD_EIM_D22__GPIO2_6		0x80000000
+			>;
+		};
+
 		pinctrl_i2c2: i2c2grp {
 			fsl,pins = <
 				MX51_PAD_KEY_COL4__I2C2_SCL		0x400001ed
-- 
1.7.9.5
