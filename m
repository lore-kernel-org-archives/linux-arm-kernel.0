From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Tue, 21 Feb 2017 00:31:12 +0300
Subject: [PATCH] arm64: dts: r8a7796: add IMR-LX4 support
Message-ID: <20170220213129.182097269@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Describe the IMR-LX4 devices in the R8A7796 device tree.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
This patch is against the 'renesas-devel-20170217-v4.10-rc8' tag of Simon
Horman's 'renesas.git' repo.

The IMR-LX4 binding was documented in the IMR driver patch; I don't expect it
to  change  even if the driver  would be  rewritten  for DRM...

 arch/arm64/boot/dts/renesas/r8a7796.dtsi |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

Index: renesas/arch/arm64/boot/dts/renesas/r8a7796.dtsi
===================================================================
--- renesas.orig/arch/arm64/boot/dts/renesas/r8a7796.dtsi
+++ renesas/arch/arm64/boot/dts/renesas/r8a7796.dtsi
@@ -904,5 +904,21 @@
 				};
 			};
 		};
+
+		imr-lx4 at fe860000 {
+			compatible = "renesas,imr-lx4";
+			reg = <0 0xfe860000 0 0x2000>;
+			interrupts = <GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 823>;
+			power-domains = <&sysc R8A7796_PD_A3VC>;
+		};
+
+		imr-lx4 at fe870000 {
+			compatible = "renesas,imr-lx4";
+			reg = <0 0xfe870000 0 0x2000>;
+			interrupts = <GIC_SPI 193 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 822>;
+			power-domains = <&sysc R8A7796_PD_A3VC>;
+		};
 	};
 };
