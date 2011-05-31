From: computersforpeace@gmail.com (Brian Norris)
Date: Tue, 31 May 2011 16:31:26 -0700
Subject: [PATCH 7/8] mtd: nand: renumber the reorganized flags in nand.h
	/ bbm.h
In-Reply-To: <1306884687-1824-1-git-send-email-computersforpeace@gmail.com>
References: <1306884687-1824-1-git-send-email-computersforpeace@gmail.com>
Message-ID: <1306884687-1824-8-git-send-email-computersforpeace@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After several steps of rearrangement and consolidation, it is probably
worth re-sequencing the numbers on some of our affected flags in nand.h
and bbm.h.

Signed-off-by: Brian Norris <computersforpeace@gmail.com>
---
 include/linux/mtd/bbm.h  |   23 ++++++++++++-----------
 include/linux/mtd/nand.h |    6 +++---
 2 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/include/linux/mtd/bbm.h b/include/linux/mtd/bbm.h
index 0fa030a..57d6a8d 100644
--- a/include/linux/mtd/bbm.h
+++ b/include/linux/mtd/bbm.h
@@ -92,28 +92,29 @@ struct nand_bbt_descr {
  * layout or if this information is already purged. Must be used in conjunction
  * with NAND_BBT_CREATE.
  */
-#define NAND_BBT_CREATE_EMPTY	0x01000000
+#define NAND_BBT_CREATE_EMPTY	0x00000400
 /* Search good / bad pattern through all pages of a block */
-#define NAND_BBT_SCANALLPAGES	0x00000400
+#define NAND_BBT_SCANALLPAGES	0x00000800
 /* Scan block empty during good / bad block scan */
-#define NAND_BBT_SCANEMPTY	0x00000800
+#define NAND_BBT_SCANEMPTY	0x00001000
 /* Write bbt if neccecary */
-#define NAND_BBT_WRITE		0x00001000
+#define NAND_BBT_WRITE		0x00002000
 /* Read and write back block contents when writing bbt */
-#define NAND_BBT_SAVECONTENT	0x00002000
+#define NAND_BBT_SAVECONTENT	0x00004000
 /* Search good / bad pattern on the first and the second page */
-#define NAND_BBT_SCAN2NDPAGE	0x00004000
+#define NAND_BBT_SCAN2NDPAGE	0x00008000
 /* Search good / bad pattern on the last page of the eraseblock */
-#define NAND_BBT_SCANLASTPAGE	0x00008000
-/* The nand_bbt_descr was created dynamicaly and must be freed */
-#define NAND_BBT_DYNAMICSTRUCT 0x00200000
+#define NAND_BBT_SCANLASTPAGE	0x00010000
 /*
  * Use a flash based bad block table. By default, OOB identifier is saved in
  * OOB area. This option is passed to the default bad block table function.
  */
-#define NAND_BBT_USE_FLASH	0x00040000
+#define NAND_BBT_USE_FLASH	0x00020000
 /* Do not store flash based bad block table in OOB area; store it in-band */
-#define NAND_BBT_NO_OOB		0x00080000
+#define NAND_BBT_NO_OOB		0x00040000
+
+/* The nand_bbt_descr was created dynamicaly and must be freed */
+#define NAND_BBT_DYNAMICSTRUCT	0x80000000
 
 /* The maximum number of blocks to scan for a bbt */
 #define NAND_BBT_SCAN_MAXBLOCKS	4
diff --git a/include/linux/mtd/nand.h b/include/linux/mtd/nand.h
index 4e9e88b..585d49b 100644
--- a/include/linux/mtd/nand.h
+++ b/include/linux/mtd/nand.h
@@ -220,14 +220,14 @@ typedef enum {
 
 /* Non chip related options */
 /* This option skips the bbt scan during initialization. */
-#define NAND_SKIP_BBTSCAN	0x00020000
+#define NAND_SKIP_BBTSCAN	0x00010000
 /*
  * This option is defined if the board driver allocates its own buffers
  * (e.g. because it needs them DMA-coherent).
  */
-#define NAND_OWN_BUFFERS	0x00040000
+#define NAND_OWN_BUFFERS	0x00020000
 /* Chip may not exist, so silence any errors in scan */
-#define NAND_SCAN_SILENT_NODEV	0x00080000
+#define NAND_SCAN_SILENT_NODEV	0x00040000
 
 /* Options set by nand scan */
 /* Nand scan has allocated controller struct */
-- 
1.7.0.4
