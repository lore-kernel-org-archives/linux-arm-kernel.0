From: jbrunet@baylibre.com (Jerome Brunet)
Date: Tue, 24 Jul 2018 14:52:31 +0200
Subject: [PATCH 07/14] arm64: dts: meson-axg: add tdmin formatters
In-Reply-To: <20180724125238.14567-1-jbrunet@baylibre.com>
References: <20180724125238.14567-1-jbrunet@baylibre.com>
Message-ID: <20180724125238.14567-8-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the tdm devices responsible for decoding the data provided
through audio serial interface.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 56 ++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
index c56016a48cc4..55e4ac734023 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
@@ -264,6 +264,62 @@
 				clocks = <&clkc_audio AUD_CLKID_DDR_ARB>;
 			};
 
+			tdmin_a: audio-controller at 300 {
+				compatible = "amlogic,axg-tdmin";
+				reg = <0x0 0x300 0x0 0x40>;
+				sound-name-prefix = "TDMIN_A";
+				clocks = <&clkc_audio AUD_CLKID_TDMIN_A>,
+					 <&clkc_audio AUD_CLKID_TDMIN_A_SCLK>,
+					 <&clkc_audio AUD_CLKID_TDMIN_A_SCLK_SEL>,
+					 <&clkc_audio AUD_CLKID_TDMIN_A_LRCLK>,
+					 <&clkc_audio AUD_CLKID_TDMIN_A_LRCLK>;
+				clock-names = "pclk", "sclk", "sclk_sel",
+					      "lrclk", "lrclk_sel";
+				status = "disabled";
+			};
+
+			tdmin_b: audio-controller at 340 {
+				compatible = "amlogic,axg-tdmin";
+				reg = <0x0 0x340 0x0 0x40>;
+				sound-name-prefix = "TDMIN_B";
+				clocks = <&clkc_audio AUD_CLKID_TDMIN_B>,
+					 <&clkc_audio AUD_CLKID_TDMIN_B_SCLK>,
+					 <&clkc_audio AUD_CLKID_TDMIN_B_SCLK_SEL>,
+					 <&clkc_audio AUD_CLKID_TDMIN_B_LRCLK>,
+					 <&clkc_audio AUD_CLKID_TDMIN_B_LRCLK>;
+				clock-names = "pclk", "sclk", "sclk_sel",
+					      "lrclk", "lrclk_sel";
+				status = "disabled";
+			};
+
+			tdmin_c: audio-controller at 380 {
+				compatible = "amlogic,axg-tdmin";
+				reg = <0x0 0x380 0x0 0x40>;
+				sound-name-prefix = "TDMIN_C";
+				clocks = <&clkc_audio AUD_CLKID_TDMIN_C>,
+					 <&clkc_audio AUD_CLKID_TDMIN_C_SCLK>,
+					 <&clkc_audio AUD_CLKID_TDMIN_C_SCLK_SEL>,
+					 <&clkc_audio AUD_CLKID_TDMIN_C_LRCLK>,
+					 <&clkc_audio AUD_CLKID_TDMIN_C_LRCLK>;
+				clock-names = "pclk", "sclk", "sclk_sel",
+					      "lrclk", "lrclk_sel";
+				status = "disabled";
+			};
+
+			tdmin_lb: audio-controller at 3c0 {
+				compatible = "amlogic,axg-tdmin";
+				reg = <0x0 0x3c0 0x0 0x40>;
+				sound-name-prefix = "TDMIN_LB";
+				clocks = <&clkc_audio AUD_CLKID_TDMIN_LB>,
+					 <&clkc_audio AUD_CLKID_TDMIN_LB_SCLK>,
+					 <&clkc_audio AUD_CLKID_TDMIN_LB_SCLK_SEL>,
+					 <&clkc_audio AUD_CLKID_TDMIN_LB_LRCLK>,
+					 <&clkc_audio AUD_CLKID_TDMIN_LB_LRCLK>;
+				clock-names = "pclk", "sclk", "sclk_sel",
+					      "lrclk", "lrclk_sel";
+				status = "disabled";
+			};
+
 			spdifout: audio-controller at 480 {
 				compatible = "amlogic,axg-spdifout";
 				reg = <0x0 0x480 0x0 0x50>;
-- 
2.17.1
