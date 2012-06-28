From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 28 Jun 2012 11:45:00 +0800
Subject: [PATCH 04/11] ARM: dts: imx23-evk: add auart device
In-Reply-To: <1340855107-4664-1-git-send-email-shawn.guo@linaro.org>
References: <1340855107-4664-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1340855107-4664-5-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add auart device for imx23-evk board.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/boot/dts/imx23-evk.dts |    6 ++++++
 arch/arm/boot/dts/imx23.dtsi    |   19 +++++++++++++++++++
 2 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/imx23-evk.dts b/arch/arm/boot/dts/imx23-evk.dts
index 8321fa3..9eca34f 100644
--- a/arch/arm/boot/dts/imx23-evk.dts
+++ b/arch/arm/boot/dts/imx23-evk.dts
@@ -51,6 +51,12 @@
 		};
 
 		apbx at 80040000 {
+			auart0: serial at 8006c000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&auart0_pins_a>;
+				status = "okay";
+			};
+
 			duart: serial at 80070000 {
 				pinctrl-names = "default";
 				pinctrl-0 = <&duart_pins_a>;
diff --git a/arch/arm/boot/dts/imx23.dtsi b/arch/arm/boot/dts/imx23.dtsi
index daade4f..e78c1f4 100644
--- a/arch/arm/boot/dts/imx23.dtsi
+++ b/arch/arm/boot/dts/imx23.dtsi
@@ -18,6 +18,8 @@
 		gpio0 = &gpio0;
 		gpio1 = &gpio1;
 		gpio2 = &gpio2;
+		serial0 = &auart0;
+		serial1 = &auart1;
 	};
 
 	cpus {
@@ -123,6 +125,19 @@
 					fsl,pull-up = <0>;
 				};
 
+				auart0_pins_a: auart0 at 0 {
+					reg = <0>;
+					fsl,pinmux-ids = <
+						0x01c0 /* MX23_PAD_AUART1_RX__AUART1_RX */
+						0x01d0 /* MX23_PAD_AUART1_TX__AUART1_TX */
+						0x01a0 /* MX23_PAD_AUART1_CTS__AUART1_CTS */
+						0x01b0 /* MX23_PAD_AUART1_RTS__AUART1_RTS */
+					>;
+					fsl,drive-strength = <0>;
+					fsl,voltage = <1>;
+					fsl,pull-up = <0>;
+				};
+
 				mmc0_4bit_pins_a: mmc0-4bit at 0 {
 					reg = <0>;
 					fsl,pinmux-ids = <
@@ -289,12 +304,16 @@
 			};
 
 			auart0: serial@8006c000 {
+				compatible = "fsl,imx23-auart";
 				reg = <0x8006c000 0x2000>;
+				interrupts = <24 25 23>;
 				status = "disabled";
 			};
 
 			auart1: serial at 8006e000 {
+				compatible = "fsl,imx23-auart";
 				reg = <0x8006e000 0x2000>;
+				interrupts = <59 60 58>;
 				status = "disabled";
 			};
 
-- 
1.7.5.4
