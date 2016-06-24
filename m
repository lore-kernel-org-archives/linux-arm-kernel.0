From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Fri, 24 Jun 2016 13:00:04 +0800
Subject: [PATCH v7 1/2] mtd: nand: sunxi: update DT bindings
Message-ID: <20160624050005.31186-1-icenowy@aosc.xyz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Document the reset lines

Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
---
Changes in v7:
  - Rebased for nand/next branch.
  - Merged the two part of "Optional properties" of nand/next's document
    into one part.

 Documentation/devicetree/bindings/mtd/sunxi-nand.txt | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/mtd/sunxi-nand.txt b/Documentation/devicetree/bindings/mtd/sunxi-nand.txt
index 6fdf8f6..b040ed4 100644
--- a/Documentation/devicetree/bindings/mtd/sunxi-nand.txt
+++ b/Documentation/devicetree/bindings/mtd/sunxi-nand.txt
@@ -14,17 +14,17 @@ Required properties:
 Optional properties:
 - dmas : shall reference DMA channel associated to the NAND controller.
 - dma-names : shall be "rxtx".
-
-Optional children nodes:
-Children nodes represent the available nand chips.
-
-Optional properties:
+- reset : phandle + reset specifier pair
+- reset-names : shall be "ahb" if present
 - allwinner,rb : shall contain the native Ready/Busy ids.
  or
 - rb-gpios : shall contain the gpios used as R/B pins.
 - nand-ecc-mode : one of the supported ECC modes ("hw", "hw_syndrome", "soft",
   "soft_bch" or "none")
 
+Optional children nodes:
+Children nodes represent the available nand chips.
+
 see Documentation/devicetree/bindings/mtd/nand.txt for generic bindings.
 
 
-- 
2.9.0
