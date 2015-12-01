From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Tue,  1 Dec 2015 12:03:00 +0100
Subject: [PATCH v2 03/25] cris: nand: make use of mtd_to_nand() where
 appropriate
In-Reply-To: <1448967802-25796-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1448967802-25796-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1448967802-25796-4-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mtd_to_nand() was recently introduced to avoid direct accesses to the
mtd->priv field. Update all CRIS specific implementations to use this
helper.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 arch/cris/arch-v32/drivers/mach-a3/nandflash.c | 2 +-
 arch/cris/arch-v32/drivers/mach-fs/nandflash.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/cris/arch-v32/drivers/mach-a3/nandflash.c b/arch/cris/arch-v32/drivers/mach-a3/nandflash.c
index 7fb5212..db953cf 100644
--- a/arch/cris/arch-v32/drivers/mach-a3/nandflash.c
+++ b/arch/cris/arch-v32/drivers/mach-a3/nandflash.c
@@ -52,7 +52,7 @@ static void crisv32_hwcontrol(struct mtd_info *mtd, int cmd,
 {
 	unsigned long flags;
 	reg_pio_rw_dout dout;
-	struct nand_chip *this = mtd->priv;
+	struct nand_chip *this = mtd_to_nand(mtd);
 
 	local_irq_save(flags);
 
diff --git a/arch/cris/arch-v32/drivers/mach-fs/nandflash.c b/arch/cris/arch-v32/drivers/mach-fs/nandflash.c
index e032384..22a6467 100644
--- a/arch/cris/arch-v32/drivers/mach-fs/nandflash.c
+++ b/arch/cris/arch-v32/drivers/mach-fs/nandflash.c
@@ -51,7 +51,7 @@ static void crisv32_hwcontrol(struct mtd_info *mtd, int cmd,
 {
 	unsigned long flags;
 	reg_gio_rw_pa_dout dout;
-	struct nand_chip *this = mtd->priv;
+	struct nand_chip *this = mtd_to_nand(mtd);
 
 	local_irq_save(flags);
 
-- 
2.1.4
