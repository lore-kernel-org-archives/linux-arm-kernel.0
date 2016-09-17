From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sat, 17 Sep 2016 17:26:56 +0200
Subject: [PATCH 16/24] ste_dma40: Rename a jump label in d40_prep_desc()
In-Reply-To: <92810066-69b6-94e7-dcec-a28594b1328f@users.sourceforge.net>
References: <566ABCD9.1060404@users.sourceforge.net>
 <92810066-69b6-94e7-dcec-a28594b1328f@users.sourceforge.net>
Message-ID: <4879ed44-9a6a-856d-a108-7d8f1934e2a0@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 17 Sep 2016 15:51:37 +0200

Adjust jump labels according to the current Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/dma/ste_dma40.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
index 6725b66..7f38496 100644
--- a/drivers/dma/ste_dma40.c
+++ b/drivers/dma/ste_dma40.c
@@ -2208,13 +2208,13 @@ d40_prep_desc(struct d40_chan *chan, struct scatterlist *sg,
 					cfg->dst_info.data_width);
 	if (desc->lli_len < 0) {
 		chan_err(chan, "Unaligned size\n");
-		goto err;
+		goto free_desc;
 	}
 
 	ret = d40_pool_lli_alloc(chan, desc, desc->lli_len);
 	if (ret < 0) {
 		chan_err(chan, "Could not allocate lli\n");
-		goto err;
+		goto free_desc;
 	}
 
 	desc->lli_current = 0;
@@ -2224,8 +2224,7 @@ d40_prep_desc(struct d40_chan *chan, struct scatterlist *sg,
 	dma_async_tx_descriptor_init(&desc->txd, &chan->chan);
 
 	return desc;
-
-err:
+ free_desc:
 	d40_desc_free(chan, desc);
 	return NULL;
 }
-- 
2.10.0
