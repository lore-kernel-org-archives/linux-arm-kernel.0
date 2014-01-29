From: b.brezillon.dev@gmail.com (Boris BREZILLON)
Date: Wed, 29 Jan 2014 15:34:13 +0100
Subject: [RFC PATCH v2 03/14] of: mtd: add documentation for nand-ecc-level
 property
In-Reply-To: <1391006064-28890-1-git-send-email-b.brezillon.dev@gmail.com>
References: <1391006064-28890-1-git-send-email-b.brezillon.dev@gmail.com>
Message-ID: <1391006064-28890-4-git-send-email-b.brezillon.dev@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

nand-ecc-level property statically defines NAND chip's ECC requirements.

Signed-off-by: Boris BREZILLON <b.brezillon.dev@gmail.com>
---
 Documentation/devicetree/bindings/mtd/nand.txt |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/mtd/nand.txt b/Documentation/devicetree/bindings/mtd/nand.txt
index 03855c8..0c962296 100644
--- a/Documentation/devicetree/bindings/mtd/nand.txt
+++ b/Documentation/devicetree/bindings/mtd/nand.txt
@@ -3,5 +3,8 @@
 - nand-ecc-mode : String, operation mode of the NAND ecc mode.
   Supported values are: "none", "soft", "hw", "hw_syndrome", "hw_oob_first",
   "soft_bch".
+- nand-ecc-level : Two cells property defining the ECC level requirements.
+  The first cell represent the strength and the second cell the ECC block size.
+  E.g. : nand-ecc-level = <4 512>; /* 4 bits / 512 bytes */
 - nand-bus-width : 8 or 16 bus width if not present 8
 - nand-on-flash-bbt: boolean to enable on flash bbt option if not present false
-- 
1.7.9.5
