From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sat, 17 Sep 2016 17:32:20 +0200
Subject: [PATCH 20/24] ste_dma40: Rename a jump label in d40_alloc_mask_free()
In-Reply-To: <92810066-69b6-94e7-dcec-a28594b1328f@users.sourceforge.net>
References: <566ABCD9.1060404@users.sourceforge.net>
 <92810066-69b6-94e7-dcec-a28594b1328f@users.sourceforge.net>
Message-ID: <d4da4639-a261-99ed-5afc-4c65e9df455c@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 17 Sep 2016 16:10:41 +0200

Adjust a jump label according to the current Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/dma/ste_dma40.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
index 917b24a..fbe87a2 100644
--- a/drivers/dma/ste_dma40.c
+++ b/drivers/dma/ste_dma40.c
@@ -1829,7 +1829,7 @@ static bool d40_alloc_mask_free(struct d40_phy_res *phy, bool is_src,
 		phy->allocated_dst = D40_ALLOC_FREE;
 		phy->allocated_src = D40_ALLOC_FREE;
 		is_free = true;
-		goto out;
+		goto unlock;
 	}
 
 	/* Logical channel */
@@ -1845,8 +1845,7 @@ static bool d40_alloc_mask_free(struct d40_phy_res *phy, bool is_src,
 
 	is_free = ((phy->allocated_src | phy->allocated_dst) ==
 		   D40_ALLOC_FREE);
-
-out:
+ unlock:
 	spin_unlock_irqrestore(&phy->lock, flags);
 
 	return is_free;
-- 
2.10.0
