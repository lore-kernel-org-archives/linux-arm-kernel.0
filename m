From: davidcdueck@googlemail.com (David Dueck)
Date: Sun, 15 Mar 2015 11:54:47 +0100
Subject: [PATCH] rtc: at91rm9200: Fix locking in interrupt handler
Message-ID: <1426416887-3450-1-git-send-email-davidcdueck@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: David Dueck <davidcdueck@googlemail.com>
---
 drivers/rtc/rtc-at91rm9200.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-at91rm9200.c b/drivers/rtc/rtc-at91rm9200.c
index b4f7744..b283a1a 100644
--- a/drivers/rtc/rtc-at91rm9200.c
+++ b/drivers/rtc/rtc-at91rm9200.c
@@ -324,7 +324,7 @@ static irqreturn_t at91_rtc_interrupt(int irq, void *dev_id)
 
 		ret = IRQ_HANDLED;
 	}
-	spin_lock(&suspended_lock);
+	spin_unlock(&suspended_lock);
 
 	return ret;
 }
-- 
2.3.0
