From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 20 Mar 2014 11:11:44 +0000
Subject: [PATCH 2/5] mtd: st_spi_fsm: Avoid duplicating MTD core code
In-Reply-To: <1395313907-25318-1-git-send-email-lee.jones@linaro.org>
References: <1395313907-25318-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1395313907-25318-3-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Reported-by: Brian Norris <computersforpeace@gmail.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mtd/devices/st_spi_fsm.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/mtd/devices/st_spi_fsm.c b/drivers/mtd/devices/st_spi_fsm.c
index dcc1dc3..27f9ec9 100644
--- a/drivers/mtd/devices/st_spi_fsm.c
+++ b/drivers/mtd/devices/st_spi_fsm.c
@@ -1728,14 +1728,6 @@ static int stfsm_mtd_write(struct mtd_info *mtd, loff_t to, size_t len,
 
 	dev_dbg(fsm->dev, "%s to 0x%08x, len %zd\n", __func__, (u32)to, len);
 
-	*retlen = 0;
-
-	if (!len)
-		return 0;
-
-	if (to + len > mtd->size)
-		return -EINVAL;
-
 	/* Offset within page */
 	page_offs = to % FLASH_PAGESIZE;
 
-- 
1.8.3.2
