From: tthayer@opensource.altera.com (tthayer at opensource.altera.com)
Date: Thu, 14 Jul 2016 11:06:42 -0500
Subject: [PATCH 04/10] Documentation: dt: socfpga: Add Arria10 QSPI EDAC
 binding
In-Reply-To: <1468512408-5156-1-git-send-email-tthayer@opensource.altera.com>
References: <1468512408-5156-1-git-send-email-tthayer@opensource.altera.com>
Message-ID: <1468512408-5156-5-git-send-email-tthayer@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thor Thayer <tthayer@opensource.altera.com>

Add the device tree bindings needed to support the Altera QSPI
FIFO buffer EDAC on the Arria10 chip.

Signed-off-by: Thor Thayer <tthayer@opensource.altera.com>
---
 .../bindings/arm/altera/socfpga-eccmgr.txt         |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/altera/socfpga-eccmgr.txt b/Documentation/devicetree/bindings/arm/altera/socfpga-eccmgr.txt
index 3ffeb12..ee66df0 100644
--- a/Documentation/devicetree/bindings/arm/altera/socfpga-eccmgr.txt
+++ b/Documentation/devicetree/bindings/arm/altera/socfpga-eccmgr.txt
@@ -114,6 +114,14 @@ Required Properties:
 - interrupts      : Should be single bit error interrupt, then double bit error
 	interrupt, in this order.
 
+QSPI FIFO ECC
+Required Properties:
+- compatible      : Should be "altr,socfpga-qspi-ecc"
+- reg             : Address and size for ECC block registers.
+- altr,ecc-parent : phandle to parent QSPI node.
+- interrupts      : Should be single bit error interrupt, then double bit error
+	interrupt, in this order.
+
 Example:
 
 	eccmgr: eccmgr at ffd06000 {
@@ -195,4 +203,12 @@ Example:
 			interrupts = <2 IRQ_TYPE_LEVEL_HIGH>,
 				     <34 IRQ_TYPE_LEVEL_HIGH>;
 		};
+
+		qspi-ecc at ff8c8400 {
+			compatible = "altr,socfpga-qspi-ecc";
+			reg = <0xff8c8400 0x400>;
+			altr,ecc-parent = <&qspi>;
+			interrupts = <14 IRQ_TYPE_LEVEL_HIGH>,
+				     <46 IRQ_TYPE_LEVEL_HIGH>;
+		};
 	};
-- 
1.7.9.5
