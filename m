From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 15 Jul 2016 00:00:56 +0300
Subject: [PATCH v3 2/3] ARM: dts: blanche: add SCIF0/3 pins
In-Reply-To: <5383928.8UnDsUpmkz@wasted.cogentembedded.com>
References: <5383928.8UnDsUpmkz@wasted.cogentembedded.com>
Message-ID: <1892268.VJ4rFquWrh@wasted.cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the (previously omitted) SCIF0/3 pin data to the Blanche board's
device tree.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

---
Changes in version 2:
- added Geert's tag.

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
