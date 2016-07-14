From: tthayer@opensource.altera.com (tthayer at opensource.altera.com)
Date: Thu, 14 Jul 2016 11:06:40 -0500
Subject: [PATCH 02/10] Documentation: dt: socfpga: Add Arria10 DMA EDAC binding
In-Reply-To: <1468512408-5156-1-git-send-email-tthayer@opensource.altera.com>
References: <1468512408-5156-1-git-send-email-tthayer@opensource.altera.com>
Message-ID: <1468512408-5156-3-git-send-email-tthayer@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thor Thayer <tthayer@opensource.altera.com>

Add the device tree bindings needed to support the Altera DMA
FIFO buffer EDAC on the Arria10 chip.

Signed-off-by: Thor Thayer <tthayer@opensource.altera.com>
---
 .../bindings/arm/altera/socfpga-eccmgr.txt         |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/altera/socfpga-eccmgr.txt b/Documentation/devicetree/bindings/arm/altera/socfpga-eccmgr.txt
index 1bcbab2..ad8245b 100644
--- a/Documentation/devicetree/bindings/arm/altera/socfpga-eccmgr.txt
+++ b/Documentation/devicetree/bindings/arm/altera/socfpga-eccmgr.txt
@@ -98,6 +98,14 @@ Required Properties:
 - interrupts      : Should be single bit error interrupt, then double bit error
 	interrupt, in this order.
 
+DMA FIFO ECC
+Required Properties:
+- compatible      : Should be "altr,socfpga-dma-ecc"
+- reg             : Address and size for ECC block registers.
+- altr,ecc-parent : phandle to parent DMA node.
+- interrupts      : Should be single bit error interrupt, then double bit error
+	interrupt, in this order.
+
 Example:
 
 	eccmgr: eccmgr at ffd06000 {
@@ -164,4 +172,12 @@ Example:
 			interrupts = <12 IRQ_TYPE_LEVEL_HIGH>,
 				     <44 IRQ_TYPE_LEVEL_HIGH>;
 		};
+
+		dma-ecc at ff8c8000 {
+			compatible = "altr,socfpga-dma-ecc";
+			reg = <0xff8c8000 0x400>;
+			altr,ecc-parent = <&pdma>;
+			interrupts = <10 IRQ_TYPE_LEVEL_HIGH>,
+				     <42 IRQ_TYPE_LEVEL_HIGH>;
+		};
 	};
-- 
1.7.9.5
