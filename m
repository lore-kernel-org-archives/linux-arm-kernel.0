From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Tue, 27 Jun 2017 20:33:44 +0300
Subject: [PATCH v2] arm64: dts: r8a7796: add IMR-LX4 support
Message-ID: <20170627173400.581660959@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Describe the IMR-LX4 devices in the R8A7796 device tree.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
This patch is against the 'renesas-devel-20170626-v4.12-rc7' tag of Simon
Horman's 'renesas.git' repo.

The IMR-LX4 bindings were documented in the IMR driver patch and ACK'ed by Rob
Herring, so I don't expect them to change...

Changes in version 2:
- added SoC specific "compatible" prop values;
- refreshed the patch.

 arch/arm64/boot/dts/renesas/r8a7796.dtsi |   18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

Index: renesas/arch/arm64/boot/dts/renesas/r8a7796.dtsi
===================================================================
--- renesas.orig/arch/arm64/boot/dts/renesas/r8a7796.dtsi
+++ renesas/arch/arm64/boot/dts/renesas/r8a7796.dtsi
@@ -1454,5 +1454,23 @@
 				};
 			};
 		};
+
+		imr-lx4 at fe860000 {
+			compatible = "renesas,r8a7796-imr-lx4",
+				     "renesas,imr-lx4";
+			reg = <0 0xfe860000 0 0x2000>;
+			interrupts = <GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 823>;
+			power-domains = <&sysc R8A7796_PD_A3VC>;
+		};
+
+		imr-lx4 at fe870000 {
+			compatible = "renesas,r8a7796-imr-lx4",
+				     "renesas,imr-lx4";
+			reg = <0 0xfe870000 0 0x2000>;
+			interrupts = <GIC_SPI 193 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 822>;
+			power-domains = <&sysc R8A7796_PD_A3VC>;
+		};
 	};
 };
