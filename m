From: shubhrajyoti@ti.com (Shubhrajyoti D)
Date: Thu, 19 Jul 2012 20:08:04 +0530
Subject: [PATCHv5 14/18] i2c: omap: always return IRQ_HANDLED
In-Reply-To: <1342708688-2342-1-git-send-email-shubhrajyoti@ti.com>
References: <1342708688-2342-1-git-send-email-shubhrajyoti@ti.com>
Message-ID: <1342708688-2342-15-git-send-email-shubhrajyoti@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Felipe Balbi <balbi@ti.com>

otherwise we could get our IRQ line disabled due
to many spurious IRQs.

Signed-off-by: Felipe Balbi <balbi@ti.com>
Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
 drivers/i2c/busses/i2c-omap.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 19f6048..6847a98 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -959,7 +959,7 @@ complete:
 		}
 	} while (stat);
 
-	return count ? IRQ_HANDLED : IRQ_NONE;
+	return IRQ_HANDLED;
 }
 
 static const struct i2c_algorithm omap_i2c_algo = {
-- 
1.7.5.4
