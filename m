From: anup.patel@broadcom.com (Anup Patel)
Date: Wed, 26 Jul 2017 11:06:41 +0530
Subject: [PATCH 3/6] dma: bcm-sba-raid: pre-ack async tx descriptor
In-Reply-To: <1501047404-14456-1-git-send-email-anup.patel@broadcom.com>
References: <1501047404-14456-1-git-send-email-anup.patel@broadcom.com>
Message-ID: <1501047404-14456-4-git-send-email-anup.patel@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We should pre-ack async tx descriptor at time of
allocating SBA request (just like other RAID drivers).

Signed-off-by: Anup Patel <anup.patel@broadcom.com>
Reviewed-by: Ray Jui <ray.jui@broadcom.com>
Reviewed-by: Scott Branden <scott.branden@broadcom.com>
---
 drivers/dma/bcm-sba-raid.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/bcm-sba-raid.c b/drivers/dma/bcm-sba-raid.c
index 321420b..db5e3db 100644
--- a/drivers/dma/bcm-sba-raid.c
+++ b/drivers/dma/bcm-sba-raid.c
@@ -236,6 +236,7 @@ static struct sba_request *sba_alloc_request(struct sba_device *sba)
 	atomic_set(&req->next_pending_count, 1);
 
 	dma_async_tx_descriptor_init(&req->tx, &sba->dma_chan);
+	async_tx_ack(&req->tx);
 
 	return req;
 }
-- 
2.7.4
