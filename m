From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 27 Feb 2012 15:06:04 +0800
Subject: [PATCH] ARM: dts: imx51-babbage: update mc13892 device
Message-ID: <1330326364-726-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It adds regulators, removes invalid property fsl,mc13xxx-uses-regulator,
and fixes interrupt for mc13892.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/boot/dts/imx51-babbage.dts |   91 ++++++++++++++++++++++++++++++++++-
 1 files changed, 89 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx51-babbage.dts b/arch/arm/boot/dts/imx51-babbage.dts
index 564cb8c..9949e60 100644
--- a/arch/arm/boot/dts/imx51-babbage.dts
+++ b/arch/arm/boot/dts/imx51-babbage.dts
@@ -56,8 +56,95 @@
 						compatible = "fsl,mc13892";
 						spi-max-frequency = <6000000>;
 						reg = <0>;
-						mc13xxx-irq-gpios = <&gpio1 8 0>;
-						fsl,mc13xxx-uses-regulator;
+						interrupt-parent = <&gpio1>;
+						interrupts = <8>;
+
+						regulators {
+							sw1_reg: sw1 {
+								regulator-min-microvolt = <600000>;
+								regulator-max-microvolt = <1375000>;
+								regulator-boot-on;
+								regulator-always-on;
+							};
+
+							sw2_reg: sw2 {
+								regulator-min-microvolt = <900000>;
+								regulator-max-microvolt = <1850000>;
+								regulator-boot-on;
+								regulator-always-on;
+							};
+
+							sw3_reg: sw3 {
+								regulator-min-microvolt = <1100000>;
+								regulator-max-microvolt = <1850000>;
+								regulator-boot-on;
+								regulator-always-on;
+							};
+
+							sw4_reg: sw4 {
+								regulator-min-microvolt = <1100000>;
+								regulator-max-microvolt = <1850000>;
+								regulator-boot-on;
+								regulator-always-on;
+							};
+
+							vpll_reg: vpll {
+								regulator-min-microvolt = <1050000>;
+								regulator-max-microvolt = <1800000>;
+								regulator-boot-on;
+								regulator-always-on;
+							};
+
+							vdig_reg: vdig {
+								regulator-min-microvolt = <1650000>;
+								regulator-max-microvolt = <1650000>;
+								regulator-boot-on;
+							};
+
+							vsd_reg: vsd {
+								regulator-min-microvolt = <1800000>;
+								regulator-max-microvolt = <3150000>;
+							};
+
+							vusb2_reg: vusb2 {
+								regulator-min-microvolt = <2400000>;
+								regulator-max-microvolt = <2775000>;
+								regulator-boot-on;
+								regulator-always-on;
+							};
+
+							vvideo_reg: vvideo {
+								regulator-min-microvolt = <2775000>;
+								regulator-max-microvolt = <2775000>;
+							};
+
+							vaudio_reg: vaudio {
+								regulator-min-microvolt = <2300000>;
+								regulator-max-microvolt = <3000000>;
+							};
+
+							vcam_reg: vcam {
+								regulator-min-microvolt = <2500000>;
+								regulator-max-microvolt = <3000000>;
+							};
+
+							vgen1_reg: vgen1 {
+								regulator-min-microvolt = <1200000>;
+								regulator-max-microvolt = <1200000>;
+							};
+
+							vgen2_reg: vgen2 {
+								regulator-min-microvolt = <1200000>;
+								regulator-max-microvolt = <3150000>;
+								regulator-always-on;
+							};
+
+							vgen3_reg: vgen3 {
+								regulator-min-microvolt = <1800000>;
+								regulator-max-microvolt = <2900000>;
+								regulator-always-on;
+							};
+						};
 					};
 
 					flash: at45db321d at 1 {
-- 
1.7.5.4
