From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Tue, 27 Feb 2018 23:11:28 +0300
Subject: [PATCH v2 4/5] arm64: dts: renesas: r8a77970: add LVDS support
In-Reply-To: <23a6ac28-134b-b5dd-69a7-910774c4b8c1@cogentembedded.com>
References: <23a6ac28-134b-b5dd-69a7-910774c4b8c1@cogentembedded.com>
Message-ID: <04a6d33c-b1fc-c20a-2979-1174e9c3f4b0@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define the generic R8A77970 part of the LVDS device node.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
Changes in version 2:
- resolved rejects and updated atop of the DU support patch;
- changed the LVDS node's label/name;
- renamed the input/output endpoints' labels;
- added the "power-domains" and "resets" properties.

 arch/arm64/boot/dts/renesas/r8a77970.dtsi |   28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

Index: renesas/arch/arm64/boot/dts/renesas/r8a77970.dtsi
===================================================================
--- renesas.orig/arch/arm64/boot/dts/renesas/r8a77970.dtsi
+++ renesas/arch/arm64/boot/dts/renesas/r8a77970.dtsi
@@ -655,6 +655,34 @@
 				port at 1 {
 					reg = <1>;
 					du_out_lvds0: endpoint {
+						remote-endpoint = <&lvds0_in>;
+					};
+				};
+			};
+		};
+
+		lvds0: lvds-encoder at feb90000 {
+			compatible = "renesas,r8a77970-lvds";
+			reg = <0 0xfeb90000 0 0x14>;
+			clocks = <&cpg CPG_MOD 727>;
+			power-domains = <&sysc R8A77970_PD_ALWAYS_ON>;
+			resets = <&cpg 727>;
+			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port at 0 {
+					reg = <0>;
+					lvds0_in: endpoint {
+						remote-endpoint =
+							<&du_out_lvds0>;
+					};
+				};
+				port at 1 {
+					reg = <1>;
+					lvds0_out: endpoint {
 					};
 				};
 			};
