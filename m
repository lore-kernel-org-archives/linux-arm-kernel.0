From: jbrunet@baylibre.com (Jerome Brunet)
Date: Tue, 24 Jul 2018 14:52:32 +0200
Subject: [PATCH 08/14] arm64: dts: meson-axg: add tdmout formatters
In-Reply-To: <20180724125238.14567-1-jbrunet@baylibre.com>
References: <20180724125238.14567-1-jbrunet@baylibre.com>
Message-ID: <20180724125238.14567-9-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the tdm devices responsible for serializing audio samples
for i2s/tdm interfaces

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 42 ++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
index 55e4ac734023..67b6d4ec980e 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
@@ -330,6 +330,48 @@
 				clock-names = "pclk", "mclk";
 				status = "disabled";
 			};
+
+			tdmout_a: audio-controller at 500 {
+				compatible = "amlogic,axg-tdmout";
+				reg = <0x0 0x500 0x0 0x40>;
+				sound-name-prefix = "TDMOUT_A";
+				clocks = <&clkc_audio AUD_CLKID_TDMOUT_A>,
+					 <&clkc_audio AUD_CLKID_TDMOUT_A_SCLK>,
+					 <&clkc_audio AUD_CLKID_TDMOUT_A_SCLK_SEL>,
+					 <&clkc_audio AUD_CLKID_TDMOUT_A_LRCLK>,
+					 <&clkc_audio AUD_CLKID_TDMOUT_A_LRCLK>;
+				clock-names = "pclk", "sclk", "sclk_sel",
+					      "lrclk", "lrclk_sel";
+				status = "disabled";
+			};
+
+			tdmout_b: audio-controller at 540 {
+				compatible = "amlogic,axg-tdmout";
+				reg = <0x0 0x540 0x0 0x40>;
+				sound-name-prefix = "TDMOUT_B";
+				clocks = <&clkc_audio AUD_CLKID_TDMOUT_B>,
+					 <&clkc_audio AUD_CLKID_TDMOUT_B_SCLK>,
+					 <&clkc_audio AUD_CLKID_TDMOUT_B_SCLK_SEL>,
+					 <&clkc_audio AUD_CLKID_TDMOUT_B_LRCLK>,
+					 <&clkc_audio AUD_CLKID_TDMOUT_B_LRCLK>;
+				clock-names = "pclk", "sclk", "sclk_sel",
+					      "lrclk", "lrclk_sel";
+				status = "disabled";
+			};
+
+			tdmout_c: audio-controller at 580 {
+				compatible = "amlogic,axg-tdmout";
+				reg = <0x0 0x580 0x0 0x40>;
+				sound-name-prefix = "TDMOUT_C";
+				clocks = <&clkc_audio AUD_CLKID_TDMOUT_C>,
+					 <&clkc_audio AUD_CLKID_TDMOUT_C_SCLK>,
+					 <&clkc_audio AUD_CLKID_TDMOUT_C_SCLK_SEL>,
+					 <&clkc_audio AUD_CLKID_TDMOUT_C_LRCLK>,
+					 <&clkc_audio AUD_CLKID_TDMOUT_C_LRCLK>;
+				clock-names = "pclk", "sclk", "sclk_sel",
+					      "lrclk", "lrclk_sel";
+				status = "disabled";
+			};
 		};
 
 		cbus: bus at ffd00000 {
-- 
2.17.1
