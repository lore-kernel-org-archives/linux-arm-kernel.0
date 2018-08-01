From: jbrunet@baylibre.com (Jerome Brunet)
Date: Wed,  1 Aug 2018 15:40:31 +0200
Subject: [PATCH v2 1/3] arm64: dts: meson-axg: add audio fifos
In-Reply-To: <20180801134033.21739-1-jbrunet@baylibre.com>
References: <20180801134033.21739-1-jbrunet@baylibre.com>
Message-ID: <20180801134033.21739-2-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add TODDR and FRDDR audio fifos of the AXG SoC.
These fifos are the capture and playback memory interfaces of audio
subsystem of the AXG.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 67 ++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
index c518130e5ce7..32f6dcacc2bc 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
@@ -11,6 +11,7 @@
 #include <dt-bindings/clock/axg-aoclkc.h>
 #include <dt-bindings/gpio/meson-axg-gpio.h>
 #include <dt-bindings/reset/amlogic,meson-axg-reset.h>
+#include <dt-bindings/reset/amlogic,meson-axg-audio-arb.h>
 
 / {
 	compatible = "amlogic,meson-axg";
@@ -223,6 +224,72 @@
 				resets = <&reset RESET_AUDIO>;
 			};
 
+			toddr_a: audio-controller at 100 {
+				compatible = "amlogic,axg-toddr";
+				reg = <0x0 0x100 0x0 0x1c>;
+				#sound-dai-cells = <0>;
+				sound-name-prefix = "TODDR_A";
+				interrupts = <GIC_SPI 84 IRQ_TYPE_EDGE_RISING>;
+				clocks = <&clkc_audio AUD_CLKID_TODDR_A>;
+				resets = <&arb AXG_ARB_TODDR_A>;
+				status = "disabled";
+			};
+
+			toddr_b: audio-controller at 140 {
+				compatible = "amlogic,axg-toddr";
+				reg = <0x0 0x140 0x0 0x1c>;
+				#sound-dai-cells = <0>;
+				sound-name-prefix = "TODDR_B";
+				interrupts = <GIC_SPI 85 IRQ_TYPE_EDGE_RISING>;
+				clocks = <&clkc_audio AUD_CLKID_TODDR_B>;
+				resets = <&arb AXG_ARB_TODDR_B>;
+				status = "disabled";
+			};
+
+			toddr_c: audio-controller at 180 {
+				compatible = "amlogic,axg-toddr";
+				reg = <0x0 0x180 0x0 0x1c>;
+				#sound-dai-cells = <0>;
+				sound-name-prefix = "TODDR_C";
+				interrupts = <GIC_SPI 86 IRQ_TYPE_EDGE_RISING>;
+				clocks = <&clkc_audio AUD_CLKID_TODDR_C>;
+				resets = <&arb AXG_ARB_TODDR_C>;
+				status = "disabled";
+			};
+
+			frddr_a: audio-controller at 1c0 {
+				compatible = "amlogic,axg-frddr";
+				reg = <0x0 0x1c0 0x0 0x1c>;
+				#sound-dai-cells = <0>;
+				sound-name-prefix = "FRDDR_A";
+				interrupts = <GIC_SPI 88 IRQ_TYPE_EDGE_RISING>;
+				clocks = <&clkc_audio AUD_CLKID_FRDDR_A>;
+				resets = <&arb AXG_ARB_FRDDR_A>;
+				status = "disabled";
+			};
+
+			frddr_b: audio-controller at 200 {
+				compatible = "amlogic,axg-frddr";
+				reg = <0x0 0x200 0x0 0x1c>;
+				#sound-dai-cells = <0>;
+				sound-name-prefix = "FRDDR_B";
+				interrupts = <GIC_SPI 89 IRQ_TYPE_EDGE_RISING>;
+				clocks = <&clkc_audio AUD_CLKID_FRDDR_B>;
+				resets = <&arb AXG_ARB_FRDDR_B>;
+				status = "disabled";
+			};
+
+			frddr_c: audio-controller at 240 {
+				compatible = "amlogic,axg-frddr";
+				reg = <0x0 0x240 0x0 0x1c>;
+				#sound-dai-cells = <0>;
+				sound-name-prefix = "FRDDR_C";
+				interrupts = <GIC_SPI 90 IRQ_TYPE_EDGE_RISING>;
+				clocks = <&clkc_audio AUD_CLKID_FRDDR_C>;
+				resets = <&arb AXG_ARB_FRDDR_C>;
+				status = "disabled";
+			};
+
 			arb: reset-controller at 280 {
 				compatible = "amlogic,meson-axg-audio-arb";
 				reg = <0x0 0x280 0x0 0x4>;
-- 
2.17.1
