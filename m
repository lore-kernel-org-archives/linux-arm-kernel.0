From: jbrunet@baylibre.com (Jerome Brunet)
Date: Mon, 16 Jul 2018 12:11:47 +0200
Subject: [PATCH 2/6] ARM64: dts: meson-axg: add adc buttons the S400
In-Reply-To: <20180716101151.31109-1-jbrunet@baylibre.com>
References: <20180716101151.31109-1-jbrunet@baylibre.com>
Message-ID: <20180716101151.31109-3-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the 6 adc buttons of the amlogic S400

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-axg-s400.dts | 44 ++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
index f389f84be2e2..fd90fa4a282c 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
@@ -6,11 +6,55 @@
 /dts-v1/;
 
 #include "meson-axg.dtsi"
+#include <dt-bindings/input/input.h>
 
 / {
 	compatible = "amlogic,s400", "amlogic,a113d", "amlogic,meson-axg";
 	model = "Amlogic Meson AXG S400 Development Board";
 
+	adc_keys {
+		compatible = "adc-keys";
+		io-channels = <&saradc 0>;
+		io-channel-names = "buttons";
+		keyup-threshold-microvolt = <1800000>;
+
+		button-next {
+			label = "Next";
+			linux,code = <KEY_NEXT>;
+			press-threshold-microvolt = <1116000>; /* 62% */
+		};
+
+		button-prev {
+			label = "Previous";
+			linux,code = <KEY_PREVIOUS>;
+			press-threshold-microvolt = <900000>; /* 50% */
+		};
+
+		button-wifi {
+			label = "Wifi";
+			linux,code = <KEY_WLAN>;
+			press-threshold-microvolt = <684000>; /* 38% */
+		};
+
+		button-up {
+			label = "Volume Up";
+			linux,code = <KEY_VOLUMEUP>;
+			press-threshold-microvolt = <468000>; /* 26% */
+		};
+
+		button-down {
+			label = "Volume Down";
+			linux,code = <KEY_VOLUMEDOWN>;
+			press-threshold-microvolt = <252000>; /* 14% */
+		};
+
+		button-voice {
+			label = "Voice";
+			linux,code = <KEY_VOICECOMMAND>;
+			press-threshold-microvolt = <0>; /* 0% */
+		};
+	};
+
 	aliases {
 		serial0 = &uart_AO;
 		serial1 = &uart_A;
-- 
2.14.4
