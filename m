From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sat, 17 Sep 2016 17:35:31 +0200
Subject: [PATCH 23/24] ste_dma40: Rename a jump label in
 __d40_execute_command_phy()
In-Reply-To: <92810066-69b6-94e7-dcec-a28594b1328f@users.sourceforge.net>
References: <566ABCD9.1060404@users.sourceforge.net>
 <92810066-69b6-94e7-dcec-a28594b1328f@users.sourceforge.net>
Message-ID: <9c61e57a-13ea-0c0e-5dd3-046ffaaa9e98@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 17 Sep 2016 16:28:54 +0200

Adjust a jump label according to the current Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/dma/ste_dma40.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
index 0082ae0..01fe3a2 100644
--- a/drivers/dma/ste_dma40.c
+++ b/drivers/dma/ste_dma40.c
@@ -1083,7 +1083,7 @@ static int __d40_execute_command_phy(struct d40_chan *d40c,
 			D40_CHAN_POS(d40c->phy_chan->num);
 
 		if (status == D40_DMA_SUSPENDED || status == D40_DMA_STOP)
-			goto done;
+			goto unlock;
 	}
 
 	wmask = 0xffffffff & ~(D40_CHAN_POS_MASK(d40c->phy_chan->num));
@@ -1119,7 +1119,7 @@ static int __d40_execute_command_phy(struct d40_chan *d40c,
 		}
 
 	}
-done:
+ unlock:
 	spin_unlock_irqrestore(&d40c->base->execmd_lock, flags);
 	return ret;
 }
-- 
2.10.0
