From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 22 Mar 2017 13:47:10 +0800
Subject: [PATCH] ARM: dts: sun6i: sina31s: Enable SPDIF out
Message-ID: <20170322054710.26395-1-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The SinA31s has a coaxial SPDIF output. Enable it.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun6i-a31s-sina31s.dts | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm/boot/dts/sun6i-a31s-sina31s.dts b/arch/arm/boot/dts/sun6i-a31s-sina31s.dts
index 7ff68bdd7109..b3d98222bd81 100644
--- a/arch/arm/boot/dts/sun6i-a31s-sina31s.dts
+++ b/arch/arm/boot/dts/sun6i-a31s-sina31s.dts
@@ -63,6 +63,23 @@
 			gpios = <&pio 7 13 GPIO_ACTIVE_HIGH>; /* PH13 */
 		};
 	};
+
+	sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "On-board SPDIF";
+		simple-audio-card,cpu {
+			sound-dai = <&spdif>;
+		};
+
+		simple-audio-card,codec {
+			sound-dai = <&spdif_out>;
+		};
+	};
+
+	spdif_out: spdif-out {
+		#sound-dai-cells = <0>;
+		compatible = "linux,spdif-dit";
+	};
 };
 
 &codec {
@@ -153,6 +170,12 @@
 	regulator-name = "vcc-gmac-phy";
 };
 
+&spdif {
+	pinctrl-names = "default";
+	pinctrl-0 = <&spdif_pins_a>;
+	status = "okay";
+};
+
 &usb_otg {
 	dr_mode = "peripheral";
 	status = "okay";
-- 
2.11.0
