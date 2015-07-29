From: aleksey.makarov@caviumnetworks.com (Aleksey Makarov)
Date: Wed, 29 Jul 2015 16:49:36 +0300
Subject: [PATCH net 01/11] net: thunderx: Fix data integrity issues with LDWB
In-Reply-To: <1438177787-20940-1-git-send-email-aleksey.makarov@caviumnetworks.com>
References: <1438177787-20940-1-git-send-email-aleksey.makarov@caviumnetworks.com>
Message-ID: <1438177787-20940-2-git-send-email-aleksey.makarov@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sunil Goutham <sgoutham@cavium.com>

Switching back to LDD transactions from LDWB.

While transmitting packets out with LDWB transactions
data integrity issues are seen very frequently.
hence switching back to LDD.

Signed-off-by: Sunil Goutham <sgoutham@cavium.com>
Signed-off-by: Robert Richter <rrichter@cavium.com>
Signed-off-by: Aleksey Makarov <aleksey.makarov@caviumnetworks.com>
---
 drivers/net/ethernet/cavium/thunder/nicvf_queues.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cavium/thunder/nicvf_queues.c b/drivers/net/ethernet/cavium/thunder/nicvf_queues.c
index d69d228..4dae6aa 100644
--- a/drivers/net/ethernet/cavium/thunder/nicvf_queues.c
+++ b/drivers/net/ethernet/cavium/thunder/nicvf_queues.c
@@ -992,7 +992,7 @@ static inline void nicvf_sq_add_gather_subdesc(struct snd_queue *sq, int qentry,
 
 	memset(gather, 0, SND_QUEUE_DESC_SIZE);
 	gather->subdesc_type = SQ_DESC_TYPE_GATHER;
-	gather->ld_type = NIC_SEND_LD_TYPE_E_LDWB;
+	gather->ld_type = NIC_SEND_LD_TYPE_E_LDD;
 	gather->size = size;
 	gather->addr = data;
 }
-- 
2.4.6
