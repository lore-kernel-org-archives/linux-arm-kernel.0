From: anup.patel@broadcom.com (Anup Patel)
Date: Tue, 22 Aug 2017 15:27:01 +0530
Subject: [PATCH v3 12/17] dmaengine: bcm-sba-raid: Pre-ack async tx descriptor
In-Reply-To: <1503395827-19428-1-git-send-email-anup.patel@broadcom.com>
References: <1503395827-19428-1-git-send-email-anup.patel@broadcom.com>
Message-ID: <1503395827-19428-13-git-send-email-anup.patel@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We should pre-ack async tx descriptor at time of
allocating sba_request (just like other RAID drivers).

Signed-off-by: Anup Patel <anup.patel@broadcom.com>
Reviewed-by: Ray Jui <ray.jui@broadcom.com>
Reviewed-by: Scott Branden <scott.branden@broadcom.com>
---
 drivers/dma/bcm-sba-raid.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/bcm-sba-raid.c b/drivers/dma/bcm-sba-raid.c
index 399250e..2f444cc 100644
--- a/drivers/dma/bcm-sba-raid.c
+++ b/drivers/dma/bcm-sba-raid.c
@@ -237,6 +237,7 @@ static struct sba_request *sba_alloc_request(struct sba_device *sba)
 	atomic_set(&req->next_pending_count, 1);
 
 	dma_async_tx_descriptor_init(&req->tx, &sba->dma_chan);
+	async_tx_ack(&req->tx);
 
 	return req;
 }
-- 
2.7.4
