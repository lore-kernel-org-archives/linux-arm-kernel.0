From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Mon, 14 Apr 2014 14:41:57 +0300
Subject: [PATCH v3 02/10] arm: common: edma: Save the number of event
 queues/TCs
In-Reply-To: <1397475725-5036-1-git-send-email-peter.ujfalusi@ti.com>
References: <1397475725-5036-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1397475725-5036-3-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For later use save the number of queues available for the CC.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Acked-by: Joel Fernandes <joelf@ti.com>
---
 arch/arm/common/edma.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/common/edma.c b/arch/arm/common/edma.c
index 41bca32409fc..999266bf69b9 100644
--- a/arch/arm/common/edma.c
+++ b/arch/arm/common/edma.c
@@ -1768,6 +1768,9 @@ static int edma_probe(struct platform_device *pdev)
 			map_queue_tc(j, queue_tc_mapping[i][0],
 					queue_tc_mapping[i][1]);
 
+		/* Save the number of TCs */
+		edma_cc[j]->num_tc = i;
+
 		/* Event queue priority mapping */
 		for (i = 0; queue_priority_mapping[i][0] != -1; i++)
 			assign_priority_to_queue(j,
-- 
1.9.2
