From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sat, 17 Sep 2016 17:30:26 +0200
Subject: [PATCH 18/24] ste_dma40: Rename a jump label in d40_is_paused()
In-Reply-To: <92810066-69b6-94e7-dcec-a28594b1328f@users.sourceforge.net>
References: <566ABCD9.1060404@users.sourceforge.net>
 <92810066-69b6-94e7-dcec-a28594b1328f@users.sourceforge.net>
Message-ID: <73e6fdd1-7419-db64-a007-2e55178b8127@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 17 Sep 2016 16:00:05 +0200

Adjust jump labels according to the current Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/dma/ste_dma40.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
index 4a21778..d99241c 100644
--- a/drivers/dma/ste_dma40.c
+++ b/drivers/dma/ste_dma40.c
@@ -2092,8 +2092,7 @@ static bool d40_is_paused(struct d40_chan *d40c)
 			D40_CHAN_POS(d40c->phy_chan->num);
 		if (status == D40_DMA_SUSPENDED || status == D40_DMA_STOP)
 			is_paused = true;
-
-		goto _exit;
+		goto unlock;
 	}
 
 	if (d40c->dma_cfg.dir == DMA_MEM_TO_DEV ||
@@ -2103,7 +2102,7 @@ static bool d40_is_paused(struct d40_chan *d40c)
 		status = readl(chanbase + D40_CHAN_REG_SSLNK);
 	} else {
 		chan_err(d40c, "Unknown direction\n");
-		goto _exit;
+		goto unlock;
 	}
 
 	status = (status & D40_EVENTLINE_MASK(event)) >>
@@ -2111,7 +2110,7 @@ static bool d40_is_paused(struct d40_chan *d40c)
 
 	if (status != D40_DMA_RUN)
 		is_paused = true;
-_exit:
+ unlock:
 	spin_unlock_irqrestore(&d40c->lock, flags);
 	return is_paused;
 
-- 
2.10.0
