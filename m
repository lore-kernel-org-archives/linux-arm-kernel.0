From: baruch@tkos.co.il (Baruch Siach)
Date: Mon,  9 Aug 2010 14:38:14 +0300
Subject: [PATCH 2/2] mxc_nand: remove unused variables
In-Reply-To: <cover.1281353601.git.baruch@tkos.co.il>
References: <1281102791-8089-1-git-send-email-s.hauer@pengutronix.de>
	<cover.1281353601.git.baruch@tkos.co.il>
Message-ID: <d4b734ef5662b65466fbe959bd1fc993a7f08398.1281353601.git.baruch@tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 drivers/mtd/nand/mxc_nand.c |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/nand/mxc_nand.c b/drivers/mtd/nand/mxc_nand.c
index 3092240..dfa8311 100644
--- a/drivers/mtd/nand/mxc_nand.c
+++ b/drivers/mtd/nand/mxc_nand.c
@@ -1210,15 +1210,12 @@ static int mxcnd_suspend(struct platform_device *pdev, pm_message_t state)
 static int mxcnd_resume(struct platform_device *pdev)
 {
 	struct mtd_info *mtd = platform_get_drvdata(pdev);
-	struct nand_chip *nand_chip = mtd->priv;
-	struct mxc_nand_host *host = nand_chip->priv;
-	int ret = 0;
 
 	DEBUG(MTD_DEBUG_LEVEL0, "MXC_ND : NAND resume\n");
 
 	mtd->resume(mtd);
 
-	return ret;
+	return 0;
 }
 
 #else
-- 
1.7.1
