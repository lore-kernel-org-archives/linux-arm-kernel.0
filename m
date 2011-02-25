From: r64343@freescale.com (Jason Liu)
Date: Fri, 25 Feb 2011 13:06:18 +0800
Subject: [PATCH] mtd: nand: fix one typo in the comments
Message-ID: <1298610378-3105-1-git-send-email-r64343@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In the function nand_do_write_oob, the comments
has one typo, this patch fix it.

- /* Do not allow reads past end of device */
+ /* Do not allow write past end of device */
if (unlikely(to >= mtd->size ||
	     ops->ooboffs + ops->ooblen >
		((mtd->size >> chip->page_shift) -
		 (to >> chip->page_shift)) * len)) {
	DEBUG(MTD_DEBUG_LEVEL0, "%s: Attempt write beyond "
			"end of device\n", __func__);
	return -EINVAL;
}

Signed-off-by: Jason Liu <r64343@freescale.com>
---
 drivers/mtd/nand/nand_base.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mtd/nand/nand_base.c b/drivers/mtd/nand/nand_base.c
index a9c6ce7..da76040 100644
--- a/drivers/mtd/nand/nand_base.c
+++ b/drivers/mtd/nand/nand_base.c
@@ -2377,7 +2377,7 @@ static int nand_do_write_oob(struct mtd_info *mtd, loff_t to,
 		return -EINVAL;
 	}
 
-	/* Do not allow reads past end of device */
+	/* Do not allow write past end of device */
 	if (unlikely(to >= mtd->size ||
 		     ops->ooboffs + ops->ooblen >
 			((mtd->size >> chip->page_shift) -
-- 
1.7.0.4
