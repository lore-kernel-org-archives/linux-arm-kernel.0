From: jbrunet@baylibre.com (Jerome Brunet)
Date: Tue, 24 Jul 2018 14:52:30 +0200
Subject: [PATCH 06/14] arm64: dts: meson-axg: add spdifout
In-Reply-To: <20180724125238.14567-1-jbrunet@baylibre.com>
References: <20180724125238.14567-1-jbrunet@baylibre.com>
Message-ID: <20180724125238.14567-7-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the SPDIF output device of the axg audio subsystem

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
index a20189844d92..c56016a48cc4 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
@@ -263,6 +263,17 @@
 				#reset-cells = <1>;
 				clocks = <&clkc_audio AUD_CLKID_DDR_ARB>;
 			};
+
+			spdifout: audio-controller at 480 {
+				compatible = "amlogic,axg-spdifout";
+				reg = <0x0 0x480 0x0 0x50>;
+				#sound-dai-cells = <0>;
+				sound-name-prefix = "SPDIFOUT";
+				clocks = <&clkc_audio AUD_CLKID_SPDIFOUT>,
+					 <&clkc_audio AUD_CLKID_SPDIFOUT_CLK>;
+				clock-names = "pclk", "mclk";
+				status = "disabled";
+			};
 		};
 
 		cbus: bus at ffd00000 {
-- 
2.17.1
