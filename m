From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Fri,  5 Feb 2016 19:01:29 +0000
Subject: [PATCH 3/6] arm64: dts: qcom: add audio pinctrls
In-Reply-To: <1454698819-13885-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1454698819-13885-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1454698889-14015-1-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds pinctrls required for digital and analog audio via lpass.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8916-pins.dtsi | 216 +++++++++++++++++++++++++++++
 1 file changed, 216 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8916-pins.dtsi b/arch/arm64/boot/dts/qcom/msm8916-pins.dtsi
index 8d05005..e9ea5ca 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-pins.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916-pins.dtsi
@@ -504,4 +504,220 @@
 			};
 		};
 	};
+
+	ext-codec-lines {
+		ext_codec_lines_act: lines_on {
+			pinmux {
+				function = "gpio";
+				pins = "gpio67";
+			};
+			pinconf {
+				pins = "gpio67";
+				drive-strength = <8>;
+				bias-disable;
+				output-high;
+			};
+		};
+		ext_codec_lines_sus: lines_off {
+			pinmux {
+				function = "gpio";
+				pins = "gpio67";
+			};
+			pinconf {
+				pins = "gpio67";
+				drive-strength = <2>;
+				bias-disable;
+			};
+		};
+	};
+
+	cdc-pdm-lines {
+		cdc_pdm_lines_act: pdm_lines_on {
+			pinmux {
+				function = "cdc_pdm0";
+				pins = "gpio63", "gpio64", "gpio65", "gpio66",
+				       "gpio67", "gpio68";
+			};
+			pinconf {
+				pins = "gpio63", "gpio64", "gpio65", "gpio66",
+				       "gpio67", "gpio68";
+				drive-strength = <8>;
+				bias-pull-none;
+			};
+		};
+		cdc_pdm_lines_sus: pdm_lines_off {
+			pinmux {
+				function = "cdc_pdm0";
+				pins = "gpio63", "gpio64", "gpio65", "gpio66",
+				       "gpio67", "gpio68";
+			};
+			pinconf {
+				pins = "gpio63", "gpio64", "gpio65", "gpio66",
+				       "gpio67", "gpio68";
+				drive-strength = <2>;
+				bias-disable;
+			};
+		};
+	};
+
+	ext-pri-tlmm-lines {
+		ext_pri_tlmm_lines_act: ext_pa_on {
+			pinmux {
+				function = "pri_mi2s";
+				pins = "gpio113", "gpio114", "gpio115",
+				       "gpio116";
+			};
+			pinconf {
+				pins = "gpio113", "gpio114", "gpio115",
+				       "gpio116";
+				drive-strength = <8>;
+				bias-pull-none;
+			};
+		};
+
+		ext_pri_tlmm_lines_sus: ext_pa_off {
+			pinmux {
+				function = "pri_mi2s";
+				pins = "gpio113", "gpio114", "gpio115",
+				       "gpio116";
+			};
+			pinconf {
+				pins = "gpio113", "gpio114", "gpio115",
+				       "gpio116";
+				drive-strength = <2>;
+				bias-disable;
+			};
+		};
+	};
+
+	ext-pri-ws-line {
+		ext_pri_ws_act: ext_pa_on {
+			pinmux {
+				function = "pri_mi2s_ws";
+				pins = "gpio110";
+			};
+			pinconf {
+				pins = "gpio110";
+				drive-strength = <8>;
+				bias-pull-none;
+			};
+		};
+
+		ext_pri_ws_sus: ext_pa_off {
+			pinmux {
+				function = "pri_mi2s_ws";
+				pins = "gpio110";
+			};
+			pinconf {
+				pins = "gpio110";
+				drive-strength = <2>;
+				bias-disable;
+			};
+		};
+	};
+
+	ext-mclk-tlmm-lines {
+		ext_mclk_tlmm_lines_act: mclk_lines_on {
+			pinmux {
+				function = "pri_mi2s";
+				pins = "gpio116";
+			};
+			pinconf {
+				pins = "gpio116";
+				drive-strength = <8>;
+				bias-pull-none;
+			};
+		};
+		ext_mclk_tlmm_lines_sus: mclk_lines_off {
+			pinmux {
+				function = "pri_mi2s";
+				pins = "gpio116";
+			};
+			pinconf {
+				pins = "gpio116";
+				drive-strength = <2>;
+				bias-disable;
+			};
+		};
+	};
+
+	/* secondary Mi2S */
+	ext-sec-tlmm-lines {
+		ext_sec_tlmm_lines_act: tlmm_lines_on {
+			pinmux {
+				function = "sec_mi2s";
+				pins = "gpio112", "gpio117", "gpio118",
+				       "gpio119";
+			};
+			pinconf {
+				pins = "gpio112", "gpio117", "gpio118",
+					"gpio119";
+				drive-strength = <8>;
+				bias-pull-none;
+			};
+		};
+		ext_sec_tlmm_lines_sus: tlmm_lines_off {
+			pinmux {
+				function = "sec_mi2s";
+				pins = "gpio112", "gpio117", "gpio118",
+				       "gpio119";
+			};
+			pinconf {
+				pins = "gpio112", "gpio117", "gpio118",
+					"gpio119";
+				drive-strength = <2>;
+				bias-disable;
+			};
+		};
+	};
+
+	cdc-dmic-lines {
+		cdc_dmic_lines_act: dmic_lines_on {
+			pinmux_dmic0_clk {
+				function = "dmic0_clk";
+				pins = "gpio0";
+			};
+			pinmux_dmic0_data {
+				function = "dmic0_data";
+				pins = "gpio1";
+			};
+			pinconf {
+				pins = "gpio0", "gpio1";
+				drive-strength = <8>;
+			};
+		};
+		cdc_dmic_lines_sus: dmic_lines_off {
+			pinconf {
+				pins = "gpio0", "gpio1";
+				drive-strength = <2>;
+				bias-disable;
+			};
+		};
+	};
+
+	cross-conn-det {
+		cross_conn_det_act: lines_on {
+			pinmux {
+				function = "gpio";
+				pins = "gpio120";
+			};
+			pinconf {
+				pins = "gpio120";
+				drive-strength = <8>;
+				output-low;
+				bias-pull-down;
+			};
+		};
+		cross_conn_det_sus: lines_off {
+			pinmux {
+				function = "gpio";
+				pins = "gpio120";
+			};
+			pinconf {
+				pins = "gpio120";
+				drive-strength = <2>;
+				bias-disable;
+			};
+		};
+	};
 };
-- 
1.9.1
