From: snawrocki@kernel.org (snawrocki at kernel.org)
Date: Wed, 16 Aug 2017 22:31:01 +0200
Subject: [PATCH] ARM: S3C24XX: Fix NAND ECC mode for mini2440 board
Message-ID: <1502915461-8625-1-git-send-email-snawrocki@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sylwester Nawrocki <snawrocki@kernel.org>

After commit e9f66ae23c "mtd: s3c2410: make ecc mode configurable
via platform data" booting of the mini2440 board is broken, since
for this board we have CONFIG_MTD_NAND_S3C2410_HWECC set. The console
gets flooded with errors reported by the mtd subsystem.
This patch changes ecc_mode to NAND_ECC_HW which restores proper
operation of the NAND flash memory.

Cc: Sergio Prado <sergio.prado@e-labworks.com>
Fixes: e9f66ae23c "mtd: s3c2410: make ecc mode configurable via platform data"
Signed-off-by: Sylwester Nawrocki <snawrocki@kernel.org>
---
 arch/arm/mach-s3c24xx/mach-mini2440.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-s3c24xx/mach-mini2440.c b/arch/arm/mach-s3c24xx/mach-mini2440.c
index 98bff4b..3e75efd 100644
--- a/arch/arm/mach-s3c24xx/mach-mini2440.c
+++ b/arch/arm/mach-s3c24xx/mach-mini2440.c
@@ -289,7 +289,7 @@
 	.nr_sets	= ARRAY_SIZE(mini2440_nand_sets),
 	.sets		= mini2440_nand_sets,
 	.ignore_unset_ecc = 1,
-	.ecc_mode       = NAND_ECC_SOFT,
+	.ecc_mode       = NAND_ECC_HW,
 };
 
 /* DM9000AEP 10/100 ethernet controller */
-- 
1.9.1
