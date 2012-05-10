From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 10 May 2012 15:31:03 +0800
Subject: [PATCH 2/2] ARM: dts: enable i2c device for imx28-evk
In-Reply-To: <1336635063-11122-1-git-send-email-shawn.guo@linaro.org>
References: <1336635063-11122-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1336635063-11122-3-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/boot/dts/imx28-evk.dts |    6 ++++++
 arch/arm/boot/dts/imx28.dtsi    |   14 ++++++++++++++
 2 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/imx28-evk.dts b/arch/arm/boot/dts/imx28-evk.dts
index 6ca10f2..c4b717f 100644
--- a/arch/arm/boot/dts/imx28-evk.dts
+++ b/arch/arm/boot/dts/imx28-evk.dts
@@ -41,6 +41,12 @@
 		};
 
 		apbx at 80040000 {
+			i2c0: i2c at 80058000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&i2c0_pins_a>;
+				status = "okay";
+			};
+
 			duart: serial at 80074000 {
 				pinctrl-names = "default";
 				pinctrl-0 = <&duart_pins_a>;
diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index 8596bdf..fd73fc2 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -204,6 +204,14 @@
 					fsl,drive-strength = <2>;
 					fsl,pull-up = <0>;
 				};
+
+				i2c0_pins_a: i2c0 at 0 {
+					reg = <0>;
+					fsl,pinmux-ids = <0x3180 0x3190>;
+					fsl,drive-strength = <1>;
+					fsl,voltage = <1>;
+					fsl,pull-up = <1>;
+				};
 			};
 
 			digctl at 8001c000 {
@@ -345,12 +353,18 @@
 			};
 
 			i2c0: i2c at 80058000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,imx28-i2c";
 				reg = <0x80058000 2000>;
 				interrupts = <111 68>;
 				status = "disabled";
 			};
 
 			i2c1: i2c at 8005a000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,imx28-i2c";
 				reg = <0x8005a000 2000>;
 				interrupts = <110 69>;
 				status = "disabled";
-- 
1.7.5.4
