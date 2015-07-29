From: aleksey.makarov@caviumnetworks.com (Aleksey Makarov)
Date: Wed, 29 Jul 2015 16:49:40 +0300
Subject: [PATCH net 05/11] net: thunderx: Fix TSO packet statistic
In-Reply-To: <1438177787-20940-1-git-send-email-aleksey.makarov@caviumnetworks.com>
References: <1438177787-20940-1-git-send-email-aleksey.makarov@caviumnetworks.com>
Message-ID: <1438177787-20940-6-git-send-email-aleksey.makarov@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sunil Goutham <sgoutham@cavium.com>

Fixing TSO packages not being counted.

Signed-off-by: Sunil Goutham <sgoutham@cavium.com>
Signed-off-by: Aleksey Makarov <aleksey.makarov@caviumnetworks.com>
---
 drivers/net/ethernet/cavium/thunder/nicvf_queues.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/cavium/thunder/nicvf_queues.c b/drivers/net/ethernet/cavium/thunder/nicvf_queues.c
index 4c91959..500fdbe 100644
--- a/drivers/net/ethernet/cavium/thunder/nicvf_queues.c
+++ b/drivers/net/ethernet/cavium/thunder/nicvf_queues.c
@@ -1064,6 +1064,7 @@ static int nicvf_sq_append_tso(struct nicvf *nic, struct snd_queue *sq,
 	/* Inform HW to xmit all TSO segments */
 	nicvf_queue_reg_write(nic, NIC_QSET_SQ_0_7_DOOR,
 			      skb_get_queue_mapping(skb), desc_cnt);
+	nic->drv_stats.tx_tso++;
 	return 1;
 }
 
-- 
2.4.6
