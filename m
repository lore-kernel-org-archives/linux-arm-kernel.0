From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Thu, 12 Feb 2015 15:53:27 +0100
Subject: [PATCH v2 01/10] mtd: pxa3xx_nand: initialiaze pxa3xx_flash_ids to 0
In-Reply-To: <1423752816-26219-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1423752816-26219-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <1423752816-26219-2-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

pxa3xx_flash_ids wasn't initialized to 0, which in certain cases could
end up containing corrupted values in its members. Fix this to avoid
possible issues.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
---
 drivers/mtd/nand/pxa3xx_nand.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mtd/nand/pxa3xx_nand.c b/drivers/mtd/nand/pxa3xx_nand.c
index 96b0b1d27df1..d00ac392d1c4 100644
--- a/drivers/mtd/nand/pxa3xx_nand.c
+++ b/drivers/mtd/nand/pxa3xx_nand.c
@@ -1472,6 +1472,8 @@ static int pxa3xx_nand_scan(struct mtd_info *mtd)
 		return ret;
 	}
 
+	memset(pxa3xx_flash_ids, 0, sizeof(pxa3xx_flash_ids));
+
 	pxa3xx_flash_ids[0].name = f->name;
 	pxa3xx_flash_ids[0].dev_id = (f->chip_id >> 8) & 0xffff;
 	pxa3xx_flash_ids[0].pagesize = f->page_size;
-- 
2.3.0
