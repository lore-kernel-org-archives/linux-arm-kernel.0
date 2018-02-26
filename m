From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Mon, 26 Feb 2018 23:55:43 +0300
Subject: [PATCH v2 2/2] arm64: dts: renesas: eagle: add I2C0 support
In-Reply-To: <3aaa4464-fc85-3fb4-2026-5d9df357bdff@cogentembedded.com>
References: <3aaa4464-fc85-3fb4-2026-5d9df357bdff@cogentembedded.com>
Message-ID: <f830570f-f7e7-b277-172a-360a20de1aaf@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define the Eagle board dependent part of the I2C0 device node.

The I2C0 bus is populated by ON Semiconductor PCA9653 I/O expander and
Analog Devices ADV7511W HDMI transmitter (but we're only describing the
former chip now).

Based on the original (and large) patch by Vladimir Barinov.

Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
Changes in version 2:
- resolved rejects (with the patch adding EtherAVB pins removed for now).

 arch/arm64/boot/dts/renesas/r8a77970-eagle.dts |   20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

Index: renesas/arch/arm64/boot/dts/renesas/r8a77970-eagle.dts
===================================================================
--- renesas.orig/arch/arm64/boot/dts/renesas/r8a77970-eagle.dts
+++ renesas/arch/arm64/boot/dts/renesas/r8a77970-eagle.dts
@@ -54,7 +54,27 @@
 	clock-frequency = <32768>;
 };
 
+&i2c0 {
+	pinctrl-0 = <&i2c0_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
+	clock-frequency = <400000>;
+
+	io_expander: gpio at 20 {
+		compatible = "onnn,pca9654";
+		reg = <0x20>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+};
+
 &pfc {
+	i2c0_pins: i2c0 {
+		groups = "i2c0";
+		function = "i2c0";
+	};
+
 	scif0_pins: scif0 {
 		groups = "scif0_data";
 		function = "scif0";
