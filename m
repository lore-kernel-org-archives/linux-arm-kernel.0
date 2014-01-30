From: b.brezillon.dev@gmail.com (Boris BREZILLON)
Date: Thu, 30 Jan 2014 14:46:02 +0100
Subject: =?UTF-8?q?=5BRFC=20PATCH=20pre-v3=2007/14=5D=20of=3A=20mtd=3A=20add=20documentation=20for=20the=20ONFI=20NAND=20timing=20mode=20property?=
In-Reply-To: <1391006064-28890-1-git-send-email-b.brezillon.dev@gmail.com>
References: <1391006064-28890-1-git-send-email-b.brezillon.dev@gmail.com>
Message-ID: <1391089562-8385-1-git-send-email-b.brezillon.dev@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add documentation for the ONFI NAND timing mode property.

Signed-off-by: Boris BREZILLON <b.brezillon.dev@gmail.com>
---
Changes since v2:
 - fix description of the nand-timing-mode property: the mode property is
   a mask containing all supported modes, each mode is encoded as a bit
   position

 Documentation/devicetree/bindings/mtd/nand.txt |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/mtd/nand.txt b/Documentation/devicetree/bindings/mtd/nand.txt
index 0c962296..60c7112 100644
--- a/Documentation/devicetree/bindings/mtd/nand.txt
+++ b/Documentation/devicetree/bindings/mtd/nand.txt
@@ -8,3 +8,10 @@
   E.g. : nand-ecc-level = <4 512>; /* 4 bits / 512 bytes */
 - nand-bus-width : 8 or 16 bus width if not present 8
 - nand-on-flash-bbt: boolean to enable on flash bbt option if not present false
+- onfi,nand-timing-mode: an integer encoding the supported ONFI timing modes of
+  the NAND chip. Each supported mode is represented as a bit position (i.e. :
+  mode 0 and 1 => (1 << 0) | (1 << 1) = 0x3).
+  This is only used when the chip does not support the ONFI standard.
+  The last bit set represent the closest mode fulfilling the NAND chip timings.
+  For a full description of the different timing modes see this document:
+  www.onfi.org/~/media/ONFI/specs/onfi_3_1_spec.pdf?
-- 
1.7.9.5
