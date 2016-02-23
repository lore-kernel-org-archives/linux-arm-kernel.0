From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Tue, 23 Feb 2016 14:11:10 +0000
Subject: [PATCH 01/12] ARM: dts: qcom: fix i2c lables to be inline with others
In-Reply-To: <1456236639-1379-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1456236639-1379-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1456236670-1423-1-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes i2c lables to be inline with serial labels.
The reason to do this is that it would look odd if we add aliases in the
board file along with serial.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm/boot/dts/qcom-apq8064-ifc6410.dts | 2 +-
 arch/arm/boot/dts/qcom-apq8064.dtsi        | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts b/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts
index fd4d49e..0073294 100644
--- a/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts
+++ b/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts
@@ -157,7 +157,7 @@
 		gsbi3: gsbi at 16200000 {
 			status = "okay";
 			qcom,mode = <GSBI_PROT_I2C>;
-			i2c3: i2c at 16280000 {
+			i2c at 16280000 {
 				status = "okay";
 			};
 		};
diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
index 394c43b..a7af35d 100644
--- a/arch/arm/boot/dts/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
@@ -281,7 +281,7 @@
 
 			syscon-tcsr = <&tcsr>;
 
-			i2c1: i2c at 12460000 {
+			gsbi1_i2c: i2c at 12460000 {
 				compatible = "qcom,i2c-qup-v1.1.1";
 				pinctrl-0 = <&i2c1_pins>;
 				pinctrl-names = "default";
@@ -307,7 +307,7 @@
 
 			syscon-tcsr = <&tcsr>;
 
-			i2c2: i2c at 124a0000 {
+			gsbi2_i2c: i2c at 124a0000 {
 				compatible = "qcom,i2c-qup-v1.1.1";
 				reg = <0x124a0000 0x1000>;
 				interrupts = <0 196 IRQ_TYPE_NONE>;
@@ -328,7 +328,7 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges;
-			i2c3: i2c at 16280000 {
+			gsbi3_i2c: i2c at 16280000 {
 				compatible = "qcom,i2c-qup-v1.1.1";
 				pinctrl-0 = <&i2c3_pins>;
 				pinctrl-names = "default";
-- 
1.9.1
