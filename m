From: jiaheng.fan@nxp.com (jiaheng.fan)
Date: Tue, 1 Aug 2017 10:14:11 +0800
Subject: [PATCH v1 6/6] arm64: dts: ls1043/ls1046: add qdma note to dtsi
In-Reply-To: <1501553651-7203-1-git-send-email-jiaheng.fan@nxp.com>
References: <1501553651-7203-1-git-send-email-jiaheng.fan@nxp.com>
Message-ID: <1501553651-7203-7-git-send-email-jiaheng.fan@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: jiaheng.fan <jiaheng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi | 15 +++++++++++++++
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi | 15 +++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
index 31fd77f..78c534c 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
@@ -652,6 +652,21 @@
 			dma-coherent;
 		};
 
+		qdma: qdma at 8380000 {
+			compatible = "fsl,ls1043a-qdma";
+			reg = <0x0 0x8380000 0x0 0x1000>, /* Controller regs */
+			      <0x0 0x8390000 0x0 0x10000>, /* Status regs */
+			      <0x0 0x83a0000 0x0 0x40000>; /* Block regs */
+			interrupts = <0 152 0x4>,
+				     <0 39 0x4>;
+			interrupt-names = "qdma-error", "qdma-queue";
+			channels = <8>;
+			queues = <2>;
+			status-sizes = <64>;
+			queue-sizes = <64 64>;
+			big-endian;
+		};
+
 		msi1: msi-controller1 at 1571000 {
 			compatible = "fsl,1s1043a-msi";
 			reg = <0x0 0x1571000 0x0 0x8>;
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
index dc1640b..4419df8 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
@@ -595,6 +595,21 @@
 				 <&clockgen 4 1>;
 		};
 
+		qdma: qdma at 8380000 {
+			compatible = "fsl,ls1046a-qdma";
+			reg = <0x0 0x8380000 0x0 0x1000>, /* Controller regs */
+			      <0x0 0x8390000 0x0 0x10000>, /* Status regs */
+			      <0x0 0x83a0000 0x0 0x40000>; /* Block regs */
+			interrupts = <0 153 0x4>,
+				     <0 39 0x4>;
+			interrupt-names = "qdma-error", "qdma-queue";
+			channels = <8>;
+			queues = <2>;
+			status-sizes = <64>;
+			queue-sizes = <64 64>;
+			big-endian;
+		};
+
 		usb0: usb at 2f00000 {
 			compatible = "snps,dwc3";
 			reg = <0x0 0x2f00000 0x0 0x10000>;
-- 
2.7.4
