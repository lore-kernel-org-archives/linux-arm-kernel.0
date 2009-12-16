From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 16 Dec 2009 17:28:03 +0100
Subject: [PATCH] dma: at_hdmac: correct incompatible type for argument 1 of
	'spin_lock_bh'
Message-ID: <1260980883-30030-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Correct a typo error in locking calls.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 drivers/dma/at_hdmac.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
index f151125..efc1a61 100644
--- a/drivers/dma/at_hdmac.c
+++ b/drivers/dma/at_hdmac.c
@@ -815,7 +815,7 @@ atc_is_tx_complete(struct dma_chan *chan,
 	dev_vdbg(chan2dev(chan), "is_tx_complete: %d (d%d, u%d)\n",
 			cookie, done ? *done : 0, used ? *used : 0);
 
-	spin_lock_bh(atchan->lock);
+	spin_lock_bh(&atchan->lock);
 
 	last_complete = atchan->completed_cookie;
 	last_used = chan->cookie;
@@ -830,7 +830,7 @@ atc_is_tx_complete(struct dma_chan *chan,
 		ret = dma_async_is_complete(cookie, last_complete, last_used);
 	}
 
-	spin_unlock_bh(atchan->lock);
+	spin_unlock_bh(&atchan->lock);
 
 	if (done)
 		*done = last_complete;
-- 
1.5.6.5
