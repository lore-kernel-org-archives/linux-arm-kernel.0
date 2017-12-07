From: damien.riegel@savoirfairelinux.com (Damien Riegel)
Date: Thu,  7 Dec 2017 10:19:35 -0500
Subject: [PATCH v2 03/10] arm64: dts: qcom: msm8916-pins: keep cdc_dmic pins
 in suspend mode
In-Reply-To: <20171207151942.5805-1-damien.riegel@savoirfairelinux.com>
References: <20171207151942.5805-1-damien.riegel@savoirfairelinux.com>
Message-ID: <20171207151942.5805-4-damien.riegel@savoirfairelinux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This node was the only one that didn't have the same set of pins in
active and suspend mode.

Signed-off-by: Damien Riegel <damien.riegel@savoirfairelinux.com>
---
 arch/arm64/boot/dts/qcom/msm8916-pins.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8916-pins.dtsi b/arch/arm64/boot/dts/qcom/msm8916-pins.dtsi
index c67ad8ed8b60..10fc1fc90682 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-pins.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916-pins.dtsi
@@ -687,6 +687,14 @@
 			};
 		};
 		cdc_dmic_lines_sus: dmic_lines_off {
+			pinmux_dmic0_clk {
+				function = "dmic0_clk";
+				pins = "gpio0";
+			};
+			pinmux_dmic0_data {
+				function = "dmic0_data";
+				pins = "gpio1";
+			};
 			pinconf {
 				pins = "gpio0", "gpio1";
 				drive-strength = <2>;
-- 
2.15.0
