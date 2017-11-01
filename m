From: damien.riegel@savoirfairelinux.com (Damien Riegel)
Date: Wed,  1 Nov 2017 13:53:35 -0400
Subject: [PATCH 4/4] arm64: dts: qcom: msm8916: add bindings for i2c1, i2c3,
 i2c5
In-Reply-To: <20171101175335.22123-1-damien.riegel@savoirfairelinux.com>
References: <20171101175335.22123-1-damien.riegel@savoirfairelinux.com>
Message-ID: <20171101175335.22123-5-damien.riegel@savoirfairelinux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Damien Riegel <damien.riegel@savoirfairelinux.com>
---
 arch/arm64/boot/dts/qcom/msm8916-pins.dtsi | 72 ++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/msm8916.dtsi      | 45 +++++++++++++++++++
 2 files changed, 117 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8916-pins.dtsi b/arch/arm64/boot/dts/qcom/msm8916-pins.dtsi
index c67ad8ed8b60..1cec5b30ed6e 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-pins.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916-pins.dtsi
@@ -270,6 +270,30 @@
 		};
 	};
 
+	i2c1_default: i2c1_default {
+		pinmux {
+			function = "blsp_i2c1";
+			pins = "gpio2", "gpio3";
+		};
+		pinconf {
+			pins = "gpio2", "gpio3";
+			drive-strength = <16>;
+			bias-disable;
+		};
+	};
+
+	i2c1_sleep: i2c1_sleep {
+		pinmux {
+			function = "gpio";
+			pins = "gpio2", "gpio3";
+		};
+		pinconf {
+			pins = "gpio2", "gpio3";
+			drive-strength = <2>;
+			bias-disable;
+		};
+	};
+
 	i2c2_default: i2c2_default {
 		pinmux {
 			function = "blsp_i2c2";
@@ -294,6 +318,30 @@
 		};
 	};
 
+	i2c3_default: i2c3_default {
+		pinmux {
+			function = "blsp_i2c3";
+			pins = "gpio10", "gpio11";
+		};
+		pinconf {
+			pins = "gpio10", "gpio11";
+			drive-strength = <16>;
+			bias-disable;
+		};
+	};
+
+	i2c3_sleep: i2c3_sleep {
+		pinmux {
+			function = "gpio";
+			pins = "gpio10", "gpio11";
+		};
+		pinconf {
+			pins = "gpio10", "gpio11";
+			drive-strength = <2>;
+			bias-disable;
+		};
+	};
+
 	i2c4_default: i2c4_default {
 		pinmux {
 			function = "blsp_i2c4";
@@ -318,6 +366,30 @@
 		};
 	};
 
+	i2c5_default: i2c5_default {
+		pinmux {
+			function = "blsp_i2c5";
+			pins = "gpio18", "gpio19";
+		};
+		pinconf {
+			pins = "gpio18", "gpio19";
+			drive-strength = <16>;
+			bias-disable;
+		};
+	};
+
+	i2c5_sleep: i2c5_sleep {
+		pinmux {
+			function = "gpio";
+			pins = "gpio18", "gpio19";
+		};
+		pinconf {
+			pins = "gpio18", "gpio19";
+			drive-strength = <2>;
+			bias-disable;
+		};
+	};
+
 	i2c6_default: i2c6_default {
 		pinmux {
 			function = "blsp_i2c6";
diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index de25bd6070f5..bdc4cb6f66d4 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -455,6 +455,21 @@
 			status = "disabled";
 		};
 
+		blsp_i2c1: i2c at 78b5000 {
+			compatible = "qcom,i2c-qup-v2.2.1";
+			reg = <0x078b5000 0x600>;
+			interrupts = <GIC_SPI 95 0>;
+			clocks = <&gcc GCC_BLSP1_AHB_CLK>,
+				 <&gcc GCC_BLSP1_QUP1_I2C_APPS_CLK>;
+			clock-names = "iface", "core";
+			pinctrl-names = "default", "sleep";
+			pinctrl-0 = <&i2c1_default>;
+			pinctrl-1 = <&i2c1_sleep>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
 		blsp_i2c2: i2c at 78b6000 {
 			compatible = "qcom,i2c-qup-v2.2.1";
 			reg = <0x078b6000 0x600>;
@@ -470,6 +485,21 @@
 			status = "disabled";
 		};
 
+		blsp_i2c3: i2c at 78b7000 {
+			compatible = "qcom,i2c-qup-v2.2.1";
+			reg = <0x078b7000 0x600>;
+			interrupts = <GIC_SPI 97 0>;
+			clocks = <&gcc GCC_BLSP1_AHB_CLK>,
+				 <&gcc GCC_BLSP1_QUP3_I2C_APPS_CLK>;
+			clock-names = "iface", "core";
+			pinctrl-names = "default", "sleep";
+			pinctrl-0 = <&i2c3_default>;
+			pinctrl-1 = <&i2c3_sleep>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
 		blsp_i2c4: i2c at 78b8000 {
 			compatible = "qcom,i2c-qup-v2.2.1";
 			reg = <0x078b8000 0x600>;
@@ -485,6 +515,21 @@
 			status = "disabled";
 		};
 
+		blsp_i2c5: i2c at 78b9000 {
+			compatible = "qcom,i2c-qup-v2.2.1";
+			reg = <0x078b9000 0x600>;
+			interrupts = <GIC_SPI 99 0>;
+			clocks = <&gcc GCC_BLSP1_AHB_CLK>,
+				 <&gcc GCC_BLSP1_QUP5_I2C_APPS_CLK>;
+			clock-names = "iface", "core";
+			pinctrl-names = "default", "sleep";
+			pinctrl-0 = <&i2c5_default>;
+			pinctrl-1 = <&i2c5_sleep>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
 		blsp_i2c6: i2c at 78ba000 {
 			compatible = "qcom,i2c-qup-v2.2.1";
 			reg = <0x078ba000 0x600>;
-- 
2.15.0
