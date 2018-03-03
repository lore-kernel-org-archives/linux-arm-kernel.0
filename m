From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sat, 3 Mar 2018 22:07:16 +0300
Subject: [PATCH v3 2/2] arm64: dts: renesas: eagle: add I2C0 support
In-Reply-To: <23c5b1f4-d92b-455f-7288-5aabd002183a@cogentembedded.com>
References: <23c5b1f4-d92b-455f-7288-5aabd002183a@cogentembedded.com>
Message-ID: <30bfc66d-2bfb-4d6e-8bdc-fcd9cb9522c2@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define the Eagle board dependent part of the I2C0 device node.

The I2C0 bus is populated by ON Semiconductor PCA9653 I/O expander and
Analog Devices ADV7511W HDMI transmitter (but we're only describing the
former chip now).

Based on the original (and large) patch by Vladimir Barinov.

Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

---
Changes in version 3:
- added Geert's tag.

Changes in version 2:
- refreshed with the patch adding EtherAVB pins removed for now...

 arch/arm64/boot/dts/renesas/r8a77970-eagle.dts |   20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

Index: renesas/arch/arm64/boot/dts/renesas/r8a77970-eagle.dts
===================================================================
--- renesas.orig/arch/arm64/boot/dts/renesas/r8a77970-eagle.dts
+++ renesas/arch/arm64/boot/dts/renesas/r8a77970-eagle.dts
@@ -55,7 +55,27 @@
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
