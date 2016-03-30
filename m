From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 30 Mar 2016 19:35:16 +0200
Subject: [PATCH 1/5] dmaengine: mv_xor: make the code 64 bits compliant
In-Reply-To: <1459359320-12638-1-git-send-email-gregory.clement@free-electrons.com>
References: <1459359320-12638-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1459359320-12638-2-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix two warnings which appear when building for 64 bits target.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 drivers/dma/mv_xor.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/mv_xor.c b/drivers/dma/mv_xor.c
index 3922a5d56806..a6ec82776cbc 100644
--- a/drivers/dma/mv_xor.c
+++ b/drivers/dma/mv_xor.c
@@ -477,7 +477,7 @@ mv_xor_prep_dma_xor(struct dma_chan *chan, dma_addr_t dest, dma_addr_t *src,
 	BUG_ON(len > MV_XOR_MAX_BYTE_COUNT);
 
 	dev_dbg(mv_chan_to_devp(mv_chan),
-		"%s src_cnt: %d len: %u dest %pad flags: %ld\n",
+		"%s src_cnt: %d len: %zu dest %pad flags: %ld\n",
 		__func__, src_cnt, len, &dest, flags);
 
 	sw_desc = mv_chan_alloc_slot(mv_chan);
@@ -1220,7 +1220,7 @@ static int mv_xor_probe(struct platform_device *pdev)
 			struct mv_xor_chan *chan;
 			dma_cap_mask_t cap_mask;
 			int irq;
-			op_in_desc = (int)of_id->data;
+			op_in_desc = (uintptr_t)of_id->data;
 
 			if (i >= max_channels)
 				continue;
-- 
2.5.0
