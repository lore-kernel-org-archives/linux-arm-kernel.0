From: jbrunet@baylibre.com (Jerome Brunet)
Date: Tue, 24 Jul 2018 14:52:28 +0200
Subject: [PATCH 04/14] arm64: dts: meson-axg: add audio arb reset controller
In-Reply-To: <20180724125238.14567-1-jbrunet@baylibre.com>
References: <20180724125238.14567-1-jbrunet@baylibre.com>
Message-ID: <20180724125238.14567-5-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the audio memory arbiter which control the access of the audio
fifos to the DDR.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
index 6adc8d3dbf0a..3893c630d969 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
@@ -189,6 +189,13 @@
 
 				resets = <&reset RESET_AUDIO>;
 			};
+
+			arb: reset-controller at 280 {
+				compatible = "amlogic,meson-axg-audio-arb";
+				reg = <0x0 0x280 0x0 0x4>;
+				#reset-cells = <1>;
+				clocks = <&clkc_audio AUD_CLKID_DDR_ARB>;
+			};
 		};
 
 		cbus: bus at ffd00000 {
-- 
2.17.1
