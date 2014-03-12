From: b.brezillon.dev@gmail.com (Boris BREZILLON)
Date: Wed, 12 Mar 2014 19:07:39 +0100
Subject: [PATCH v3 4/9] of: mtd: add documentation for the ONFI NAND timing
 mode property
In-Reply-To: <1394647664-8258-1-git-send-email-b.brezillon.dev@gmail.com>
References: <1394647664-8258-1-git-send-email-b.brezillon.dev@gmail.com>
Message-ID: <1394647664-8258-5-git-send-email-b.brezillon.dev@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add documentation for the ONFI NAND timing mode property.

Signed-off-by: Boris BREZILLON <b.brezillon.dev@gmail.com>
---
 Documentation/devicetree/bindings/mtd/nand.txt |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/mtd/nand.txt b/Documentation/devicetree/bindings/mtd/nand.txt
index b53f92e..2046027 100644
--- a/Documentation/devicetree/bindings/mtd/nand.txt
+++ b/Documentation/devicetree/bindings/mtd/nand.txt
@@ -19,3 +19,11 @@ errors per {size} bytes".
 The interpretation of these parameters is implementation-defined, so not all
 implementations must support all possible combinations. However, implementations
 are encouraged to further specify the value(s) they support.
+
+- onfi,nand-timing-mode: an integer encoding the supported ONFI timing modes of
+  the NAND chip. Each supported mode is represented as a bit position (i.e. :
+  mode 0 and 1 => (1 << 0) | (1 << 1) = 0x3).
+  This is only used when the chip does not support the ONFI standard.
+  The last bit set represent the closest mode fulfilling the NAND chip timings.
+  For a full description of the different timing modes see this document:
+  www.onfi.org/~/media/ONFI/specs/onfi_3_1_spec.pdf
-- 
1.7.9.5
