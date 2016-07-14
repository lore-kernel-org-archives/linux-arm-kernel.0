From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 14 Jul 2016 23:21:15 +0300
Subject: [PATCH 3/3] ARM: dts: blanche: add CAN0 support
In-Reply-To: <34968644.DhifNderY8@wasted.cogentembedded.com>
References: <34968644.DhifNderY8@wasted.cogentembedded.com>
Message-ID: <14988679.oTJc4uy6At@wasted.cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define the Blanche board dependent part of the CAN0 device node along with
the CAN_CLK crystal...

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 arch/arm/boot/dts/r8a7792-blanche.dts |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

Index: renesas/arch/arm/boot/dts/r8a7792-blanche.dts
===================================================================
--- renesas.orig/arch/arm/boot/dts/r8a7792-blanche.dts
+++ renesas/arch/arm/boot/dts/r8a7792-blanche.dts
@@ -60,6 +60,10 @@
 	clock-frequency = <20000000>;
 };
 
+&can_clk {
+	clock-frequency = <48000000>;
+};
+
 &pfc {
 	scif0_pins: scif0 {
 		groups = "scif0_data";
@@ -81,6 +85,11 @@
 			function = "lbsc";
 		};
 	};
+
+	can0_pins: can0 {
+		groups = "can0_data", "can_clk";
+		function = "can0";
+	};
 };
 
 &scif0 {
@@ -95,4 +104,11 @@
 	pinctrl-names = "default";
 
 	status = "okay";
+};
+
+&can0 {
+	pinctrl-0 = <&can0_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
 };
