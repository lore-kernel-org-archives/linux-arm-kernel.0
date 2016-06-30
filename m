From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 01 Jul 2016 02:08:55 +0300
Subject: [PATCH 3/3] ARM: dts: blanche: add Ethernet pins
In-Reply-To: <2144803.0K8qXzjIFq@wasted.cogentembedded.com>
References: <2144803.0K8qXzjIFq@wasted.cogentembedded.com>
Message-ID: <3303208.PZCWAdujda@wasted.cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the (previously omitted) pin data for the SMSC LAN89218 Ethernet chip
to the Blanche board's device tree: the chip's IRQ output is connected to
the SoC's IRQ0 pin and its nCS input is connected to the SoC's EX_CS0# pin.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 arch/arm/boot/dts/r8a7792-blanche.dts |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

Index: renesas/arch/arm/boot/dts/r8a7792-blanche.dts
===================================================================
--- renesas.orig/arch/arm/boot/dts/r8a7792-blanche.dts
+++ renesas/arch/arm/boot/dts/r8a7792-blanche.dts
@@ -50,6 +50,9 @@
 		reg-io-width = <4>;
 		vddvario-supply = <&d3_3v>;
 		vdd33a-supply = <&d3_3v>;
+
+		pinctrl-0 = <&lan89218_pins>;
+		pinctrl-names = "default";
 	};
 };
 
@@ -67,6 +70,18 @@
 		groups = "scif3_data";
 		function = "scif3";
 	};
+
+	lan89218_pins: lan89218 {
+		intc {
+			groups = "intc_irq0";
+			function = "intc";
+		};
+		lbsc {
+			groups = "lbsc_ex_cs0";
+			function = "lbsc";
+		};
+	};
+
 };
 
 &scif0 {
