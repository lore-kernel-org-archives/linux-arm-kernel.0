From: andrea.merello@gmail.com (Andrea Merello)
Date: Thu, 21 Jun 2018 13:58:19 +0200
Subject: [PATCH v2 2/5] dt-bindings: xilinx_dma: add optional xlnx,
 sg-length-width property
In-Reply-To: <20180621115822.20058-1-andrea.merello@gmail.com>
References: <20180621115822.20058-1-andrea.merello@gmail.com>
Message-ID: <20180621115822.20058-2-andrea.merello@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The width of the "length register" cannot be autodetected, and it is now
specified with a DT property. Add DOC for it.

Cc: Rob Herring <robh+dt@kernel.org>
Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
---
Changes in v2:
	- change property name
	- property is now optional
	- cc DT maintainer
---
 Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt b/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
index a2b8bfaec43c..c894abe28baa 100644
--- a/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
+++ b/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
@@ -41,6 +41,7 @@ Optional properties:
 - xlnx,include-sg: Tells configured for Scatter-mode in
 	the hardware.
 Optional properties for AXI DMA:
+- xlnx,sg-length-width: Should be the width of the length register as configured in h/w.
 - xlnx,mcdma: Tells whether configured for multi-channel mode in the hardware.
 Optional properties for VDMA:
 - xlnx,flush-fsync: Tells which channel to Flush on Frame sync.
-- 
2.17.1
