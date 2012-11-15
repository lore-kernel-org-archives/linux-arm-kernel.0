From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 15 Nov 2012 18:20:19 +0100
Subject: [PATCH 14/29] mv_xor: remove unused id field in mv_xor_device
 structure
In-Reply-To: <1353000034-30567-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1353000034-30567-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1353000034-30567-15-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/dma/mv_xor.c |    2 --
 drivers/dma/mv_xor.h |    1 -
 2 files changed, 3 deletions(-)

diff --git a/drivers/dma/mv_xor.c b/drivers/dma/mv_xor.c
index 7ebb918..25f814a 100644
--- a/drivers/dma/mv_xor.c
+++ b/drivers/dma/mv_xor.c
@@ -1125,8 +1125,6 @@ mv_xor_channel_add(struct mv_xor_private *msp,
 	if (!adev->dma_desc_pool_virt)
 		return ERR_PTR(-ENOMEM);
 
-	adev->id = hw_id;
-
 	/* discover transaction capabilites from the platform data */
 	dma_dev->cap_mask = cap_mask;
 	adev->pdev = pdev;
diff --git a/drivers/dma/mv_xor.h b/drivers/dma/mv_xor.h
index 7812565..52ca617 100644
--- a/drivers/dma/mv_xor.h
+++ b/drivers/dma/mv_xor.h
@@ -71,7 +71,6 @@ struct mv_xor_private {
  */
 struct mv_xor_device {
 	struct platform_device		*pdev;
-	int				id;
 	dma_addr_t			dma_desc_pool;
 	void				*dma_desc_pool_virt;
 	size_t                          pool_size;
-- 
1.7.9.5
