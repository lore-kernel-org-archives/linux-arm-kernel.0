From: julien.grall@citrix.com (Julien Grall)
Date: Wed, 17 Jun 2015 15:28:07 +0100
Subject: [PATCH v2 6/7] block/xen-blkfront: Remove invalid comment
In-Reply-To: <1434551288-14113-1-git-send-email-julien.grall@citrix.com>
References: <1434551288-14113-1-git-send-email-julien.grall@citrix.com>
Message-ID: <1434551288-14113-7-git-send-email-julien.grall@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Julien Grall <julien.grall@linaro.org>

Since commit b764915 "xen-blkfront: use a different scatterlist for each
request", biovec has been replaced by scatterlist when copying back the
data during a completion request.

Signed-off-by: Julien Grall <julien.grall@citrix.com>
Acked-by: Roger Pau Monn? <roger.pau@citrix.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: David Vrabel <david.vrabel@citrix.com>

---
    Changes in v2:
        - Add Roger's Acked-by
---
 drivers/block/xen-blkfront.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
index 5c72c25..60cf1d6 100644
--- a/drivers/block/xen-blkfront.c
+++ b/drivers/block/xen-blkfront.c
@@ -1056,12 +1056,6 @@ static void blkif_completion(struct blk_shadow *s, struct blkfront_info *info,
 		s->req.u.indirect.nr_segments : s->req.u.rw.nr_segments;
 
 	if (bret->operation == BLKIF_OP_READ && info->feature_persistent) {
-		/*
-		 * Copy the data received from the backend into the bvec.
-		 * Since bv_offset can be different than 0, and bv_len different
-		 * than PAGE_SIZE, we have to keep track of the current offset,
-		 * to be sure we are copying the data from the right shared page.
-		 */
 		for_each_sg(s->sg, sg, nseg, i) {
 			BUG_ON(sg->offset + sg->length > PAGE_SIZE);
 			shared_data = kmap_atomic(
-- 
2.1.4
