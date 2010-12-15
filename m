From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 15 Dec 2010 12:59:32 +0100
Subject: [PATCH] MTD: m25p80: add debugging trace in sst_write()
Message-ID: <1292414372-17085-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a DEBUG(MTD_DEBUG_LEVEL2, ..) trace at beginning of sst_write() function as
it is done in m25p80_write() function.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 drivers/mtd/devices/m25p80.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
index bf5a002..e6b5707 100644
--- a/drivers/mtd/devices/m25p80.c
+++ b/drivers/mtd/devices/m25p80.c
@@ -482,6 +482,10 @@ static int sst_write(struct mtd_info *mtd, loff_t to, size_t len,
 	size_t actual;
 	int cmd_sz, ret;
 
+	DEBUG(MTD_DEBUG_LEVEL2, "%s: %s %s 0x%08x, len %zd\n",
+			dev_name(&flash->spi->dev), __func__, "to",
+			(u32)to, len);
+
 	*retlen = 0;
 
 	/* sanity checks */
-- 
1.7.3
