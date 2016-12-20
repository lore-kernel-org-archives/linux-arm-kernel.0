From: codekipper@gmail.com (codekipper at gmail.com)
Date: Tue, 20 Dec 2016 11:40:38 +0100
Subject: [linux-sunxi][PATCH 3/3] ARM: dts: sun6i: Add SPDIF to the Mele I7
In-Reply-To: <20161220104038.22532-1-codekipper@gmail.com>
References: <20161220104038.22532-1-codekipper@gmail.com>
Message-ID: <20161220104038.22532-4-codekipper@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marcus Cooper <codekipper@gmail.com>

Enable the S/PDIF transmitter that is present on the Mele I7.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
---
 arch/arm/boot/dts/sun6i-a31-i7.dts | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/sun6i-a31-i7.dts b/arch/arm/boot/dts/sun6i-a31-i7.dts
index a2193309a199..2bc57d2dcd80 100644
--- a/arch/arm/boot/dts/sun6i-a31-i7.dts
+++ b/arch/arm/boot/dts/sun6i-a31-i7.dts
@@ -69,6 +69,23 @@
 			gpios = <&pio 7 13 GPIO_ACTIVE_HIGH>;
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
@@ -138,6 +155,13 @@
 	status = "okay";
 };
 
+&spdif {
+	pinctrl-names = "default";
+	pinctrl-0 = <&spdif_pins_a>;
+	spdif-out = "okay";
+	status = "okay";
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pins_a>;
-- 
2.11.0
