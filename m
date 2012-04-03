From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue,  3 Apr 2012 09:32:54 +0200
Subject: [PATCH v2 10/13] ARM: at91/NAND DT bindings: add comments
In-Reply-To: <cover.1333437885.git.nicolas.ferre@atmel.com>
References: <cover.1333437885.git.nicolas.ferre@atmel.com>
Message-ID: <f7a94438cf1e21b2eec044419d9dca214999a9a6.1333437885.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add comments to NAND "gpios" property to make it clearer.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
---
 .../devicetree/bindings/mtd/atmel-nand.txt         |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/mtd/atmel-nand.txt b/Documentation/devicetree/bindings/mtd/atmel-nand.txt
index 5903ecf..a200695 100644
--- a/Documentation/devicetree/bindings/mtd/atmel-nand.txt
+++ b/Documentation/devicetree/bindings/mtd/atmel-nand.txt
@@ -27,13 +27,13 @@ nand0: nand at 40000000,0 {
 	reg = <0x40000000 0x10000000
 	       0xffffe800 0x200
 	      >;
-	atmel,nand-addr-offset = <21>;
-	atmel,nand-cmd-offset = <22>;
+	atmel,nand-addr-offset = <21>;	/* ale */
+	atmel,nand-cmd-offset = <22>;	/* cle */
 	nand-on-flash-bbt;
 	nand-ecc-mode = "soft";
-	gpios = <&pioC 13 0
-		 &pioC 14 0
-		 0
+	gpios = <&pioC 13 0	/* rdy */
+		 &pioC 14 0 	/* nce */
+		 0		/* cd */
 		>;
 	partition at 0 {
 		...
-- 
1.7.9.4
