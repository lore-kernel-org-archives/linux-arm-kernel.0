From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Tue, 1 Apr 2014 16:06:06 +0300
Subject: [PATCH v2 05/14] arm: common: edma: Select event queue 1 as default
 when booted with DT
In-Reply-To: <1396357575-30585-1-git-send-email-peter.ujfalusi@ti.com>
References: <1396357575-30585-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1396357575-30585-6-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the EVENTQ_1 for default and leave the EVENTQ_0 to be used by high
priority channels, like audio.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/common/edma.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/common/edma.c b/arch/arm/common/edma.c
index 86a8b263278f..19520e2519d9 100644
--- a/arch/arm/common/edma.c
+++ b/arch/arm/common/edma.c
@@ -1546,7 +1546,8 @@ static int edma_of_parse_dt(struct device *dev,
 
 	pdata->queue_priority_mapping = queue_priority_map;
 
-	pdata->default_queue = 0;
+	/* select queue 1 as default */
+	pdata->default_queue = EVENTQ_1;
 
 	prop = of_find_property(node, "ti,edma-xbar-event-map", &sz);
 	if (prop)
-- 
1.9.1
