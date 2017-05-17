From: anup.patel@broadcom.com (Anup Patel)
Date: Wed, 17 May 2017 13:24:50 +0530
Subject: [PATCH] mailbox: bcm-flexrm-mailbox: Fix typo in dma_mask setup
Message-ID: <1495007690-14146-1-git-send-email-anup.patel@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The output address of Broadcom FlexRM is 39bits and not
40bits hence we fix dma_mask setup in flexrm_mbox_probe()
accordingly.

Fixes: dbc049eee730 ("mailbox: Add driver for Broadcom
FlexRM ring manager")

Signed-off-by: Anup Patel <anup.patel@broadcom.com>
Reviewed-by: Scott Branden <scott.branden@broadcom.com>
---
 drivers/mailbox/bcm-flexrm-mailbox.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mailbox/bcm-flexrm-mailbox.c b/drivers/mailbox/bcm-flexrm-mailbox.c
index da67882..6aeac6e 100644
--- a/drivers/mailbox/bcm-flexrm-mailbox.c
+++ b/drivers/mailbox/bcm-flexrm-mailbox.c
@@ -1479,8 +1479,8 @@ static int flexrm_mbox_probe(struct platform_device *pdev)
 		ring->cmpl_read_offset = 0;
 	}
 
-	/* FlexRM is capable of 40-bit physical addresses only */
-	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(40));
+	/* FlexRM is capable of 39-bit physical addresses only */
+	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(39));
 	if (ret) {
 		ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
 		if (ret)
-- 
2.7.4
