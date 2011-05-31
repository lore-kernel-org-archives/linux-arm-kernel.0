From: computersforpeace@gmail.com (Brian Norris)
Date: Tue, 31 May 2011 16:31:27 -0700
Subject: [PATCH 8/8] mtd: nand: improve comment on
 NAND_BBT_DYNAMIC_STRUCT
In-Reply-To: <1306884687-1824-1-git-send-email-computersforpeace@gmail.com>
References: <1306884687-1824-1-git-send-email-computersforpeace@gmail.com>
Message-ID: <1306884687-1824-9-git-send-email-computersforpeace@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In an attempt to improve the documentation of the BBT code, I am expanding
the comments I left in commit:
    58373ff0afff4cc8ac40608872995f4d87eb72ec
    mtd: nand: more BB Detection refactoring and dynamic scan options

Signed-off-by: Brian Norris <computersforpeace@gmail.com>
---
 include/linux/mtd/bbm.h |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/include/linux/mtd/bbm.h b/include/linux/mtd/bbm.h
index 57d6a8d..c4eec22 100644
--- a/include/linux/mtd/bbm.h
+++ b/include/linux/mtd/bbm.h
@@ -113,7 +113,11 @@ struct nand_bbt_descr {
 /* Do not store flash based bad block table in OOB area; store it in-band */
 #define NAND_BBT_NO_OOB		0x00040000
 
-/* The nand_bbt_descr was created dynamicaly and must be freed */
+/*
+ * Flag set by nand_create_default_bbt_descr(), marking that the nand_bbt_descr
+ * was allocated dynamicaly and must be freed in nand_release(). Has no meaning
+ * in nand_chip.bbt_options.
+ */
 #define NAND_BBT_DYNAMICSTRUCT	0x80000000
 
 /* The maximum number of blocks to scan for a bbt */
-- 
1.7.0.4
