From: shaun.ren@linux.com (Shaun Ren)
Date: Mon,  8 Feb 2016 17:31:24 -0800
Subject: [PATCH v2 8/9] Staging: rts5208: rtsx_transport.c: Fix comparisons to
 NULL
In-Reply-To: <1454981485-15686-1-git-send-email-shaun.ren@linux.com>
References: <1453775248-15965-1-git-send-email-shaun.ren@linux.com>
 <1454981485-15686-1-git-send-email-shaun.ren@linux.com>
Message-ID: <1454981485-15686-9-git-send-email-shaun.ren@linux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch changes all comparsions to NULL with !..., as reported by
checkpatch.pl.

Signed-off-by: Shaun Ren <shaun.ren@linux.com>
---
 drivers/staging/rts5208/rtsx_transport.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rts5208/rtsx_transport.c b/drivers/staging/rts5208/rtsx_transport.c
index fa062f6..c0fd8c5 100644
--- a/drivers/staging/rts5208/rtsx_transport.c
+++ b/drivers/staging/rts5208/rtsx_transport.c
@@ -343,7 +343,7 @@ static int rtsx_transfer_sglist_adma_partial(struct rtsx_chip *chip, u8 card,
 	struct scatterlist *sg_ptr;
 	u32 val = TRIG_DMA;
 
-	if ((sg == NULL) || (num_sg <= 0) || !offset || !index)
+	if (!sg || (num_sg <= 0) || !offset || !index)
 		return -EIO;
 
 	if (dma_dir == DMA_TO_DEVICE)
@@ -506,7 +506,7 @@ static int rtsx_transfer_sglist_adma(struct rtsx_chip *chip, u8 card,
 	long timeleft;
 	struct scatterlist *sg_ptr;
 
-	if ((sg == NULL) || (num_sg <= 0))
+	if (!sg || (num_sg <= 0))
 		return -EIO;
 
 	if (dma_dir == DMA_TO_DEVICE)
@@ -653,7 +653,7 @@ static int rtsx_transfer_buf(struct rtsx_chip *chip, u8 card, void *buf,
 	u32 val = 1 << 31;
 	long timeleft;
 
-	if ((buf == NULL) || (len <= 0))
+	if (!buf || (len <= 0))
 		return -EIO;
 
 	if (dma_dir == DMA_TO_DEVICE)
-- 
2.7.0
