From: shaun.ren@linux.com (Shaun Ren)
Date: Mon, 15 Feb 2016 10:58:54 -0800
Subject: [PATCH v5 RESEND 8/8] Staging: rts5208: rtsx_transport.c: Fix
 comparisons to NULL
In-Reply-To: <1455562734-10863-1-git-send-email-shaun.ren@linux.com>
References: <1455250080-9897-1-git-send-email-shaun.ren@linux.com>
 <1455562734-10863-1-git-send-email-shaun.ren@linux.com>
Message-ID: <1455562734-10863-9-git-send-email-shaun.ren@linux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch changes all comparsions to NULL with !..., as reported by
checkpatch.pl.

Signed-off-by: Shaun Ren <shaun.ren@linux.com>
---
 drivers/staging/rts5208/rtsx_transport.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rts5208/rtsx_transport.c b/drivers/staging/rts5208/rtsx_transport.c
index c604576..f564a74 100644
--- a/drivers/staging/rts5208/rtsx_transport.c
+++ b/drivers/staging/rts5208/rtsx_transport.c
@@ -339,7 +339,7 @@ static int rtsx_transfer_sglist_adma_partial(struct rtsx_chip *chip, u8 card,
 	struct scatterlist *sg_ptr;
 	u32 val = TRIG_DMA;
 
-	if ((sg == NULL) || (num_sg <= 0) || !offset || !index)
+	if (!sg || (num_sg <= 0) || !offset || !index)
 		return -EIO;
 
 	if (dma_dir == DMA_TO_DEVICE)
@@ -503,7 +503,7 @@ static int rtsx_transfer_sglist_adma(struct rtsx_chip *chip, u8 card,
 	long timeleft;
 	struct scatterlist *sg_ptr;
 
-	if ((sg == NULL) || (num_sg <= 0))
+	if (!sg || (num_sg <= 0))
 		return -EIO;
 
 	if (dma_dir == DMA_TO_DEVICE)
@@ -650,7 +650,7 @@ static int rtsx_transfer_buf(struct rtsx_chip *chip, u8 card, void *buf,
 	u32 val = 1 << 31;
 	long timeleft;
 
-	if ((buf == NULL) || (len <= 0))
+	if (!buf || (len <= 0))
 		return -EIO;
 
 	if (dma_dir == DMA_TO_DEVICE)
-- 
2.7.1
