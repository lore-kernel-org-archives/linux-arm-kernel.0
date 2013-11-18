From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 18 Nov 2013 15:37:52 +0100
Subject: [PATCH] ARM: mxs: cfa10049: Add NAU7802 ADCs to the device tree
Message-ID: <1384785472-16544-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Crystalfontz CFA-10049 has 3 Nuvoton NAU7802 ADCs, plugged behing a
GPIO-controlled I2C muxer because these ADCs don't have a configurable
address.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/imx28-cfa10049.dts | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/imx28-cfa10049.dts b/arch/arm/boot/dts/imx28-cfa10049.dts
index 06e4cfaf7dd2..9a0e913e92aa 100644
--- a/arch/arm/boot/dts/imx28-cfa10049.dts
+++ b/arch/arm/boot/dts/imx28-cfa10049.dts
@@ -229,15 +229,39 @@
 				i2c-parent = <&i2c1>;
 
 				i2c at 0 {
+					#address-cells = <1>;
+					#size-cells = <0>;
 					reg = <0>;
+
+					adc0: nau7802 at 2a {
+						compatible = "nuvoton,nau7802";
+						reg = <0x2a>;
+						nuvoton,vldo = <3000>;
+					};
 				};
 
 				i2c at 1 {
+					#address-cells = <1>;
+					#size-cells = <0>;
 					reg = <1>;
+
+					adc1: nau7802 at 2a {
+						compatible = "nuvoton,nau7802";
+						reg = <0x2a>;
+						nuvoton,vldo = <3000>;
+					};
 				};
 
 				i2c at 2 {
+					#address-cells = <1>;
+					#size-cells = <0>;
 					reg = <2>;
+
+					adc2: nau7802 at 2a {
+						compatible = "nuvoton,nau7802";
+						reg = <0x2a>;
+						nuvoton,vldo = <3000>;
+					};
 				};
 
 				i2c at 3 {
-- 
1.8.4.2
