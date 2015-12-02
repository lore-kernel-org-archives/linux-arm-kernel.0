From: stefan@agner.ch (Stefan Agner)
Date: Wed,  2 Dec 2015 14:11:47 -0800
Subject: [PATCH 2/2] ARM: dts: vf-colibri: add CAN support
In-Reply-To: <1449094307-6011-1-git-send-email-stefan@agner.ch>
References: <1449094307-6011-1-git-send-email-stefan@agner.ch>
Message-ID: <1449094307-6011-2-git-send-email-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add Colibri standard pinmux for FlexCAN controller instances. CAN
is not a standard Colibri feature, but the datasheet predefines
pins which provide CAN (compatible across some modules). Hence,
add the pinmux on module level.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/boot/dts/vf-colibri.dtsi | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm/boot/dts/vf-colibri.dtsi b/arch/arm/boot/dts/vf-colibri.dtsi
index 924b660..4f798a8 100644
--- a/arch/arm/boot/dts/vf-colibri.dtsi
+++ b/arch/arm/boot/dts/vf-colibri.dtsi
@@ -23,6 +23,18 @@
 	status = "okay";
 };
 
+&can0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_flexcan0>;
+	status = "disabled";
+};
+
+&can1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_flexcan1>;
+	status = "disabled";
+};
+
 &dspi1 {
 	bus-num = <1>;
 	pinctrl-names = "default";
@@ -125,6 +137,20 @@
 
 &iomuxc {
 	vf610-colibri {
+		pinctrl_flexcan0: can0grp {
+			fsl,pins = <
+				VF610_PAD_PTB14__CAN0_RX	0x31F1
+				VF610_PAD_PTB15__CAN0_TX	0x31F2
+			>;
+		};
+
+		pinctrl_flexcan1: can1grp {
+			fsl,pins = <
+				VF610_PAD_PTB16__CAN1_RX	0x31F1
+				VF610_PAD_PTB17__CAN1_TX	0x31F2
+			>;
+		};
+
 		pinctrl_gpio_ext: gpio_ext {
 			fsl,pins = <
 				VF610_PAD_PTD10__GPIO_89	0x22ed /* EXT_IO_0 */
-- 
2.6.2
