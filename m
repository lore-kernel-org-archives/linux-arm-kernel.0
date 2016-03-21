From: codekipper@gmail.com (codekipper at gmail.com)
Date: Mon, 21 Mar 2016 21:01:05 +0100
Subject: [linux-sunxi][PATCH v3 7/8] ARM: dts: sun4i: Add SPDIF to the Mele
 A1000
In-Reply-To: <1458590466-12572-1-git-send-email-codekipper@gmail.com>
References: <1458590466-12572-1-git-send-email-codekipper@gmail.com>
Message-ID: <1458590466-12572-8-git-send-email-codekipper@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marcus Cooper <codekipper@gmail.com>

Enable the S/PDIF transmitter that is present on the A1000.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
---
 arch/arm/boot/dts/sun4i-a10-a1000.dts | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/sun4i-a10-a1000.dts b/arch/arm/boot/dts/sun4i-a10-a1000.dts
index 97570cb..c92a1ae 100644
--- a/arch/arm/boot/dts/sun4i-a10-a1000.dts
+++ b/arch/arm/boot/dts/sun4i-a10-a1000.dts
@@ -87,6 +87,24 @@
 		enable-active-high;
 		gpio = <&pio 7 15 GPIO_ACTIVE_HIGH>;
 	};
+
+	sound {
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
 
 &ahci {
@@ -188,6 +206,12 @@
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
2.7.4
