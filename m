From: andrea.merello@gmail.com (Andrea Merello)
Date: Tue, 20 Nov 2018 16:31:47 +0100
Subject: [PATCH v6 3/7] dt-bindings: dmaengine: xilinx_dma: add optional xlnx,
 sg-length-width property
In-Reply-To: <20181120153151.18024-1-andrea.merello@gmail.com>
References: <20181120153151.18024-1-andrea.merello@gmail.com>
Message-ID: <20181120153151.18024-3-andrea.merello@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The width of the "length register" cannot be autodetected, and it is now
specified with a DT property. Add documentation for it.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: devicetree at vger.kernel.org
Cc: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
---
Changes in v2:
	- change property name
	- property is now optional
	- cc DT maintainer
Changes in v3:
	- reword
	- cc DT maintainerS and ML
Changes in v4:
	- specify the unit, the valid range and the default value
Changes in v5:
	- commit message trivial fix
	- fix spaces before tab
Changes in v6:
	None
---
 Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt b/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
index 174af2c45e77..2fce9fb4b270 100644
--- a/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
+++ b/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
@@ -41,6 +41,10 @@ Optional properties:
 - xlnx,include-sg: Tells configured for Scatter-mode in
 	the hardware.
 Optional properties for AXI DMA:
+- xlnx,sg-length-width: Should be set to the width in bits of the length
+	register as configured in h/w. Takes values {8...26}. If the property
+	is missing or invalid then the default value 23 is used. This is the
+	maximum value that is supported by all IP versions.
 - xlnx,mcdma: Tells whether configured for multi-channel mode in the hardware.
 Optional properties for VDMA:
 - xlnx,flush-fsync: Tells which channel to Flush on Frame sync.
-- 
2.17.1
