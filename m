From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Tue, 8 Jul 2014 13:46:36 +0300
Subject: [PATCH 1/3] ARM: edma: Set default queue to lowest priority
In-Reply-To: <1404816398-12338-1-git-send-email-peter.ujfalusi@ti.com>
References: <1404816398-12338-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1404816398-12338-2-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the lowest priority queue as default for clients.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/common/edma.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/common/edma.c b/arch/arm/common/edma.c
index 485be42519b9..f834aae7720f 100644
--- a/arch/arm/common/edma.c
+++ b/arch/arm/common/edma.c
@@ -1470,7 +1470,8 @@ static int edma_setup_from_hw(struct device *dev, struct edma_soc_info *pdata,
 	queue_priority_map[i][1] = -1;
 
 	pdata->queue_priority_mapping = queue_priority_map;
-	pdata->default_queue = 0;
+	/* Default queue has the lowest priority */
+	pdata->default_queue = i - 1;
 
 	return 0;
 }
-- 
2.0.0
