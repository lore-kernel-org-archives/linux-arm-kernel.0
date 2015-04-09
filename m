From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Thu,  9 Apr 2015 09:23:43 +0100
Subject: [PATCH 08/10] ARM: dts: qcom: Add DT alias for serial port
In-Reply-To: <1428567674-10672-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1428567674-10672-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1428567823-11062-1-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Pramod Gurav <pramod.gurav@smartplayin.com>

Define an alias for serial port present on ifc6410 which is used as
console.

Signed-off-by: Pramod Gurav <pramod.gurav@smartplayin.com>
---
 arch/arm/boot/dts/qcom-apq8064-ifc6410.dts | 4 ++++
 arch/arm/boot/dts/qcom-apq8064.dtsi        | 3 +--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts b/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts
index d39a5bb..b76a92b 100644
--- a/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts
+++ b/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts
@@ -5,6 +5,10 @@
 	model = "Qualcomm APQ8064/IFC6410";
 	compatible = "qcom,apq8064-ifc6410", "qcom,apq8064";
 
+	aliases {
+		serial0 = &serial0;
+	};
+
 	soc {
 		pinctrl at 800000 {
 			i2c1_pins: i2c1 {
diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
index 70e417f..f4b8c3a 100644
--- a/arch/arm/boot/dts/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
@@ -252,10 +252,9 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges;
-
 			syscon-tcsr = <&tcsr>;
 
-			serial at 16640000 {
+			serial0: serial at 16640000 {
 				compatible = "qcom,msm-uartdm-v1.3", "qcom,msm-uartdm";
 				reg = <0x16640000 0x1000>,
 				      <0x16600000 0x1000>;
-- 
1.9.1
