From: tthayer@opensource.altera.com (tthayer at opensource.altera.com)
Date: Tue, 9 Aug 2016 09:40:51 -0500
Subject: [PATCHv2 1/3] Documentation: dt: socfpga: Add Arria10 SD-MMC EDAC
 binding
In-Reply-To: <1470753653-23465-1-git-send-email-tthayer@opensource.altera.com>
References: <1470753653-23465-1-git-send-email-tthayer@opensource.altera.com>
Message-ID: <1470753653-23465-2-git-send-email-tthayer@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thor Thayer <tthayer@opensource.altera.com>

Add the device tree bindings needed to support the Altera SD-MMC
FIFO buffers EDAC on the Arria10 chip.

Signed-off-by: Thor Thayer <tthayer@opensource.altera.com>
Acked-by: Rob Herring <robh@kernel.org>
---
v2  No change
---
 .../bindings/arm/altera/socfpga-eccmgr.txt         |   19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/altera/socfpga-eccmgr.txt b/Documentation/devicetree/bindings/arm/altera/socfpga-eccmgr.txt
index ee66df0..4a1714f 100644
--- a/Documentation/devicetree/bindings/arm/altera/socfpga-eccmgr.txt
+++ b/Documentation/devicetree/bindings/arm/altera/socfpga-eccmgr.txt
@@ -122,6 +122,15 @@ Required Properties:
 - interrupts      : Should be single bit error interrupt, then double bit error
 	interrupt, in this order.
 
+SDMMC FIFO ECC
+Required Properties:
+- compatible      : Should be "altr,socfpga-sdmmc-ecc"
+- reg             : Address and size for ECC block registers.
+- altr,ecc-parent : phandle to parent SD/MMC node.
+- interrupts      : Should be single bit error interrupt, then double bit error
+	interrupt, in this order for port A, and then single bit error interrupt,
+	then double bit error interrupt in this order for port B.
+
 Example:
 
 	eccmgr: eccmgr at ffd06000 {
@@ -211,4 +220,14 @@ Example:
 			interrupts = <14 IRQ_TYPE_LEVEL_HIGH>,
 				     <46 IRQ_TYPE_LEVEL_HIGH>;
 		};
+
+		sdmmc-ecc at ff8c2c00 {
+			compatible = "altr,socfpga-sdmmc-ecc";
+			reg = <0xff8c2c00 0x400>;
+			altr,ecc-parent = <&mmc>;
+			interrupts = <15 IRQ_TYPE_LEVEL_HIGH>,
+				     <47 IRQ_TYPE_LEVEL_HIGH>,
+				     <16 IRQ_TYPE_LEVEL_HIGH>,
+				     <48 IRQ_TYPE_LEVEL_HIGH>;
+		};
 	};
-- 
1.7.9.5
