From: Zhiqiang.Hou@nxp.com (Zhiqiang Hou)
Date: Mon, 18 Sep 2017 17:32:23 +0800
Subject: [PATCHv3 3/3] arm64: dts: ls1088a: add PCIe controller DT nodes
In-Reply-To: <20170918093223.33364-1-Zhiqiang.Hou@nxp.com>
References: <20170918093223.33364-1-Zhiqiang.Hou@nxp.com>
Message-ID: <20170918093223.33364-4-Zhiqiang.Hou@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

The LS1088a implements 3 PCIe 3.0 controllers.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
V3:
 - added 'arm64: ' prefix to the subject

 arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi | 73 ++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
index 97fcd8cbd118..d20336072c95 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
@@ -443,6 +443,79 @@
 				interrupts = <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>;
 			};
 		};
+
+		pcie at 3400000 {
+			compatible = "fsl,ls1088a-pcie", "snps,dw-pcie";
+			reg = <0x00 0x03400000 0x0 0x00100000   /* controller registers */
+			       0x20 0x00000000 0x0 0x00002000>; /* configuration space */
+			reg-names = "regs", "config";
+			interrupts = <0 108 IRQ_TYPE_LEVEL_HIGH>; /* aer interrupt */
+			interrupt-names = "aer";
+			#address-cells = <3>;
+			#size-cells = <2>;
+			device_type = "pci";
+			dma-coherent;
+			num-lanes = <4>;
+			bus-range = <0x0 0xff>;
+			ranges = <0x81000000 0x0 0x00000000 0x20 0x00010000 0x0 0x00010000   /* downstream I/O */
+				  0x82000000 0x0 0x40000000 0x20 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
+			msi-parent = <&its>;
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 7>;
+			interrupt-map = <0000 0 0 1 &gic 0 0 0 109 IRQ_TYPE_LEVEL_HIGH>,
+					<0000 0 0 2 &gic 0 0 0 110 IRQ_TYPE_LEVEL_HIGH>,
+					<0000 0 0 3 &gic 0 0 0 111 IRQ_TYPE_LEVEL_HIGH>,
+					<0000 0 0 4 &gic 0 0 0 112 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		pcie at 3500000 {
+			compatible = "fsl,ls1088a-pcie", "snps,dw-pcie";
+			reg = <0x00 0x03500000 0x0 0x00100000   /* controller registers */
+			       0x28 0x00000000 0x0 0x00002000>; /* configuration space */
+			reg-names = "regs", "config";
+			interrupts = <0 113 IRQ_TYPE_LEVEL_HIGH>; /* aer interrupt */
+			interrupt-names = "aer";
+			#address-cells = <3>;
+			#size-cells = <2>;
+			device_type = "pci";
+			dma-coherent;
+			num-lanes = <4>;
+			bus-range = <0x0 0xff>;
+			ranges = <0x81000000 0x0 0x00000000 0x28 0x00010000 0x0 0x00010000   /* downstream I/O */
+				  0x82000000 0x0 0x40000000 0x28 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
+			msi-parent = <&its>;
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 7>;
+			interrupt-map = <0000 0 0 1 &gic 0 0 0 114 IRQ_TYPE_LEVEL_HIGH>,
+					<0000 0 0 2 &gic 0 0 0 115 IRQ_TYPE_LEVEL_HIGH>,
+					<0000 0 0 3 &gic 0 0 0 116 IRQ_TYPE_LEVEL_HIGH>,
+					<0000 0 0 4 &gic 0 0 0 117 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		pcie at 3600000 {
+			compatible = "fsl,ls1088a-pcie", "snps,dw-pcie";
+			reg = <0x00 0x03600000 0x0 0x00100000   /* controller registers */
+			       0x30 0x00000000 0x0 0x00002000>; /* configuration space */
+			reg-names = "regs", "config";
+			interrupts = <0 118 IRQ_TYPE_LEVEL_HIGH>; /* aer interrupt */
+			interrupt-names = "aer";
+			#address-cells = <3>;
+			#size-cells = <2>;
+			device_type = "pci";
+			dma-coherent;
+			num-lanes = <8>;
+			bus-range = <0x0 0xff>;
+			ranges = <0x81000000 0x0 0x00000000 0x30 0x00010000 0x0 0x00010000   /* downstream I/O */
+				  0x82000000 0x0 0x40000000 0x30 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
+			msi-parent = <&its>;
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 7>;
+			interrupt-map = <0000 0 0 1 &gic 0 0 0 119 IRQ_TYPE_LEVEL_HIGH>,
+					<0000 0 0 2 &gic 0 0 0 120 IRQ_TYPE_LEVEL_HIGH>,
+					<0000 0 0 3 &gic 0 0 0 121 IRQ_TYPE_LEVEL_HIGH>,
+					<0000 0 0 4 &gic 0 0 0 122 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
 	};
 
 };
-- 
2.14.1
