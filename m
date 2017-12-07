From: damien.riegel@savoirfairelinux.com (Damien Riegel)
Date: Thu,  7 Dec 2017 10:19:39 -0500
Subject: [PATCH v2 07/10] arm64: dts: qcom: msm8916: drop remaining unused
 pinconfs
In-Reply-To: <20171207151942.5805-1-damien.riegel@savoirfairelinux.com>
References: <20171207151942.5805-1-damien.riegel@savoirfairelinux.com>
Message-ID: <20171207151942.5805-8-damien.riegel@savoirfairelinux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit drops pin configs that cannot be moved to board files as
no boards use them.

Signed-off-by: Damien Riegel <damien.riegel@savoirfairelinux.com>
---
 arch/arm64/boot/dts/qcom/msm8916-pins.dtsi | 33 ------------------------------
 1 file changed, 33 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8916-pins.dtsi b/arch/arm64/boot/dts/qcom/msm8916-pins.dtsi
index 0790232c4654..c79301f204b7 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-pins.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916-pins.dtsi
@@ -311,26 +311,13 @@
 				pins = "gpio113", "gpio114", "gpio115",
 				       "gpio116";
 			};
-			pinconf {
-				pins = "gpio113", "gpio114", "gpio115",
-				       "gpio116";
-				drive-strength = <8>;
-				bias-pull-none;
-			};
 		};
-
 		ext_pri_tlmm_lines_sus: ext_pa_off {
 			pinmux {
 				function = "pri_mi2s";
 				pins = "gpio113", "gpio114", "gpio115",
 				       "gpio116";
 			};
-			pinconf {
-				pins = "gpio113", "gpio114", "gpio115",
-				       "gpio116";
-				drive-strength = <2>;
-				bias-disable;
-			};
 		};
 	};
 
@@ -340,23 +327,12 @@
 				function = "pri_mi2s_ws";
 				pins = "gpio110";
 			};
-			pinconf {
-				pins = "gpio110";
-				drive-strength = <8>;
-				bias-pull-none;
-			};
 		};
-
 		ext_pri_ws_sus: ext_pa_off {
 			pinmux {
 				function = "pri_mi2s_ws";
 				pins = "gpio110";
 			};
-			pinconf {
-				pins = "gpio110";
-				drive-strength = <2>;
-				bias-disable;
-			};
 		};
 	};
 
@@ -403,10 +379,6 @@
 				function = "dmic0_data";
 				pins = "gpio1";
 			};
-			pinconf {
-				pins = "gpio0", "gpio1";
-				drive-strength = <8>;
-			};
 		};
 		cdc_dmic_lines_sus: dmic_lines_off {
 			pinmux_dmic0_clk {
@@ -417,11 +389,6 @@
 				function = "dmic0_data";
 				pins = "gpio1";
 			};
-			pinconf {
-				pins = "gpio0", "gpio1";
-				drive-strength = <2>;
-				bias-disable;
-			};
 		};
 	};
 
-- 
2.15.0
