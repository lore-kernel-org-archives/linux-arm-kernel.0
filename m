From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sat, 17 Sep 2016 17:33:20 +0200
Subject: [PATCH 21/24] ste_dma40: Rename jump labels in d40_alloc_mask_set()
In-Reply-To: <92810066-69b6-94e7-dcec-a28594b1328f@users.sourceforge.net>
References: <566ABCD9.1060404@users.sourceforge.net>
 <92810066-69b6-94e7-dcec-a28594b1328f@users.sourceforge.net>
Message-ID: <759a5edb-0f6e-db86-6c8f-e0118467023d@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 17 Sep 2016 16:16:42 +0200

Adjust jump labels according to the current Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/dma/ste_dma40.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
index fbe87a2..4a2f39b 100644
--- a/drivers/dma/ste_dma40.c
+++ b/drivers/dma/ste_dma40.c
@@ -1778,42 +1778,40 @@ static bool d40_alloc_mask_set(struct d40_phy_res *phy,
 		    phy->allocated_dst == D40_ALLOC_FREE) {
 			phy->allocated_dst = D40_ALLOC_PHY;
 			phy->allocated_src = D40_ALLOC_PHY;
-			goto found;
+			goto found_unlock;
 		} else
-			goto not_found;
+			goto not_found_unlock;
 	}
 
 	/* Logical channel */
 	if (is_src) {
 		if (phy->allocated_src == D40_ALLOC_PHY)
-			goto not_found;
+			goto not_found_unlock;
 
 		if (phy->allocated_src == D40_ALLOC_FREE)
 			phy->allocated_src = D40_ALLOC_LOG_FREE;
 
 		if (!(phy->allocated_src & BIT(log_event_line))) {
 			phy->allocated_src |= BIT(log_event_line);
-			goto found;
+			goto found_unlock;
 		} else
-			goto not_found;
+			goto not_found_unlock;
 	} else {
 		if (phy->allocated_dst == D40_ALLOC_PHY)
-			goto not_found;
+			goto not_found_unlock;
 
 		if (phy->allocated_dst == D40_ALLOC_FREE)
 			phy->allocated_dst = D40_ALLOC_LOG_FREE;
 
 		if (!(phy->allocated_dst & BIT(log_event_line))) {
 			phy->allocated_dst |= BIT(log_event_line);
-			goto found;
-		} else
-			goto not_found;
+			goto found_unlock;
+		}
 	}
-
-not_found:
+ not_found_unlock:
 	spin_unlock_irqrestore(&phy->lock, flags);
 	return false;
-found:
+ found_unlock:
 	spin_unlock_irqrestore(&phy->lock, flags);
 	return true;
 }
-- 
2.10.0
