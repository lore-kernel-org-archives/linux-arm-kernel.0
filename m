From: codekipper@gmail.com (codekipper at gmail.com)
Date: Fri, 27 Jan 2017 16:48:08 +0100
Subject: [linux-sunxi][PATCH 3/3] ARM: dts: sun8i-h3: Add SPDIF to the Beelink
 X2
In-Reply-To: <20170127154808.19229-1-codekipper@gmail.com>
References: <20170127154808.19229-1-codekipper@gmail.com>
Message-ID: <20170127154808.19229-4-codekipper@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marcus Cooper <codekipper@gmail.com>

Enable the S/PDIF transmitter that is present on the Beelink X2 STB.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
---
 arch/arm/boot/dts/sun8i-h3-beelink-x2.dts | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts b/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts
index 2a016cd16a27..25b225b7dfd6 100644
--- a/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts
+++ b/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts
@@ -81,6 +81,24 @@
 		compatible = "mmc-pwrseq-simple";
 		reset-gpios = <&r_pio 0 7 GPIO_ACTIVE_LOW>; /* PL7 */
 	};
+
+	sound_spdif {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "On-board SPDIF";
+
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
 
 &ehci1 {
@@ -124,6 +142,12 @@
 	status = "okay";
 };
 
+&spdif {
+	pinctrl-names = "default";
+	pinctrl-0 = <&spdif_tx_pins_a>;
+	status = "okay";
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pins_a>;
-- 
2.11.0
