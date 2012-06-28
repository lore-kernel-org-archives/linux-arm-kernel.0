From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 28 Jun 2012 11:45:03 +0800
Subject: [PATCH 07/11] ARM: dts: imx28-evk: add flexan devices
In-Reply-To: <1340855107-4664-1-git-send-email-shawn.guo@linaro.org>
References: <1340855107-4664-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1340855107-4664-8-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add flexan devices for imx28-evk board.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/boot/dts/imx28-evk.dts |   13 +++++++++++++
 arch/arm/boot/dts/imx28.dtsi    |   24 ++++++++++++++++++++++++
 2 files changed, 37 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/imx28-evk.dts b/arch/arm/boot/dts/imx28-evk.dts
index cf2ab2e..17bf6cf 100644
--- a/arch/arm/boot/dts/imx28-evk.dts
+++ b/arch/arm/boot/dts/imx28-evk.dts
@@ -65,6 +65,19 @@
 					fsl,pull-up = <0>;
 				};
 			};
+
+			can0: can at 80032000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&can0_pins_a>;
+				phy-enable-gpios = <&gpio2 13 0>;
+				status = "okay";
+			};
+
+			can1: can at 80034000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&can1_pins_a>;
+				status = "okay";
+			};
 		};
 
 		apbx at 80040000 {
diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index 42d6078..03ddaac 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -364,6 +364,28 @@
 					fsl,voltage = <1>;
 					fsl,pull-up = <1>;
 				};
+
+				can0_pins_a: can0 at 0 {
+					reg = <0>;
+					fsl,pinmux-ids = <
+						0x0161 /* MX28_PAD_GPMI_RDY2__CAN0_TX */
+						0x0171 /* MX28_PAD_GPMI_RDY3__CAN0_RX */
+					>;
+					fsl,drive-strength = <0>;
+					fsl,voltage = <1>;
+					fsl,pull-up = <0>;
+				};
+
+				can1_pins_a: can1 at 0 {
+					reg = <0>;
+					fsl,pinmux-ids = <
+						0x0121 /* MX28_PAD_GPMI_CE2N__CAN1_TX */
+						0x0131 /* MX28_PAD_GPMI_CE3N__CAN1_RX */
+					>;
+					fsl,drive-strength = <0>;
+					fsl,voltage = <1>;
+					fsl,pull-up = <0>;
+				};
 			};
 
 			digctl at 8001c000 {
@@ -411,12 +433,14 @@
 			};
 
 			can0: can at 80032000 {
+				compatible = "fsl,imx28-flexcan", "fsl,p1010-flexcan";
 				reg = <0x80032000 2000>;
 				interrupts = <8>;
 				status = "disabled";
 			};
 
 			can1: can at 80034000 {
+				compatible = "fsl,imx28-flexcan", "fsl,p1010-flexcan";
 				reg = <0x80034000 2000>;
 				interrupts = <9>;
 				status = "disabled";
-- 
1.7.5.4
