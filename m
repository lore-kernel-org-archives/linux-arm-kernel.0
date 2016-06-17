From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Fri, 17 Jun 2016 16:14:12 +0100
Subject: [PATCH 15/16] arm64: dts: msm8996: add sdc2 pinctrl
In-Reply-To: <1466176454-28084-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1466176454-28084-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1466176454-28084-16-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds pinctrl required for sdhci for external sd card
controller.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8996-pins.dtsi | 48 ++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8996-pins.dtsi b/arch/arm64/boot/dts/qcom/msm8996-pins.dtsi
index 551707a..6599404 100644
--- a/arch/arm64/boot/dts/qcom/msm8996-pins.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996-pins.dtsi
@@ -252,4 +252,52 @@
 			bias-pull-down;
 		};
 	};
+
+	sdc2_clk_on: sdc2_clk_on {
+		config {
+			pins = "sdc2_clk";
+			bias-disable;		/* NO pull */
+			drive-strength = <16>;	/* 16 MA */
+		};
+	};
+
+	sdc2_clk_off: sdc2_clk_off {
+		config {
+			pins = "sdc2_clk";
+			bias-disable;		/* NO pull */
+			drive-strength = <2>;	/* 2 MA */
+		};
+	};
+
+	sdc2_cmd_on: sdc2_cmd_on {
+		config {
+			pins = "sdc2_cmd";
+			bias-pull-up;		/* pull up */
+			drive-strength = <10>;	/* 10 MA */
+		};
+	};
+
+	sdc2_cmd_off: sdc2_cmd_off {
+		config {
+			pins = "sdc2_cmd";
+			bias-pull-up;		/* pull up */
+			drive-strength = <2>;	/* 2 MA */
+		};
+	};
+
+	sdc2_data_on: sdc2_data_on {
+		config {
+			pins = "sdc2_data";
+			bias-pull-up;		/* pull up */
+			drive-strength = <10>;	/* 10 MA */
+		};
+	};
+
+	sdc2_data_off: sdc2_data_off {
+		config {
+			pins = "sdc2_data";
+			bias-pull-up;		/* pull up */
+			drive-strength = <2>;	/* 2 MA */
+		};
+	};
 };
-- 
2.7.4
