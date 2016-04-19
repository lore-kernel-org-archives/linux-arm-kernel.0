From: stuart.yoder@nxp.com (Stuart Yoder)
Date: Tue, 19 Apr 2016 16:53:17 -0500
Subject: [PATCH 2/2 v3] arm64: dts: ls2080a: fsl-mc dt node updates
Message-ID: <1461102797-30632-1-git-send-email-stuart.yoder@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

updates to the fsl-mc node for full functionality:
   -msi-parent is needed for interrupt support
   -ranges is needed to enable the bus driver to translate bus addresses
   -dpmac nodes provide a basis for relating dpmac objects to PHYs

Signed-off-by: Stuart Yoder <stuart.yoder@nxp.com>
---
-v3
   -updated unit addresses to be hex to match the reg properties.

 arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi | 98 ++++++++++++++++++++++++++
 1 file changed, 98 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi
index 9d746c6..0f21caf 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi
@@ -265,6 +265,104 @@
 			compatible = "fsl,qoriq-mc";
 			reg = <0x00000008 0x0c000000 0 0x40>,	 /* MC portal base */
 			      <0x00000000 0x08340000 0 0x40000>; /* MC control reg */
+			msi-parent = <&its>;
+			#address-cells = <3>;
+			#size-cells = <1>;
+
+			/*
+			 * Region type 0x0 - MC portals
+			 * Region type 0x1 - QBMAN portals
+			 */
+			ranges = <0x0 0x0 0x0 0x8 0x0c000000 0x4000000
+				  0x1 0x0 0x0 0x8 0x18000000 0x8000000>;
+
+			/*
+			 * Define the maximum number of MACs present on the SoC.
+			 */
+			dpmacs {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				dpmac1: dpmac at 1 {
+					compatible = "fsl,qoriq-mc-dpmac";
+					reg = <0x1>;
+				};
+
+				dpmac2: dpmac at 2 {
+					compatible = "fsl,qoriq-mc-dpmac";
+					reg = <0x2>;
+				};
+
+				dpmac3: dpmac at 3 {
+					compatible = "fsl,qoriq-mc-dpmac";
+					reg = <0x3>;
+				};
+
+				dpmac4: dpmac at 4 {
+					compatible = "fsl,qoriq-mc-dpmac";
+					reg = <0x4>;
+				};
+
+				dpmac5: dpmac at 5 {
+					compatible = "fsl,qoriq-mc-dpmac";
+					reg = <0x5>;
+				};
+
+				dpmac6: dpmac at 6 {
+					compatible = "fsl,qoriq-mc-dpmac";
+					reg = <0x6>;
+				};
+
+				dpmac7: dpmac at 7 {
+					compatible = "fsl,qoriq-mc-dpmac";
+					reg = <0x7>;
+				};
+
+				dpmac8: dpmac at 8 {
+					compatible = "fsl,qoriq-mc-dpmac";
+					reg = <0x8>;
+				};
+
+				dpmac9: dpmac at 9 {
+					compatible = "fsl,qoriq-mc-dpmac";
+					reg = <0x9>;
+				};
+
+				dpmac10: dpmac at a {
+					compatible = "fsl,qoriq-mc-dpmac";
+					reg = <0xa>;
+				};
+
+				dpmac11: dpmac at b {
+					compatible = "fsl,qoriq-mc-dpmac";
+					reg = <0xb>;
+				};
+
+				dpmac12: dpmac at c {
+					compatible = "fsl,qoriq-mc-dpmac";
+					reg = <0xc>;
+				};
+
+				dpmac13: dpmac at d {
+					compatible = "fsl,qoriq-mc-dpmac";
+					reg = <0xd>;
+				};
+
+				dpmac14: dpmac at e {
+					compatible = "fsl,qoriq-mc-dpmac";
+					reg = <0xe>;
+				};
+
+				dpmac15: dpmac at f {
+					compatible = "fsl,qoriq-mc-dpmac";
+					reg = <0xf>;
+				};
+
+				dpmac16: dpmac at 10 {
+					compatible = "fsl,qoriq-mc-dpmac";
+					reg = <0x10>;
+				};
+			};
 		};
 
 		smmu: iommu at 5000000 {
-- 
1.9.0
