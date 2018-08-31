From: jbrunet@baylibre.com (Jerome Brunet)
Date: Fri, 31 Aug 2018 17:02:18 +0200
Subject: [PATCH 3/3] arm64: dts: meson-axg: s400: add pdm to the sound card
In-Reply-To: <20180831150218.8307-1-jbrunet@baylibre.com>
References: <20180831150218.8307-1-jbrunet@baylibre.com>
Message-ID: <20180831150218.8307-4-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the PDM input device on the S400 and it to the sound card

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-axg-s400.dts | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
index f3e16cbbc61e..92d3064d4966 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
@@ -240,6 +240,9 @@
 				"TODDR_A IN 2", "TDMIN_C OUT",
 				"TODDR_B IN 2", "TDMIN_C OUT",
 				"TODDR_C IN 2", "TDMIN_C OUT",
+				"TODDR_A IN 4", "PDM Capture",
+				"TODDR_B IN 4", "PDM Capture",
+				"TODDR_C IN 4", "PDM Capture",
 				"TODDR_A IN 6", "TDMIN_LB OUT",
 				"TODDR_B IN 6", "TDMIN_LB OUT",
 				"TODDR_C IN 6", "TDMIN_LB OUT",
@@ -312,6 +315,14 @@
 				sound-dai = <&spdif_dit>;
 			};
 		};
+
+		dai-link at 8 {
+			sound-dai = <&pdm>;
+
+			codec {
+				sound-dai = <&dmics>;
+			};
+		};
 	};
 
 	wifi32k: wifi32k {
@@ -394,6 +405,13 @@
 	};
 };
 
+&pdm {
+	pinctrl-0 = <&pdm_dclk_a14_pins>, <&pdm_din0_pins>,
+		    <&pdm_din1_pins>, <&pdm_din2_pins>, <&pdm_din3_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
 &pwm_ab {
 	status = "okay";
 	pinctrl-0 = <&pwm_a_x20_pins>;
-- 
2.17.1
