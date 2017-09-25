From: miquel.raynal@free-electrons.com (Miquel Raynal)
Date: Mon, 25 Sep 2017 16:53:50 +0200
Subject: [PATCH 1/3] Documentation: devicetree: add pxa3xx compatible and
 syscon property
In-Reply-To: <20170925145352.13145-1-miquel.raynal@free-electrons.com>
References: <20170925145352.13145-1-miquel.raynal@free-electrons.com>
Message-ID: <20170925145352.13145-2-miquel.raynal@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Document the new pxa3xx_nand driver compatible string for A7k/A8k SoCs
that need to access system controller registers in order to enable the
NAND controller through the use of a phandle pointed to by the
'marvell,system-controller' property.

Signed-off-by: Miquel Raynal <miquel.raynal@free-electrons.com>
---
 Documentation/devicetree/bindings/mtd/pxa3xx-nand.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/mtd/pxa3xx-nand.txt b/Documentation/devicetree/bindings/mtd/pxa3xx-nand.txt
index d9b655f11048..d4ee4da58463 100644
--- a/Documentation/devicetree/bindings/mtd/pxa3xx-nand.txt
+++ b/Documentation/devicetree/bindings/mtd/pxa3xx-nand.txt
@@ -5,9 +5,13 @@ Required properties:
  - compatible:		Should be set to one of the following:
 			marvell,pxa3xx-nand
 			marvell,armada370-nand
+			marvell,armada-8k-nand
  - reg: 		The register base for the controller
  - interrupts:		The interrupt to map
  - #address-cells:	Set to <1> if the node includes partitions
+ - marvell,system-controller: Set to retrieve the syscon node that handles
+			NAND controller related registers (only required
+			with marvell,armada-8k-nand compatible).
 
 Optional properties:
 
-- 
2.11.0
