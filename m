From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 28 Nov 2011 21:37:19 +0800
Subject: [PATCH 5/5] arm/imx: add mc13892 support into imx51-babbage.dts
In-Reply-To: <1322487439-27254-1-git-send-email-shawn.guo@linaro.org>
References: <1322487439-27254-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1322487439-27254-6-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It adds mc13892 support into imx51-babbage device tree source.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/boot/dts/imx51-babbage.dts |  100 ++++++++++++++++++++++++++++++++++-
 1 files changed, 99 insertions(+), 1 deletions(-)

diff --git a/arch/arm/boot/dts/imx51-babbage.dts b/arch/arm/boot/dts/imx51-babbage.dts
index f8766af..97d832b 100644
--- a/arch/arm/boot/dts/imx51-babbage.dts
+++ b/arch/arm/boot/dts/imx51-babbage.dts
@@ -31,12 +31,14 @@
 				esdhc at 70004000 { /* ESDHC1 */
 					fsl,cd-internal;
 					fsl,wp-internal;
+					vmmc-supply = <&vsd_reg>;
 					status = "okay";
 				};
 
 				esdhc at 70008000 { /* ESDHC2 */
 					cd-gpios = <&gpio0 6 0>; /* GPIO1_6 */
 					wp-gpios = <&gpio0 5 0>; /* GPIO1_5 */
+					vmmc-supply = <&vsd_reg>;
 					status = "okay";
 				};
 
@@ -58,7 +60,103 @@
 						spi-max-frequency = <6000000>;
 						reg = <0>;
 						mc13xxx-irq-gpios = <&gpio0 8 0>; /* GPIO1_8 */
-						fsl,mc13xxx-uses-regulator;
+
+						regulators {
+							sw1_reg: mc13892__sw1 {
+								regulator-min-microvolt = <600000>;
+								regulator-max-microvolt = <1375000>;
+								regulator-boot-on;
+								regulator-always-on;
+							};
+
+							sw2_reg: mc13892__sw2 {
+								regulator-min-microvolt = <900000>;
+								regulator-max-microvolt = <1850000>;
+								regulator-boot-on;
+								regulator-always-on;
+							};
+
+							sw3_reg: mc13892__sw3 {
+								regulator-min-microvolt = <1100000>;
+								regulator-max-microvolt = <1850000>;
+								regulator-boot-on;
+								regulator-always-on;
+							};
+
+							sw4_reg: mc13892__sw4 {
+								regulator-min-microvolt = <1100000>;
+								regulator-max-microvolt = <1850000>;
+								regulator-boot-on;
+								regulator-always-on;
+							};
+
+							viohi_reg: mc13892__viohi {
+								regulator-boot-on;
+								regulator-always-on;
+							};
+
+							vpll_reg: mc13892__vpll {
+								regulator-min-microvolt = <1050000>;
+								regulator-max-microvolt = <1800000>;
+								regulator-boot-on;
+								regulator-always-on;
+							};
+
+							vdig_reg: mc13892__vdig {
+								regulator-min-microvolt = <1650000>;
+								regulator-max-microvolt = <1650000>;
+								regulator-boot-on;
+							};
+
+							vsd_reg: mc13892__vsd {
+								regulator-min-microvolt = <1800000>;
+								regulator-max-microvolt = <3150000>;
+							};
+
+							vusb2_reg: mc13892__vusb2 {
+								regulator-min-microvolt = <2400000>;
+								regulator-max-microvolt = <2775000>;
+								regulator-boot-on;
+								regulator-always-on;
+							};
+
+							vvideo_reg: mc13892__vvideo {
+								regulator-min-microvolt = <2775000>;
+								regulator-max-microvolt = <2775000>;
+							};
+
+							vaudio_reg: mc13892__vaudio {
+								regulator-min-microvolt = <2300000>;
+								regulator-max-microvolt = <3000000>;
+							};
+
+							vcam_reg: mc13892__vcam {
+								regulator-min-microvolt = <2500000>;
+								regulator-max-microvolt = <3000000>;
+							};
+
+							vgen1_reg: mc13892__vgen1 {
+								regulator-min-microvolt = <1200000>;
+								regulator-max-microvolt = <1200000>;
+							};
+
+							vgen2_reg: mc13892__vgen2 {
+								regulator-min-microvolt = <1200000>;
+								regulator-max-microvolt = <3150000>;
+								regulator-always-on;
+							};
+
+							vgen3_reg: mc13892__vgen3 {
+								regulator-min-microvolt = <1800000>;
+								regulator-max-microvolt = <2900000>;
+								regulator-always-on;
+							};
+
+							vusb_reg: mc13892__vusb {
+								regulator-boot-on;
+								regulator-always-on;
+							};
+						};
 					};
 
 					flash: at45db321d at 1 {
-- 
1.7.4.1
