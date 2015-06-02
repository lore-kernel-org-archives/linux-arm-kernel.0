From: aleksey.makarov@caviumnetworks.com (Aleksey Makarov)
Date: Tue, 2 Jun 2015 11:00:25 -0700
Subject: [PATCH 08/10] net: thunderx: remove unneeded type conversions
In-Reply-To: <1433268028-23992-1-git-send-email-aleksey.makarov@caviumnetworks.com>
References: <1433268028-23992-1-git-send-email-aleksey.makarov@caviumnetworks.com>
Message-ID: <1433268028-23992-9-git-send-email-aleksey.makarov@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

No need to cast void* to u8*: pointer arithmetics
works same way for both.

Signed-off-by: Aleksey Makarov <aleksey.makarov@caviumnetworks.com>
---
 drivers/net/ethernet/cavium/thunder/nicvf_queues.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/cavium/thunder/nicvf_queues.c b/drivers/net/ethernet/cavium/thunder/nicvf_queues.c
index 7f0e108..8929029 100644
--- a/drivers/net/ethernet/cavium/thunder/nicvf_queues.c
+++ b/drivers/net/ethernet/cavium/thunder/nicvf_queues.c
@@ -62,8 +62,7 @@ static int nicvf_alloc_q_desc_mem(struct nicvf *nic, struct q_desc_mem *dmem,
 
 	/* Align memory address for 'align_bytes' */
 	dmem->phys_base = NICVF_ALIGNED_ADDR((u64)dmem->dma, align_bytes);
-	dmem->base = (void *)((u8 *)dmem->unalign_base +
-			      (dmem->phys_base - dmem->dma));
+	dmem->base = dmem->unalign_base + (dmem->phys_base - dmem->dma);
 	return 0;
 }
 
-- 
2.4.1
