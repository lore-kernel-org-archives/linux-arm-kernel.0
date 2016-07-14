From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 14 Jul 2016 14:02:01 -0700 (PDT)
Subject: [PATCH v3 3/3] ARM: dts: blanche: add Ethernet pins
In-Reply-To: <5383928.8UnDsUpmkz@wasted.cogentembedded.com>
References: <5383928.8UnDsUpmkz@wasted.cogentembedded.com>
Message-ID: <2472815.TZ6Lha6VX2@wasted.cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the (previously omitted) pin data for the SMSC LAN89218 Ethernet chip
to  the Blanche board's device tree:  the chip's IRQ output is connected to
the SoC's IRQ0 pin and its nCS input is connected to the SoC's EX_CS0# pin.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
Changes in version 3:
- killed extra empty line;
- reformatted the changelog.

 arch/arm/boot/dts/r8a7792-blanche.dts |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

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
 
@@ -67,6 +70,17 @@
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
 };
 
 &scif0 {
