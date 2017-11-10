From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 10 Nov 2017 23:02:20 +0300
Subject: [PATCH 2/3] arm64: dts: renesas: eagle: add SCIF0 pins
Message-ID: <20171110200710.769271617@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the (previously omitted) SCIF0 pin data to the Eagle board's
device tree.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 arch/arm64/boot/dts/renesas/r8a77970-eagle.dts |   10 ++++++++++
 1 file changed, 10 insertions(+)

Index: renesas/arch/arm64/boot/dts/renesas/r8a77970-eagle.dts
===================================================================
--- renesas.orig/arch/arm64/boot/dts/renesas/r8a77970-eagle.dts
+++ renesas/arch/arm64/boot/dts/renesas/r8a77970-eagle.dts
@@ -52,11 +52,21 @@
 	clock-frequency = <32768>;
 };
 
+&pfc {
+	scif0_pins: scif0 {
+		groups = "scif0_data";
+		function = "scif0";
+	};
+};
+
 &rwdt {
 	timeout-sec = <60>;
 	status = "okay";
 };
 
 &scif0 {
+	pinctrl-0 = <&scif0_pins>;
+	pinctrl-names = "default";
+
 	status = "okay";
 };
