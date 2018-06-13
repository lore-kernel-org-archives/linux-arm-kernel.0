From: radhey.shyam.pandey@xilinx.com (Radhey Shyam Pandey)
Date: Wed, 13 Jun 2018 13:04:47 +0530
Subject: [PATCH 1/2] dt-bindings: dmaengine: xilinx_dma: Add VDMA vertical
 flip property
In-Reply-To: <1528875288-9140-1-git-send-email-radhey.shyam.pandey@xilinx.com>
References: <1528875288-9140-1-git-send-email-radhey.shyam.pandey@xilinx.com>
Message-ID: <1528875288-9140-2-git-send-email-radhey.shyam.pandey@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The AXI VDMA core supports Vertical flip in S2MM path when Enable
Vertical Flip (Advanced tab) is selected. To allow vertical flip
programming define an optional 'xlnx,enable-vert-flip' channel
child node property.

Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---
 .../devicetree/bindings/dma/xilinx/xilinx_dma.txt  |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt b/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
index a2b8bfa..174af2c 100644
--- a/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
+++ b/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
@@ -66,6 +66,8 @@ Optional child node properties:
 Optional child node properties for VDMA:
 - xlnx,genlock-mode: Tells Genlock synchronization is
 	enabled/disabled in hardware.
+- xlnx,enable-vert-flip: Tells vertical flip is
+	enabled/disabled in hardware(S2MM path).
 Optional child node properties for AXI DMA:
 -dma-channels: Number of dma channels in child node.
 
-- 
1.7.1
