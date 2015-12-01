From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Tue,  1 Dec 2015 12:03:02 +0100
Subject: [PATCH v2 05/25] sh: nand: make use of mtd_to_nand() where appropriate
In-Reply-To: <1448967802-25796-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1448967802-25796-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1448967802-25796-6-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mtd_to_nand() was recently introduced to avoid direct accesses to the
mtd->priv field. Update all SH specific implementations to use this
helper.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 arch/sh/boards/mach-migor/setup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sh/boards/mach-migor/setup.c b/arch/sh/boards/mach-migor/setup.c
index 29b7c0d..8673f91 100644
--- a/arch/sh/boards/mach-migor/setup.c
+++ b/arch/sh/boards/mach-migor/setup.c
@@ -167,7 +167,7 @@ static struct mtd_partition migor_nand_flash_partitions[] = {
 static void migor_nand_flash_cmd_ctl(struct mtd_info *mtd, int cmd,
 				     unsigned int ctrl)
 {
-	struct nand_chip *chip = mtd->priv;
+	struct nand_chip *chip = mtd_to_nand(mtd);
 
 	if (cmd == NAND_CMD_NONE)
 		return;
-- 
2.1.4
