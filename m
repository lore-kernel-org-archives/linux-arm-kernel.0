From: tthayer@opensource.altera.com (tthayer at opensource.altera.com)
Date: Thu, 14 Jul 2016 11:06:39 -0500
Subject: [PATCH 01/10] Documentation: dt: socfpga: Add Arria10 NAND EDAC
 binding
In-Reply-To: <1468512408-5156-1-git-send-email-tthayer@opensource.altera.com>
References: <1468512408-5156-1-git-send-email-tthayer@opensource.altera.com>
Message-ID: <1468512408-5156-2-git-send-email-tthayer@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thor Thayer <tthayer@opensource.altera.com>

Add the device tree bindings needed to support the Altera NAND
FIFO buffers EDAC on the Arria10 chip.

Signed-off-by: Thor Thayer <tthayer@opensource.altera.com>
---
 .../bindings/arm/altera/socfpga-eccmgr.txt         |   32 ++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/altera/socfpga-eccmgr.txt b/Documentation/devicetree/bindings/arm/altera/socfpga-eccmgr.txt
index b545856..1bcbab2 100644
--- a/Documentation/devicetree/bindings/arm/altera/socfpga-eccmgr.txt
+++ b/Documentation/devicetree/bindings/arm/altera/socfpga-eccmgr.txt
@@ -90,6 +90,14 @@ Required Properties:
 - interrupts      : Should be single bit error interrupt, then double bit error
 	interrupt, in this order.
 
+NAND FIFO ECC
+Required Properties:
+- compatible      : Should be "altr,socfpga-nand-ecc"
+- reg             : Address and size for ECC block registers.
+- altr,ecc-parent : phandle to parent NAND node.
+- interrupts      : Should be single bit error interrupt, then double bit error
+	interrupt, in this order.
+
 Example:
 
 	eccmgr: eccmgr at ffd06000 {
@@ -132,4 +140,28 @@ Example:
 			interrupts = <5 IRQ_TYPE_LEVEL_HIGH>,
 				     <37 IRQ_TYPE_LEVEL_HIGH>;
 		};
+
+		nand-buf-ecc at ff8c2000 {
+			compatible = "altr,socfpga-nand-ecc";
+			reg = <0xff8c2000 0x400>;
+			altr,ecc-parent = <&nand>;
+			interrupts = <11 IRQ_TYPE_LEVEL_HIGH>,
+				     <43 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		nand-rd-ecc at ff8c2400 {
+			compatible = "altr,socfpga-nand-ecc";
+			reg = <0xff8c2400 0x400>;
+			altr,ecc-parent = <&nand>;
+			interrupts = <13 IRQ_TYPE_LEVEL_HIGH>,
+				     <45 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		nand-wr-ecc at ff8c2800 {
+			compatible = "altr,socfpga-nand-ecc";
+			reg = <0xff8c2800 0x400>;
+			altr,ecc-parent = <&nand>;
+			interrupts = <12 IRQ_TYPE_LEVEL_HIGH>,
+				     <44 IRQ_TYPE_LEVEL_HIGH>;
+		};
 	};
-- 
1.7.9.5
