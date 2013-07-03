From: josh.wu@atmel.com (Josh Wu)
Date: Wed, 3 Jul 2013 17:56:19 +0800
Subject: [PATCH] mtd: atmel_nand: fix pmecc selction for ecc requirement typo
Message-ID: <1372845379-5958-1-git-send-email-josh.wu@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Atmel PMECC support 2, 4, 8, 12, 24 bit error correction.
So if the ecc requirement in ONFI is <= 2, 4, 8, 12, 24.
We will use 2, 4, 8, 12, 24.

This patch fix the typo. Use '<=' replace '<'.

Reported-by: Scott Wood <scottwood@freescale.com>
Signed-off-by: Josh Wu <josh.wu@atmel.com>
---
 drivers/mtd/nand/atmel_nand.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/nand/atmel_nand.c b/drivers/mtd/nand/atmel_nand.c
index 7e50ed8..2a42aa8 100644
--- a/drivers/mtd/nand/atmel_nand.c
+++ b/drivers/mtd/nand/atmel_nand.c
@@ -960,11 +960,11 @@ static int pmecc_choose_ecc(struct atmel_nand_host *host,
 			host->pmecc_corr_cap = 2;
 		else if (*cap <= 4)
 			host->pmecc_corr_cap = 4;
-		else if (*cap < 8)
+		else if (*cap <= 8)
 			host->pmecc_corr_cap = 8;
-		else if (*cap < 12)
+		else if (*cap <= 12)
 			host->pmecc_corr_cap = 12;
-		else if (*cap < 24)
+		else if (*cap <= 24)
 			host->pmecc_corr_cap = 24;
 		else
 			return -EINVAL;
-- 
1.7.9.5
