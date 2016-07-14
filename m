From: tthayer@opensource.altera.com (tthayer at opensource.altera.com)
Date: Thu, 14 Jul 2016 11:06:41 -0500
Subject: [PATCH 03/10] Documentation: dt: socfpga: Add Arria10 USB EDAC binding
In-Reply-To: <1468512408-5156-1-git-send-email-tthayer@opensource.altera.com>
References: <1468512408-5156-1-git-send-email-tthayer@opensource.altera.com>
Message-ID: <1468512408-5156-4-git-send-email-tthayer@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thor Thayer <tthayer@opensource.altera.com>

Add the device tree bindings needed to support the Altera USB
FIFO buffer EDAC on the Arria10 chip.

Signed-off-by: Thor Thayer <tthayer@opensource.altera.com>
---
 .../bindings/arm/altera/socfpga-eccmgr.txt         |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/altera/socfpga-eccmgr.txt b/Documentation/devicetree/bindings/arm/altera/socfpga-eccmgr.txt
index ad8245b..3ffeb12 100644
--- a/Documentation/devicetree/bindings/arm/altera/socfpga-eccmgr.txt
+++ b/Documentation/devicetree/bindings/arm/altera/socfpga-eccmgr.txt
@@ -106,6 +106,14 @@ Required Properties:
 - interrupts      : Should be single bit error interrupt, then double bit error
 	interrupt, in this order.
 
+USB FIFO ECC
+Required Properties:
+- compatible      : Should be "altr,socfpga-usb-ecc"
+- reg             : Address and size for ECC block registers.
+- altr,ecc-parent : phandle to parent USB node.
+- interrupts      : Should be single bit error interrupt, then double bit error
+	interrupt, in this order.
+
 Example:
 
 	eccmgr: eccmgr at ffd06000 {
@@ -179,5 +187,12 @@ Example:
 			altr,ecc-parent = <&pdma>;
 			interrupts = <10 IRQ_TYPE_LEVEL_HIGH>,
 				     <42 IRQ_TYPE_LEVEL_HIGH>;
+
+		usb0-ecc at ff8c8800 {
+			compatible = "altr,socfpga-usb-ecc";
+			reg = <0xff8c8800 0x400>;
+			altr,ecc-parent = <&usb0>;
+			interrupts = <2 IRQ_TYPE_LEVEL_HIGH>,
+				     <34 IRQ_TYPE_LEVEL_HIGH>;
 		};
 	};
-- 
1.7.9.5
