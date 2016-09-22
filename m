From: david.wu@rock-chips.com (David Wu)
Date: Thu, 22 Sep 2016 19:29:23 +0800
Subject: [PATCH 1/2] i2c: rk3x: Fix sparse warning
In-Reply-To: <1474543764-51135-1-git-send-email-david.wu@rock-chips.com>
References: <1474543764-51135-1-git-send-email-david.wu@rock-chips.com>
Message-ID: <1474543764-51135-2-git-send-email-david.wu@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes the following sparse warning:
drivers/i2c/busses/i2c-rk3x.c:888:17: warning: cast truncates bits from constant value (ffffffffff00 becomes ffffff00)

Signed-off-by: David Wu <david.wu@rock-chips.com>
---
 drivers/i2c/busses/i2c-rk3x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-rk3x.c b/drivers/i2c/busses/i2c-rk3x.c
index f2d0148..965477e 100644
--- a/drivers/i2c/busses/i2c-rk3x.c
+++ b/drivers/i2c/busses/i2c-rk3x.c
@@ -58,7 +58,7 @@ enum {
 #define REG_CON_LASTACK   BIT(5) /* 1: send NACK after last received byte */
 #define REG_CON_ACTACK    BIT(6) /* 1: stop if NACK is received */
 
-#define REG_CON_TUNING_MASK GENMASK(15, 8)
+#define REG_CON_TUNING_MASK GENMASK_ULL(15, 8)
 
 #define REG_CON_SDA_CFG(cfg) ((cfg) << 8)
 #define REG_CON_STA_CFG(cfg) ((cfg) << 12)
-- 
1.9.1
