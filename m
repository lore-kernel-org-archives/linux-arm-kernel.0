From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Tue,  5 Nov 2013 09:55:22 -0300
Subject: [PATCH v3 15/28] mtd: nand: pxa3xx: Clear cmd buffer #3 (NDCB3) on
 command start
In-Reply-To: <1383656135-8627-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1383656135-8627-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1383656135-8627-16-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Command buffer #3 is not properly cleared and it keeps the last
set value. Fix this by clearing when a command is setup.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 drivers/mtd/nand/pxa3xx_nand.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/pxa3xx_nand.c b/drivers/mtd/nand/pxa3xx_nand.c
index 92abe7c..6544300 100644
--- a/drivers/mtd/nand/pxa3xx_nand.c
+++ b/drivers/mtd/nand/pxa3xx_nand.c
@@ -611,6 +611,7 @@ static int prepare_command_pool(struct pxa3xx_nand_info *info, int command,
 	info->use_ecc		= 0;
 	info->use_spare		= 1;
 	info->retcode		= ERR_NONE;
+	info->ndcb3		= 0;
 	if (info->cs != 0)
 		info->ndcb0 = NDCB0_CSEL;
 	else
@@ -632,7 +633,6 @@ static int prepare_command_pool(struct pxa3xx_nand_info *info, int command,
 	default:
 		info->ndcb1 = 0;
 		info->ndcb2 = 0;
-		info->ndcb3 = 0;
 		break;
 	}
 
-- 
1.8.1.5
