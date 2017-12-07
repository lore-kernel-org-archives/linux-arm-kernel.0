From: damien.riegel@savoirfairelinux.com (Damien Riegel)
Date: Thu,  7 Dec 2017 10:19:38 -0500
Subject: [PATCH v2 06/10] arm64: dts: qcom: msm8916: move pinconfs to board
 files
In-Reply-To: <20171207151942.5805-1-damien.riegel@savoirfairelinux.com>
References: <20171207151942.5805-1-damien.riegel@savoirfairelinux.com>
Message-ID: <20171207151942.5805-7-damien.riegel@savoirfairelinux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Following a suggestion from Bjorn Andersson [1], this commit moves
electrical specifications which were defined in mms8916-pins.dtsi to
board files, where they actually belong.

Pinmuxing is kept in the platform file because there are no alternative
pins on which all these functions could be routed, so this part is
indeed common to all boards using this SoC.

[1] https://www.spinics.net/lists/devicetree/msg201764.html

Signed-off-by: Damien Riegel <damien.riegel@savoirfairelinux.com>
Suggested-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi  | 386 +++++++++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/msm8916-mtp.dtsi  |  17 ++
 arch/arm64/boot/dts/qcom/msm8916-pins.dtsi | 258 -------------------
 3 files changed, 403 insertions(+), 258 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi b/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
index 981450f50e10..53c1ddd281a4 100644
--- a/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
+++ b/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
@@ -544,6 +544,384 @@
 	};
 };
 
+&blsp1_uart1_default {
+	pinconf {
+		pins = "gpio0", "gpio1",
+		       "gpio2", "gpio3";
+		drive-strength = <16>;
+		bias-disable;
+	};
+};
+
+&blsp1_uart1_sleep {
+	pinconf {
+		pins = "gpio0", "gpio1",
+		       "gpio2", "gpio3";
+		drive-strength = <2>;
+		bias-pull-down;
+	};
+};
+
+&blsp1_uart2_default {
+	pinconf {
+		pins = "gpio4", "gpio5";
+		drive-strength = <16>;
+		bias-disable;
+	};
+};
+
+&blsp1_uart2_sleep {
+	pinconf {
+		pins = "gpio4", "gpio5";
+		drive-strength = <2>;
+		bias-pull-down;
+	};
+};
+
+&cdc_pdm_lines_act {
+	pinconf {
+		pins = "gpio63", "gpio64", "gpio65", "gpio66",
+		       "gpio67", "gpio68";
+		drive-strength = <8>;
+		bias-pull-none;
+	};
+};
+
+&cdc_pdm_lines_sus {
+	pinconf {
+		pins = "gpio63", "gpio64", "gpio65", "gpio66",
+		       "gpio67", "gpio68";
+		drive-strength = <2>;
+		bias-disable;
+	};
+};
+
+&ext_mclk_tlmm_lines_act {
+	pinconf {
+		pins = "gpio116";
+		drive-strength = <8>;
+		bias-pull-none;
+	};
+};
+
+&ext_mclk_tlmm_lines_sus {
+	pinconf {
+		pins = "gpio116";
+		drive-strength = <2>;
+		bias-disable;
+	};
+};
+
+&ext_sec_tlmm_lines_act {
+	pinconf {
+		pins = "gpio112", "gpio117", "gpio118",
+			"gpio119";
+		drive-strength = <8>;
+		bias-pull-none;
+	};
+};
+
+&ext_sec_tlmm_lines_sus {
+	pinconf {
+		pins = "gpio112", "gpio117", "gpio118",
+			"gpio119";
+		drive-strength = <2>;
+		bias-disable;
+	};
+};
+
+&i2c2_default {
+	pinconf {
+		pins = "gpio6", "gpio7";
+		drive-strength = <16>;
+		bias-disable;
+	};
+};
+
+&i2c2_sleep {
+	pinconf {
+		pins = "gpio6", "gpio7";
+		drive-strength = <2>;
+		bias-disable;
+	};
+};
+
+&i2c4_default {
+	pinconf {
+		pins = "gpio14", "gpio15";
+		drive-strength = <16>;
+		bias-disable;
+	};
+};
+
+&i2c4_sleep {
+	pinconf {
+		pins = "gpio14", "gpio15";
+		drive-strength = <2>;
+		bias-disable;
+	};
+};
+
+&i2c6_default {
+	pinconf {
+		pins = "gpio22", "gpio23";
+		drive-strength = <16>;
+		bias-disable;
+	};
+};
+
+&i2c6_sleep {
+	pinconf {
+		pins = "gpio22", "gpio23";
+		drive-strength = <2>;
+		bias-disable;
+	};
+};
+
+&sdc1_clk_on {
+		pinconf {
+			pins = "sdc1_clk";
+			bias-disable;
+			drive-strength = <16>;
+		};
+};
+
+&sdc1_clk_off {
+	pinconf {
+		pins = "sdc1_clk";
+		bias-disable;
+		drive-strength = <2>;
+	};
+};
+
+&sdc1_cmd_on {
+	pinconf {
+		pins = "sdc1_cmd";
+		bias-pull-up;
+		drive-strength = <10>;
+	};
+};
+
+&sdc1_cmd_off {
+	pinconf {
+		pins = "sdc1_cmd";
+		bias-pull-up;
+		drive-strength = <2>;
+	};
+};
+
+&sdc1_data_on {
+	pinconf {
+		pins = "sdc1_data";
+		bias-pull-up;
+		drive-strength = <10>;
+	};
+};
+
+&sdc1_data_off {
+	pinconf {
+		pins = "sdc1_data";
+		bias-pull-up;
+		drive-strength = <2>;
+	};
+};
+
+&sdc2_clk_on {
+	pinconf {
+		pins = "sdc2_clk";
+		bias-disable;
+		drive-strength = <16>;
+	};
+};
+
+&sdc2_clk_off {
+	pinconf {
+		pins = "sdc2_clk";
+		bias-disable;
+		drive-strength = <2>;
+	};
+};
+
+&sdc2_cmd_on {
+	pinconf {
+		pins = "sdc2_cmd";
+		bias-pull-up;
+		drive-strength = <10>;
+	};
+};
+
+&sdc2_cmd_off {
+	pinconf {
+		pins = "sdc2_cmd";
+		bias-pull-up;
+		drive-strength = <2>;
+	};
+};
+
+&sdc2_data_on {
+	pinconf {
+		pins = "sdc2_data";
+		bias-pull-up;
+		drive-strength = <10>;
+	};
+};
+
+&sdc2_data_off {
+	pinconf {
+		pins = "sdc2_data";
+		bias-pull-up;
+		drive-strength = <2>;
+	};
+};
+
+&sdc2_cd_on {
+	pinconf {
+		pins = "gpio38";
+		drive-strength = <2>;
+		bias-pull-up;
+	};
+};
+
+&sdc2_cd_off {
+	pinconf {
+		pins = "gpio38";
+		drive-strength = <2>;
+		bias-disable;
+	};
+};
+
+&spi1_default {
+	pinconf {
+		pins = "gpio0", "gpio1", "gpio3";
+		drive-strength = <12>;
+		bias-disable;
+	};
+	pinconf_cs {
+		pins = "gpio2";
+		drive-strength = <16>;
+		bias-disable;
+		output-high;
+	};
+};
+
+&spi1_sleep {
+	pinconf {
+		pins = "gpio0", "gpio1", "gpio2", "gpio3";
+		drive-strength = <2>;
+		bias-pull-down;
+	};
+};
+
+&spi2_default {
+	pinconf {
+		pins = "gpio4", "gpio5", "gpio7";
+		drive-strength = <12>;
+		bias-disable;
+	};
+	pinconf_cs {
+		pins = "gpio6";
+		drive-strength = <16>;
+		bias-disable;
+		output-high;
+	};
+};
+
+&spi2_sleep {
+	pinconf {
+		pins = "gpio4", "gpio5", "gpio6", "gpio7";
+		drive-strength = <2>;
+		bias-pull-down;
+	};
+};
+
+&spi3_default {
+	pinconf {
+		pins = "gpio8", "gpio9", "gpio11";
+		drive-strength = <12>;
+		bias-disable;
+	};
+	pinconf_cs {
+		pins = "gpio10";
+		drive-strength = <16>;
+		bias-disable;
+		output-high;
+	};
+};
+
+&spi3_sleep {
+	pinconf {
+		pins = "gpio8", "gpio9", "gpio10", "gpio11";
+		drive-strength = <2>;
+		bias-pull-down;
+	};
+};
+
+&spi4_default {
+	pinconf {
+		pins = "gpio12", "gpio13", "gpio15";
+		drive-strength = <12>;
+		bias-disable;
+	};
+	pinconf_cs {
+		pins = "gpio14";
+		drive-strength = <16>;
+		bias-disable;
+		output-high;
+	};
+};
+
+&spi4_sleep {
+	pinconf {
+		pins = "gpio12", "gpio13", "gpio14", "gpio15";
+		drive-strength = <2>;
+		bias-pull-down;
+	};
+};
+
+&spi5_default {
+	pinconf {
+		pins = "gpio16", "gpio17", "gpio19";
+		drive-strength = <12>;
+		bias-disable;
+	};
+	pinconf_cs {
+		pins = "gpio18";
+		drive-strength = <16>;
+		bias-disable;
+		output-high;
+	};
+};
+
+&spi5_sleep {
+	pinconf {
+		pins = "gpio16", "gpio17", "gpio18", "gpio19";
+		drive-strength = <2>;
+		bias-pull-down;
+	};
+};
+
+&spi6_default {
+	pinconf {
+		pins = "gpio20", "gpio21", "gpio23";
+		drive-strength = <12>;
+		bias-disable;
+	};
+	pinconf_cs {
+		pins = "gpio22";
+		drive-strength = <16>;
+		bias-disable;
+		output-high;
+	};
+};
+
+&spi6_sleep {
+	pinconf {
+		pins = "gpio20", "gpio21", "gpio22", "gpio23";
+		drive-strength = <2>;
+		bias-pull-down;
+	};
+};
+
 &smd_rpm_regulators {
 	vdd_l1_l2_l3-supply = <&pm8916_s3>;
 	vdd_l5-supply = <&pm8916_s3>;
@@ -671,3 +1049,11 @@
 	qcom,mbhc-vthreshold-low = <75 150 237 450 500>;
 	qcom,mbhc-vthreshold-high = <75 150 237 450 500>;
 };
+
+&wcnss_pin_a {
+	pinconf {
+		pins = "gpio40", "gpio41", "gpio42", "gpio43", "gpio44";
+		drive-strength = <6>;
+		bias-pull-up;
+	};
+};
diff --git a/arch/arm64/boot/dts/qcom/msm8916-mtp.dtsi b/arch/arm64/boot/dts/qcom/msm8916-mtp.dtsi
index ceeb8a6feed6..9f15148f8a03 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-mtp.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916-mtp.dtsi
@@ -33,3 +33,20 @@
 		};
 	};
 };
+
+&blsp1_uart2_default {
+	pinconf {
+		pins = "gpio4", "gpio5";
+		drive-strength = <16>;
+		bias-disable;
+	};
+};
+
+&blsp1_uart2_sleep {
+	pinconf {
+		pins = "gpio4", "gpio5";
+		drive-strength = <2>;
+		bias-pull-down;
+	};
+};
+
diff --git a/arch/arm64/boot/dts/qcom/msm8916-pins.dtsi b/arch/arm64/boot/dts/qcom/msm8916-pins.dtsi
index 21f144c55638..0790232c4654 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-pins.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916-pins.dtsi
@@ -20,12 +20,6 @@
 			pins = "gpio0", "gpio1",
 			       "gpio2", "gpio3";
 		};
-		pinconf {
-			pins = "gpio0", "gpio1",
-			       "gpio2", "gpio3";
-			drive-strength = <16>;
-			bias-disable;
-		};
 	};
 
 	blsp1_uart1_sleep: blsp1_uart1_sleep {
@@ -34,12 +28,6 @@
 			pins = "gpio0", "gpio1",
 			       "gpio2", "gpio3";
 		};
-		pinconf {
-			pins = "gpio0", "gpio1",
-			       "gpio2", "gpio3";
-			drive-strength = <2>;
-			bias-pull-down;
-		};
 	};
 
 	blsp1_uart2_default: blsp1_uart2_default {
@@ -47,11 +35,6 @@
 			function = "blsp_uart2";
 			pins = "gpio4", "gpio5";
 		};
-		pinconf {
-			pins = "gpio4", "gpio5";
-			drive-strength = <16>;
-			bias-disable;
-		};
 	};
 
 	blsp1_uart2_sleep: blsp1_uart2_sleep {
@@ -59,11 +42,6 @@
 			function = "gpio";
 			pins = "gpio4", "gpio5";
 		};
-		pinconf {
-			pins = "gpio4", "gpio5";
-			drive-strength = <2>;
-			bias-pull-down;
-		};
 	};
 
 	spi1_default: spi1_default {
@@ -75,17 +53,6 @@
 			function = "gpio";
 			pins = "gpio2";
 		};
-		pinconf {
-			pins = "gpio0", "gpio1", "gpio3";
-			drive-strength = <12>;
-			bias-disable;
-		};
-		pinconf_cs {
-			pins = "gpio2";
-			drive-strength = <16>;
-			bias-disable;
-			output-high;
-		};
 	};
 
 	spi1_sleep: spi1_sleep {
@@ -93,11 +60,6 @@
 			function = "gpio";
 			pins = "gpio0", "gpio1", "gpio2", "gpio3";
 		};
-		pinconf {
-			pins = "gpio0", "gpio1", "gpio2", "gpio3";
-			drive-strength = <2>;
-			bias-pull-down;
-		};
 	};
 
 	spi2_default: spi2_default {
@@ -109,17 +71,6 @@
 			function = "gpio";
 			pins = "gpio6";
 		};
-		pinconf {
-			pins = "gpio4", "gpio5", "gpio7";
-			drive-strength = <12>;
-			bias-disable;
-		};
-		pinconf_cs {
-			pins = "gpio6";
-			drive-strength = <16>;
-			bias-disable;
-			output-high;
-		};
 	};
 
 	spi2_sleep: spi2_sleep {
@@ -127,11 +78,6 @@
 			function = "gpio";
 			pins = "gpio4", "gpio5", "gpio6", "gpio7";
 		};
-		pinconf {
-			pins = "gpio4", "gpio5", "gpio6", "gpio7";
-			drive-strength = <2>;
-			bias-pull-down;
-		};
 	};
 
 	spi3_default: spi3_default {
@@ -143,17 +89,6 @@
 			function = "gpio";
 			pins = "gpio10";
 		};
-		pinconf {
-			pins = "gpio8", "gpio9", "gpio11";
-			drive-strength = <12>;
-			bias-disable;
-		};
-		pinconf_cs {
-			pins = "gpio10";
-			drive-strength = <16>;
-			bias-disable;
-			output-high;
-		};
 	};
 
 	spi3_sleep: spi3_sleep {
@@ -161,11 +96,6 @@
 			function = "gpio";
 			pins = "gpio8", "gpio9", "gpio10", "gpio11";
 		};
-		pinconf {
-			pins = "gpio8", "gpio9", "gpio10", "gpio11";
-			drive-strength = <2>;
-			bias-pull-down;
-		};
 	};
 
 	spi4_default: spi4_default {
@@ -177,17 +107,6 @@
 			function = "gpio";
 			pins = "gpio14";
 		};
-		pinconf {
-			pins = "gpio12", "gpio13", "gpio15";
-			drive-strength = <12>;
-			bias-disable;
-		};
-		pinconf_cs {
-			pins = "gpio14";
-			drive-strength = <16>;
-			bias-disable;
-			output-high;
-		};
 	};
 
 	spi4_sleep: spi4_sleep {
@@ -195,11 +114,6 @@
 			function = "gpio";
 			pins = "gpio12", "gpio13", "gpio14", "gpio15";
 		};
-		pinconf {
-			pins = "gpio12", "gpio13", "gpio14", "gpio15";
-			drive-strength = <2>;
-			bias-pull-down;
-		};
 	};
 
 	spi5_default: spi5_default {
@@ -211,17 +125,6 @@
 			function = "gpio";
 			pins = "gpio18";
 		};
-		pinconf {
-			pins = "gpio16", "gpio17", "gpio19";
-			drive-strength = <12>;
-			bias-disable;
-		};
-		pinconf_cs {
-			pins = "gpio18";
-			drive-strength = <16>;
-			bias-disable;
-			output-high;
-		};
 	};
 
 	spi5_sleep: spi5_sleep {
@@ -229,11 +132,6 @@
 			function = "gpio";
 			pins = "gpio16", "gpio17", "gpio18", "gpio19";
 		};
-		pinconf {
-			pins = "gpio16", "gpio17", "gpio18", "gpio19";
-			drive-strength = <2>;
-			bias-pull-down;
-		};
 	};
 
 	spi6_default: spi6_default {
@@ -245,17 +143,6 @@
 			function = "gpio";
 			pins = "gpio22";
 		};
-		pinconf {
-			pins = "gpio20", "gpio21", "gpio23";
-			drive-strength = <12>;
-			bias-disable;
-		};
-		pinconf_cs {
-			pins = "gpio22";
-			drive-strength = <16>;
-			bias-disable;
-			output-high;
-		};
 	};
 
 	spi6_sleep: spi6_sleep {
@@ -263,11 +150,6 @@
 			function = "gpio";
 			pins = "gpio20", "gpio21", "gpio22", "gpio23";
 		};
-		pinconf {
-			pins = "gpio20", "gpio21", "gpio22", "gpio23";
-			drive-strength = <2>;
-			bias-pull-down;
-		};
 	};
 
 	i2c2_default: i2c2_default {
@@ -275,11 +157,6 @@
 			function = "blsp_i2c2";
 			pins = "gpio6", "gpio7";
 		};
-		pinconf {
-			pins = "gpio6", "gpio7";
-			drive-strength = <16>;
-			bias-disable;
-		};
 	};
 
 	i2c2_sleep: i2c2_sleep {
@@ -287,11 +164,6 @@
 			function = "gpio";
 			pins = "gpio6", "gpio7";
 		};
-		pinconf {
-			pins = "gpio6", "gpio7";
-			drive-strength = <2>;
-			bias-disable;
-		};
 	};
 
 	i2c4_default: i2c4_default {
@@ -299,11 +171,6 @@
 			function = "blsp_i2c4";
 			pins = "gpio14", "gpio15";
 		};
-		pinconf {
-			pins = "gpio14", "gpio15";
-			drive-strength = <16>;
-			bias-disable;
-		};
 	};
 
 	i2c4_sleep: i2c4_sleep {
@@ -311,11 +178,6 @@
 			function = "gpio";
 			pins = "gpio14", "gpio15";
 		};
-		pinconf {
-			pins = "gpio14", "gpio15";
-			drive-strength = <2>;
-			bias-disable;
-		};
 	};
 
 	i2c6_default: i2c6_default {
@@ -323,11 +185,6 @@
 			function = "blsp_i2c6";
 			pins = "gpio22", "gpio23";
 		};
-		pinconf {
-			pins = "gpio22", "gpio23";
-			drive-strength = <16>;
-			bias-disable;
-		};
 	};
 
 	i2c6_sleep: i2c6_sleep {
@@ -335,11 +192,6 @@
 			function = "gpio";
 			pins = "gpio22", "gpio23";
 		};
-		pinconf {
-			pins = "gpio22", "gpio23";
-			drive-strength = <2>;
-			bias-disable;
-		};
 	};
 
 	sdhc2_cd_pin {
@@ -348,22 +200,12 @@
 				function = "gpio";
 				pins = "gpio38";
 			};
-			pinconf {
-				pins = "gpio38";
-				drive-strength = <2>;
-				bias-pull-up;
-			};
 		};
 		sdc2_cd_off: cd_off {
 			pinmux {
 				function = "gpio";
 				pins = "gpio38";
 			};
-			pinconf {
-				pins = "gpio38";
-				drive-strength = <2>;
-				bias-disable;
-			};
 		};
 	};
 
@@ -372,21 +214,11 @@
 			pinmux {
 				pins = "sdc1_clk";
 			};
-			pinconf {
-				pins = "sdc1_clk";
-				bias-disable;
-				drive-strength = <16>;
-			};
 		};
 		sdc1_clk_off: clk_off {
 			pinmux {
 				pins = "sdc1_clk";
 			};
-			pinconf {
-				pins = "sdc1_clk";
-				bias-disable;
-				drive-strength = <2>;
-			};
 		};
 	};
 
@@ -395,21 +227,11 @@
 			pinmux {
 				pins = "sdc1_cmd";
 			};
-			pinconf {
-				pins = "sdc1_cmd";
-				bias-pull-up;
-				drive-strength = <10>;
-			};
 		};
 		sdc1_cmd_off: cmd_off {
 			pinmux {
 				pins = "sdc1_cmd";
 			};
-			pinconf {
-				pins = "sdc1_cmd";
-				bias-pull-up;
-				drive-strength = <2>;
-			};
 		};
 	};
 
@@ -418,21 +240,11 @@
 			pinmux {
 				pins = "sdc1_data";
 			};
-			pinconf {
-				pins = "sdc1_data";
-				bias-pull-up;
-				drive-strength = <10>;
-			};
 		};
 		sdc1_data_off: data_off {
 			pinmux {
 				pins = "sdc1_data";
 			};
-			pinconf {
-				pins = "sdc1_data";
-				bias-pull-up;
-				drive-strength = <2>;
-			};
 		};
 	};
 
@@ -441,21 +253,11 @@
 			pinmux {
 				pins = "sdc2_clk";
 			};
-			pinconf {
-				pins = "sdc2_clk";
-				bias-disable;
-				drive-strength = <16>;
-			};
 		};
 		sdc2_clk_off: clk_off {
 			pinmux {
 				pins = "sdc2_clk";
 			};
-			pinconf {
-				pins = "sdc2_clk";
-				bias-disable;
-				drive-strength = <2>;
-			};
 		};
 	};
 
@@ -464,21 +266,11 @@
 			pinmux {
 				pins = "sdc2_cmd";
 			};
-			pinconf {
-				pins = "sdc2_cmd";
-				bias-pull-up;
-				drive-strength = <10>;
-			};
 		};
 		sdc2_cmd_off: cmd_off {
 			pinmux {
 				pins = "sdc2_cmd";
 			};
-			pinconf {
-				pins = "sdc2_cmd";
-				bias-pull-up;
-				drive-strength = <2>;
-			};
 		};
 	};
 
@@ -487,21 +279,11 @@
 			pinmux {
 				pins = "sdc2_data";
 			};
-			pinconf {
-				pins = "sdc2_data";
-				bias-pull-up;
-				drive-strength = <10>;
-			};
 		};
 		sdc2_data_off: data_off {
 			pinmux {
 				pins = "sdc2_data";
 			};
-			pinconf {
-				pins = "sdc2_data";
-				bias-pull-up;
-				drive-strength = <2>;
-			};
 		};
 	};
 
@@ -512,12 +294,6 @@
 				pins = "gpio63", "gpio64", "gpio65", "gpio66",
 				       "gpio67", "gpio68";
 			};
-			pinconf {
-				pins = "gpio63", "gpio64", "gpio65", "gpio66",
-				       "gpio67", "gpio68";
-				drive-strength = <8>;
-				bias-pull-none;
-			};
 		};
 		cdc_pdm_lines_sus: pdm_lines_off {
 			pinmux {
@@ -525,12 +301,6 @@
 				pins = "gpio63", "gpio64", "gpio65", "gpio66",
 				       "gpio67", "gpio68";
 			};
-			pinconf {
-				pins = "gpio63", "gpio64", "gpio65", "gpio66",
-				       "gpio67", "gpio68";
-				drive-strength = <2>;
-				bias-disable;
-			};
 		};
 	};
 
@@ -596,22 +366,12 @@
 				function = "pri_mi2s";
 				pins = "gpio116";
 			};
-			pinconf {
-				pins = "gpio116";
-				drive-strength = <8>;
-				bias-pull-none;
-			};
 		};
 		ext_mclk_tlmm_lines_sus: mclk_lines_off {
 			pinmux {
 				function = "pri_mi2s";
 				pins = "gpio116";
 			};
-			pinconf {
-				pins = "gpio116";
-				drive-strength = <2>;
-				bias-disable;
-			};
 		};
 	};
 
@@ -623,12 +383,6 @@
 				pins = "gpio112", "gpio117", "gpio118",
 				       "gpio119";
 			};
-			pinconf {
-				pins = "gpio112", "gpio117", "gpio118",
-					"gpio119";
-				drive-strength = <8>;
-				bias-pull-none;
-			};
 		};
 		ext_sec_tlmm_lines_sus: tlmm_lines_off {
 			pinmux {
@@ -636,12 +390,6 @@
 				pins = "gpio112", "gpio117", "gpio118",
 				       "gpio119";
 			};
-			pinconf {
-				pins = "gpio112", "gpio117", "gpio118",
-					"gpio119";
-				drive-strength = <2>;
-				bias-disable;
-			};
 		};
 	};
 
@@ -682,11 +430,5 @@
 			pins = "gpio40", "gpio41", "gpio42", "gpio43", "gpio44";
 			function = "wcss_wlan";
 		};
-
-		pinconf {
-			pins = "gpio40", "gpio41", "gpio42", "gpio43", "gpio44";
-			drive-strength = <6>;
-			bias-pull-up;
-		};
 	};
 };
-- 
2.15.0
