From: jiaheng.fan@nxp.com (Jiaheng Fan)
Date: Tue, 1 Aug 2017 02:04:20 +0000
Subject: [PATCH v1 1/6] dma: fsl-dma: add devicetree documentation for
 qdma driver.
In-Reply-To: <1501552044-6081-2-git-send-email-jiaheng.fan@nxp.com>
References: <1501552044-6081-2-git-send-email-jiaheng.fan@nxp.com>
Message-ID: <HE1PR04MB119677571300C8CDAD3A7F88F2B30@HE1PR04MB1196.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Redraw this patch, thanks.
Jiaheng

-----Original Message-----
From: jiaheng.fan [mailto:jiaheng.fan at nxp.com] 
Sent: Tuesday, August 01, 2017 9:47 AM
To: vinod.koul at intel.com; robh+dt at kernel.org; dan.j.williams at intel.com; mark.rutland at arm.com; linux at armlinux.org.uk; shawnguo at kernel.org
Cc: Leo Li <leoyang.li@nxp.com>; dmaengine at vger.kernel.org; linux-kernel at vger.kernel.org; linux-arm-kernel at lists.infradead.org; Jiafei Pan <jiafei.pan@nxp.com>; Jiaheng Fan <jiaheng.fan@nxp.com>
Subject: [PATCH v1 1/6] dma: fsl-dma: add devicetree documentation for qdma driver.

signed-off-by: jiaheng.fan <jiaheng.fan@nxp.com>
---
 Documentation/devicetree/bindings/dma/fsl-qdma.txt | 42 ++++++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/fsl-qdma.txt

diff --git a/Documentation/devicetree/bindings/dma/fsl-qdma.txt b/Documentation/devicetree/bindings/dma/fsl-qdma.txt
new file mode 100644
index 0000000..b076177
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/fsl-qdma.txt
@@ -0,0 +1,42 @@
+* Freescale queue Direct Memory Access Controller(qDMA) Controller
+
+  The qDMA controller transfers blocks of data between one source and 
+one or more destinations. The blocks of data transferred can be 
+represented in memory as contiguous or non-contiguous using 
+scatter/gather table(s). Channel virtualization is supported through 
+enqueuing of DMA jobs to, or dequeuing DMA jobs from, different work queues.
+
+* qDMA Controller
+Required properties:
+- compatible :
+	- "fsl,ls1021a-qdma",
+	Or "fsl,ls1043a-qdma" followed by "fsl,ls1021a-qdma",
+- reg : Specifies base physical address(s) and size of the qDMA registers.
+	The region is qDMA control register's address and size.
+- interrupts : A list of interrupt-specifiers, one for each entry in
+	interrupt-names.
+- interrupt-names : Should contain:
+	"qdma-error" - the error interrupt
+	"qdma-queue" - the queue interrupt
+- channels : Number of channels supported by the controller
+- queues : Number of queues supported by driver
+
+Optional properties:
+- big-endian: If present registers and hardware scatter/gather descriptors
+	of the qDMA are implemented in big endian mode, otherwise in little
+	mode.
+
+
+Examples:
+
+	qdma: qdma at 8390000 {
+		compatible = "fsl,ls1021a-qdma";
+		reg = <0x0 0x8398000 0x0 0x2000 /* Controller registers */
+		       0x0 0x839a000 0x0 0x2000>; /* Block registers */
+		interrupts = <GIC_SPI 185 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "qdma-error", "qdma-queue";
+		channels = <8>;
+		queues = <2>;
+		big-endian;
+	};
--
2.7.4
