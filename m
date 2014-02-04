From: Ying.Liu@freescale.com (Liu Ying)
Date: Tue, 4 Feb 2014 21:57:42 +0800
Subject: [PATCH] ARM: dts: i.MX51 babbage: Support diagnostic LED
Message-ID: <1391522263-17877-1-git-send-email-Ying.Liu@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The D25 LED controlled by gpio on the i.MX51 babbage
board is a diagnostic LED according to the board design.
This patch adds the relevant device tree nodes to the
i.MX51 babbage device tree file to support this LED.

Signed-off-by: Liu Ying <Ying.Liu@freescale.com>
---
 arch/arm/boot/dts/imx51-babbage.dts |   17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/boot/dts/imx51-babbage.dts b/arch/arm/boot/dts/imx51-babbage.dts
index be1407c..8d6a74b 100644
--- a/arch/arm/boot/dts/imx51-babbage.dts
+++ b/arch/arm/boot/dts/imx51-babbage.dts
@@ -81,6 +81,17 @@
 		};
 	};
 
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&led_pin_gpio2_6>;
+
+		led-diagnostic {
+			label = "diagnostic";
+			gpios = <&gpio2 6 0>;
+		};
+	};
+
 	sound {
 		compatible = "fsl,imx51-babbage-sgtl5000",
 			     "fsl,imx-audio-sgtl5000";
@@ -280,6 +291,12 @@
 				MX51_PAD_CSPI1_RDY__GPIO4_26 0x80000000
 			>;
 		};
+
+		led_pin_gpio2_6: led_gpio2_6 {
+			fsl,pins = <
+				MX51_PAD_EIM_D22__GPIO2_6 0x80000000
+			>;
+		};
 	};
 };
 
-- 
1.7.9.5
