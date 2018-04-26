From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 26 Apr 2018 23:34:35 +0300
Subject: [PATCH 2/2] arm64: dts: renesas: eagle: add CAN-FD support
In-Reply-To: <4e5216bc-5f1b-ace4-1aea-02269cd206ac@cogentembedded.com>
References: <4e5216bc-5f1b-ace4-1aea-02269cd206ac@cogentembedded.com>
Message-ID: <87aa94b9-5f5f-f23e-3852-b71caeeae7b5@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define the Eagle board dependent part of the CAN-FD device node.

Based on the original (and large) patch by Vladimir Barinov.

Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 arch/arm64/boot/dts/renesas/r8a77970-eagle.dts |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

Index: renesas/arch/arm64/boot/dts/renesas/r8a77970-eagle.dts
===================================================================
--- renesas.orig/arch/arm64/boot/dts/renesas/r8a77970-eagle.dts
+++ renesas/arch/arm64/boot/dts/renesas/r8a77970-eagle.dts
@@ -95,6 +95,16 @@
 	};
 };
 
+&canfd {
+	pinctrl-0 = <&canfd0_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	channel0 {
+		status = "okay";
+	};
+};
+
 &extal_clk {
 	clock-frequency = <16666666>;
 };
@@ -156,6 +166,11 @@
 		function = "avb0";
 	};
 
+	canfd0_pins: canfd0 {
+		groups = "canfd0_data_a";
+		function = "canfd0";
+	};
+
 	i2c0_pins: i2c0 {
 		groups = "i2c0";
 		function = "i2c0";
