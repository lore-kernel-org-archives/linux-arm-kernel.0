From: maitysanchayan@gmail.com (Sanchayan Maity)
Date: Mon,  2 May 2016 12:35:04 +0530
Subject: [PATCH v2 5/5] vf610-soc: Add Vybrid SoC device tree binding
 documentation
In-Reply-To: <cover.1462171989.git.maitysanchayan@gmail.com>
References: <cover.1462171989.git.maitysanchayan@gmail.com>
Message-ID: <65f3a7bd7a9faf1b390644d7c599c69683c753c4.1462171990.git.maitysanchayan@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add device tree binding documentation for Vybrid SoC.

Signed-off-by: Sanchayan Maity <maitysanchayan@gmail.com>
---
 .../bindings/arm/freescale/fsl,vf610-soc.txt       | 35 ++++++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/freescale/fsl,vf610-soc.txt

diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,vf610-soc.txt b/Documentation/devicetree/bindings/arm/freescale/fsl,vf610-soc.txt
new file mode 100644
index 0000000..bdd95e8
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/freescale/fsl,vf610-soc.txt
@@ -0,0 +1,35 @@
+Vybrid System-on-Chip
+---------------------
+
+Required properties:
+
+- #address-cells: must be 1
+- #size-cells: must be 1
+- compatible: "fsl,vf610-soc-bus", "simple-bus"
+- interrupt-parent: phandle to the MSCM interrupt router node
+- ranges
+- fsl,rom-revision: phandle to the on-chip ROM node and address of rom
+  revision register
+- fsl,cpu-count: phandle to the MSCM CPU configuration node and address of
+  CPU count register
+- fsl,l2-size: phandle to the MSCM CPU configuration node and address of
+  L2 cache size register
+- nvmem-cells: phandles to two OCOTP child nodes ocotp_cfg0 and ocotp_cfg1
+- nvmem-cell-names: should contain string names "cfg0" and "cfg1"
+
+Example:
+
+	soc {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "fsl,vf610-soc-bus", "simple-bus";
+		interrupt-parent = <&mscm_ir>;
+		ranges;
+		fsl,rom-revision = <&ocrom 0x80>;
+		fsl,cpu-count = <&mscm_cpucfg 0x2C>;
+		fsl,l2-size = <&mscm_cpucfg 0x14>;
+		nvmem-cells = <&ocotp_cfg0>, <&ocotp_cfg1>;
+		nvmem-cell-names = "cfg0", "cfg1";
+
+		...
+	};
-- 
2.8.2
