From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 15 Nov 2012 18:20:29 +0100
Subject: [PATCH 24/29] mv_xor: remove useless backpointer from mv_xor_chan to
 mv_xor_device
In-Reply-To: <1353000034-30567-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1353000034-30567-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1353000034-30567-25-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The backpointer from mv_xor_chan to mv_xor_device is now useless, get
rid of it.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/dma/mv_xor.c |    1 -
 drivers/dma/mv_xor.h |    1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/dma/mv_xor.c b/drivers/dma/mv_xor.c
index d934f8b..4e941f2 100644
--- a/drivers/dma/mv_xor.c
+++ b/drivers/dma/mv_xor.c
@@ -1118,7 +1118,6 @@ mv_xor_channel_add(struct mv_xor_device *xordev,
 
 	/* discover transaction capabilites from the platform data */
 	dma_dev->cap_mask = cap_mask;
-	mv_chan->shared = xordev;
 
 	INIT_LIST_HEAD(&dma_dev->channels);
 
diff --git a/drivers/dma/mv_xor.h b/drivers/dma/mv_xor.h
index cedeaa0..dab9f30 100644
--- a/drivers/dma/mv_xor.h
+++ b/drivers/dma/mv_xor.h
@@ -87,7 +87,6 @@ struct mv_xor_chan {
 	void			*dma_desc_pool_virt;
 	size_t                  pool_size;
 	struct dma_device	dmadev;
-	struct mv_xor_device	*shared;
 	struct dma_chan		dmachan;
 	struct mv_xor_desc_slot	*last_used;
 	struct list_head	all_slots;
-- 
1.7.9.5
