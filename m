From: damien.riegel@savoirfairelinux.com (Damien Riegel)
Date: Thu,  7 Dec 2017 10:19:36 -0500
Subject: [PATCH v2 04/10] arm64: dts: qcom: msm8916: drop unused
 board-specific nodes
In-Reply-To: <20171207151942.5805-1-damien.riegel@savoirfairelinux.com>
References: <20171207151942.5805-1-damien.riegel@savoirfairelinux.com>
Message-ID: <20171207151942.5805-5-damien.riegel@savoirfairelinux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These nodes reserve and configure some pins as GPIOs. They are not
generic pinctrls, they actually belong to board files but they are not
used by any other node, so just drop them altogether.

Signed-off-by: Damien Riegel <damien.riegel@savoirfairelinux.com>
---
 arch/arm64/boot/dts/qcom/msm8916-pins.dtsi | 52 ------------------------------
 1 file changed, 52 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8916-pins.dtsi b/arch/arm64/boot/dts/qcom/msm8916-pins.dtsi
index 10fc1fc90682..21f144c55638 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-pins.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916-pins.dtsi
@@ -505,32 +505,6 @@
 		};
 	};
 
-	ext-codec-lines {
-		ext_codec_lines_act: lines_on {
-			pinmux {
-				function = "gpio";
-				pins = "gpio67";
-			};
-			pinconf {
-				pins = "gpio67";
-				drive-strength = <8>;
-				bias-disable;
-				output-high;
-			};
-		};
-		ext_codec_lines_sus: lines_off {
-			pinmux {
-				function = "gpio";
-				pins = "gpio67";
-			};
-			pinconf {
-				pins = "gpio67";
-				drive-strength = <2>;
-				bias-disable;
-			};
-		};
-	};
-
 	cdc-pdm-lines {
 		cdc_pdm_lines_act: pdm_lines_on {
 			pinmux {
@@ -703,32 +677,6 @@
 		};
 	};
 
-	cross-conn-det {
-		cross_conn_det_act: lines_on {
-			pinmux {
-				function = "gpio";
-				pins = "gpio120";
-			};
-			pinconf {
-				pins = "gpio120";
-				drive-strength = <8>;
-				output-low;
-				bias-pull-down;
-			};
-		};
-		cross_conn_det_sus: lines_off {
-			pinmux {
-				function = "gpio";
-				pins = "gpio120";
-			};
-			pinconf {
-				pins = "gpio120";
-				drive-strength = <2>;
-				bias-disable;
-			};
-		};
-	};
-
 	wcnss_pin_a: wcnss-active {
 		pinmux {
 			pins = "gpio40", "gpio41", "gpio42", "gpio43", "gpio44";
-- 
2.15.0
