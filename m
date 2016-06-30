From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 01 Jul 2016 02:08:12 +0300
Subject: [PATCH 2/3] ARM: dts: blanche: add SCIF0/3 pins
In-Reply-To: <2144803.0K8qXzjIFq@wasted.cogentembedded.com>
References: <2144803.0K8qXzjIFq@wasted.cogentembedded.com>
Message-ID: <1489490.F0Oqgkmovy@wasted.cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the (previously omitted) SCIF0/3 pin data to the Blanche board's
device tree.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 arch/arm/boot/dts/r8a7792-blanche.dts |   18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

Index: renesas/arch/arm/boot/dts/r8a7792-blanche.dts
===================================================================
--- renesas.orig/arch/arm/boot/dts/r8a7792-blanche.dts
+++ renesas/arch/arm/boot/dts/r8a7792-blanche.dts
@@ -57,10 +57,28 @@
 	clock-frequency = <20000000>;
 };
 
+&pfc {
+	scif0_pins: scif0 {
+		groups = "scif0_data";
+		function = "scif0";
+	};
+
+	scif3_pins: scif3 {
+		groups = "scif3_data";
+		function = "scif3";
+	};
+};
+
 &scif0 {
+	pinctrl-0 = <&scif0_pins>;
+	pinctrl-names = "default";
+
 	status = "okay";
 };
 
 &scif3 {
+	pinctrl-0 = <&scif3_pins>;
+	pinctrl-names = "default";
+
 	status = "okay";
 };
