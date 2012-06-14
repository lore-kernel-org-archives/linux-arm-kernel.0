From: balbi@ti.com (Felipe Balbi)
Date: Thu, 14 Jun 2012 19:24:25 +0300
Subject: [PATCH v2 15/17] i2c: omap: always return IRQ_HANDLED
In-Reply-To: <1339691067-919-1-git-send-email-balbi@ti.com>
References: <1339691067-919-1-git-send-email-balbi@ti.com>
Message-ID: <1339691067-919-16-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

otherwise we could get our IRQ line disabled due
to many spurious IRQs.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/i2c/busses/i2c-omap.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 6e97d86..572fad7 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -1014,7 +1014,7 @@ omap_i2c_isr(int this_irq, void *dev_id)
 		}
 	} while (stat);
 
-	return count ? IRQ_HANDLED : IRQ_NONE;
+	return IRQ_HANDLED;
 }
 
 static const struct i2c_algorithm omap_i2c_algo = {
-- 
1.7.10.4
