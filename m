From: aleksey.makarov@caviumnetworks.com (Aleksey Makarov)
Date: Tue, 2 Jun 2015 11:00:27 -0700
Subject: [PATCH 10/10] net: thunderx: use GFP_KERNEL in thread context
In-Reply-To: <1433268028-23992-1-git-send-email-aleksey.makarov@caviumnetworks.com>
References: <1433268028-23992-1-git-send-email-aleksey.makarov@caviumnetworks.com>
Message-ID: <1433268028-23992-11-git-send-email-aleksey.makarov@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

GFP_KERNEL should be used in the thread context

Signed-off-by: Aleksey Makarov <aleksey.makarov@caviumnetworks.com>
---
 drivers/net/ethernet/cavium/thunder/nicvf_queues.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cavium/thunder/nicvf_queues.c b/drivers/net/ethernet/cavium/thunder/nicvf_queues.c
index 2ed7d1b..d69d228 100644
--- a/drivers/net/ethernet/cavium/thunder/nicvf_queues.c
+++ b/drivers/net/ethernet/cavium/thunder/nicvf_queues.c
@@ -356,7 +356,7 @@ static int nicvf_init_snd_queue(struct nicvf *nic,
 		return err;
 
 	sq->desc = sq->dmem.base;
-	sq->skbuff = kcalloc(q_len, sizeof(u64), GFP_ATOMIC);
+	sq->skbuff = kcalloc(q_len, sizeof(u64), GFP_KERNEL);
 	if (!sq->skbuff)
 		return -ENOMEM;
 	sq->head = 0;
-- 
2.4.1
