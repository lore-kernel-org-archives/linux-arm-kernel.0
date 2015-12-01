From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Tue,  1 Dec 2015 12:02:59 +0100
Subject: [PATCH v2 02/25] blackfin: nand: make use of mtd_to_nand() where
 appropriate
In-Reply-To: <1448967802-25796-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1448967802-25796-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1448967802-25796-3-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mtd_to_nand() was recently introduced to avoid direct accesses to the
mtd->priv field. Update all blackfin specific implementations to use
this helper.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 arch/blackfin/mach-bf537/boards/stamp.c   | 2 +-
 arch/blackfin/mach-bf561/boards/acvilon.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/blackfin/mach-bf537/boards/stamp.c b/arch/blackfin/mach-bf537/boards/stamp.c
index 88a19fc..c181543 100644
--- a/arch/blackfin/mach-bf537/boards/stamp.c
+++ b/arch/blackfin/mach-bf537/boards/stamp.c
@@ -404,7 +404,7 @@ static struct mtd_partition bfin_plat_nand_partitions[] = {
 #define BFIN_NAND_PLAT_ALE 1
 static void bfin_plat_nand_cmd_ctrl(struct mtd_info *mtd, int cmd, unsigned int ctrl)
 {
-	struct nand_chip *this = mtd->priv;
+	struct nand_chip *this = mtd_to_nand(mtd);
 
 	if (cmd == NAND_CMD_NONE)
 		return;
diff --git a/arch/blackfin/mach-bf561/boards/acvilon.c b/arch/blackfin/mach-bf561/boards/acvilon.c
index 6ab9515..37f8f25 100644
--- a/arch/blackfin/mach-bf561/boards/acvilon.c
+++ b/arch/blackfin/mach-bf561/boards/acvilon.c
@@ -267,7 +267,7 @@ static struct mtd_partition bfin_plat_nand_partitions[] = {
 static void bfin_plat_nand_cmd_ctrl(struct mtd_info *mtd, int cmd,
 				    unsigned int ctrl)
 {
-	struct nand_chip *this = mtd->priv;
+	struct nand_chip *this = mtd_to_nand(mtd);
 
 	if (cmd == NAND_CMD_NONE)
 		return;
-- 
2.1.4
