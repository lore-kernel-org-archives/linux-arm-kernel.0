From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Fri, 12 Oct 2018 20:32:30 -0700
Subject: [PATCH 10/10] arm64: dts: allwinner: a64: enable sound on Pinebook
In-Reply-To: <20181013033230.6506-1-anarsoul@gmail.com>
References: <20181013033230.6506-1-anarsoul@gmail.com>
Message-ID: <20181013033230.6506-11-anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit enables I2S, digital and analog parts of audiocodec on
Pinebook

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 .../dts/allwinner/sun50i-a64-pinebook.dts     | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
index e2e426334cfe..3145459722c7 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
@@ -76,6 +76,19 @@
 	};
 };
 
+&codec {
+	allwinner,pa-gpios = <&pio 7 7 GPIO_ACTIVE_HIGH>;
+	status = "okay";
+};
+
+&codec_analog {
+	status = "okay";
+};
+
+&dai {
+	status = "okay";
+};
+
 &ehci0 {
 	phys = <&usbphy 0>;
 	phy-names = "usb";
@@ -278,6 +291,26 @@
 	vcc-hdmi-supply = <&reg_dldo1>;
 };
 
+&sound {
+	status = "okay";
+	simple-audio-card,widgets = "Microphone", "Microphone Jack",
+				    "Headphone", "Headphone Jack";
+	simple-audio-card,routing =
+			"Left DAC", "AIF1 Slot 0 Left",
+			"Right DAC", "AIF1 Slot 0 Right",
+			"Speaker", "LINEOUT",
+			"Headphone Jack", "HP",
+			"AIF1 Slot 0 Left ADC", "Left ADC",
+			"AIF1 Slot 0 Right ADC", "Right ADC",
+			"Left ADC", "ADC",
+			"Right ADC", "ADC",
+			"Mic", "MBIAS",
+			"MIC1", "Mic",
+			"Headset Mic", "Microphone Jack",
+			"Microphone Jack", "HBIAS",
+			"MIC2", "Headset Mic";
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pins_a>;
-- 
2.19.0
