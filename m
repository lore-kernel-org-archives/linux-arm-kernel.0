From: ioana.ciornei@nxp.com (Ioana Ciornei)
Date: Wed, 8 Nov 2017 15:30:05 +0200
Subject: [PATCH] arm64: dts: ls1088a: add fsl-mc hardware resource manager node
Message-ID: <1510147805-24873-1-git-send-email-ioana.ciornei@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the fsl-mc node in the LS1088A device tree.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi | 62 ++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
index bd80e9a..aa37ffe 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
@@ -166,6 +166,68 @@
 			     <1 10 IRQ_TYPE_LEVEL_LOW>;/* Hypervisor PPI */
 	};
 
+	fsl_mc: fsl-mc at 80c000000 {
+		compatible = "fsl,qoriq-mc";
+		reg = <0x00000008 0x0c000000 0 0x40>,	 /* MC portal base */
+		      <0x00000000 0x08340000 0 0x40000>; /* MC control reg */
+		msi-parent = <&its>;
+		#address-cells = <3>;
+		#size-cells = <1>;
+
+		/*
+		 * Region type 0x0 - MC portals
+		 * Region type 0x1 - QBMAN portals
+		 */
+		ranges = <0x0 0x0 0x0 0x8 0x0c000000 0x4000000
+			  0x1 0x0 0x0 0x8 0x18000000 0x8000000>;
+
+		dpmacs {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			dpmac1: dpmac at 1 {
+				compatible = "fsl,qoriq-mc-dpmac";
+				reg = <1>;
+			};
+			dpmac2: dpmac at 2 {
+				compatible = "fsl,qoriq-mc-dpmac";
+				reg = <2>;
+			};
+			dpmac3: dpmac at 3 {
+				compatible = "fsl,qoriq-mc-dpmac";
+				reg = <3>;
+			};
+			dpmac4: dpmac at 4 {
+				compatible = "fsl,qoriq-mc-dpmac";
+				reg = <4>;
+			};
+			dpmac5: dpmac at 5 {
+				compatible = "fsl,qoriq-mc-dpmac";
+				reg = <5>;
+			};
+			dpmac6: dpmac at 6 {
+				compatible = "fsl,qoriq-mc-dpmac";
+				reg = <6>;
+			};
+			dpmac7: dpmac at 7 {
+				compatible = "fsl,qoriq-mc-dpmac";
+				reg = <7>;
+			};
+			dpmac8: dpmac at 8 {
+				compatible = "fsl,qoriq-mc-dpmac";
+				reg = <8>;
+			};
+			dpmac9: dpmac at 9 {
+				compatible = "fsl,qoriq-mc-dpmac";
+				reg = <9>;
+			};
+			dpmac10: dpmac at 10 {
+				compatible = "fsl,qoriq-mc-dpmac";
+				reg = <0xa>;
+			};
+		};
+	};
+
 	psci {
 		compatible = "arm,psci-0.2";
 		method = "smc";
-- 
1.9.1
