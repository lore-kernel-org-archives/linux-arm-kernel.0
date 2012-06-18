From: shubhrajyoti@ti.com (Shubhrajyoti D)
Date: Mon, 18 Jun 2012 20:00:25 +0530
Subject: [PATCHv8 10/13] I2C: OMAP: simplify num_bytes handling
In-Reply-To: <1340029828-20751-1-git-send-email-shubhrajyoti@ti.com>
References: <1340029828-20751-1-git-send-email-shubhrajyoti@ti.com>
Message-ID: <1340029828-20751-11-git-send-email-shubhrajyoti@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Felipe Balbi <balbi@ti.com>

trivial patch, no functional changes

Signed-off-by: Felipe Balbi <balbi@ti.com>
Reviewed-by : Santosh Shilimkar <santosh.shilimkar@ti.com>
Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
 drivers/i2c/busses/i2c-omap.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index e24eb1f..080193a 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -844,8 +844,7 @@ complete:
 							OMAP_I2C_BUFSTAT_REG)
 							>> 8) & 0x3F;
 			}
-			while (num_bytes) {
-				num_bytes--;
+			while (num_bytes--) {
 				w = omap_i2c_read_reg(dev, OMAP_I2C_DATA_REG);
 				if (dev->buf_len) {
 					*dev->buf++ = w;
@@ -887,8 +886,7 @@ complete:
 							OMAP_I2C_BUFSTAT_REG)
 							& 0x3F;
 			}
-			while (num_bytes) {
-				num_bytes--;
+			while (num_bytes--) {
 				w = 0;
 				if (dev->buf_len) {
 					w = *dev->buf++;
-- 
1.7.5.4
