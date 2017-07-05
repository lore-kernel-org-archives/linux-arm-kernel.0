From: Zhiqiang.Hou@nxp.com (Zhiqiang Hou)
Date: Wed, 5 Jul 2017 14:59:00 +0800
Subject: [PATCHv4 6/9] arm64: dts: ls1046a: add MSI dts node
In-Reply-To: <1499237943-24203-1-git-send-email-Zhiqiang.Hou@nxp.com>
References: <1499237943-24203-1-git-send-email-Zhiqiang.Hou@nxp.com>
Message-ID: <1499237943-24203-6-git-send-email-Zhiqiang.Hou@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Minghuan Lian <Minghuan.Lian@nxp.com>

LS1046a includes 3 MSI controllers.
Each controller supports 128 interrupts.

Signed-off-by: Minghuan Lian <Minghuan.Lian@nxp.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
v4:
 - rebased code
v3-v2:
 - None
v2-v1:
 - change whitespace number

 .../interrupt-controller/fsl,ls-scfg-msi.txt       |  1 +
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi     | 31 ++++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/fsl,ls-scfg-msi.txt b/Documentation/devicetree/bindings/interrupt-controller/fsl,ls-scfg-msi.txt
index 2755cd1..dde4552 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/fsl,ls-scfg-msi.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/fsl,ls-scfg-msi.txt
@@ -6,6 +6,7 @@ Required properties:
 	      Layerscape PCIe MSI controller block such as:
               "fsl,ls1021a-msi"
               "fsl,ls1043a-msi"
+              "fsl,ls1046a-msi"
 - msi-controller: indicates that this is a PCIe MSI controller node
 - reg: physical base address of the controller and length of memory mapped.
 - interrupts: an interrupt to the parent interrupt controller.
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
index dc1640b..c8ff0ba 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
@@ -630,6 +630,37 @@
 			interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clockgen 4 1>;
 		};
+
+		msi1: msi-controller at 1580000 {
+			compatible = "fsl,ls1046a-msi";
+			msi-controller;
+			reg = <0x0 0x1580000 0x0 0x10000>;
+			interrupts = <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		msi2: msi-controller at 1590000 {
+			compatible = "fsl,ls1046a-msi";
+			msi-controller;
+			reg = <0x0 0x1590000 0x0 0x10000>;
+			interrupts = <GIC_SPI 126 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		msi3: msi-controller at 15a0000 {
+			compatible = "fsl,ls1046a-msi";
+			msi-controller;
+			reg = <0x0 0x15a0000 0x0 0x10000>;
+			interrupts = <GIC_SPI 160 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 157 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
 	};
 
 	reserved-memory {
-- 
2.1.0.27.g96db324
