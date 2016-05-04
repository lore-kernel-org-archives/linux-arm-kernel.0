From: david.wu@rock-chips.com (David Wu)
Date: Wed,  4 May 2016 22:13:08 +0800
Subject: [PATCH v7 3/9] i2c: rk3x: Remove redundant rk3x_i2c_clean_ipd()
In-Reply-To: <1462371194-5809-1-git-send-email-david.wu@rock-chips.com>
References: <1462371194-5809-1-git-send-email-david.wu@rock-chips.com>
Message-ID: <1462371194-5809-4-git-send-email-david.wu@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Call rk3x_i2c_setup() before rk3x_i2c_start()
and the last thing in setup was to clean the IPD,
so no reason to do it at the beginning of start.

Signed-off-by: David Wu <david.wu@rock-chips.com>
---
Change in v7:
- none

 drivers/i2c/busses/i2c-rk3x.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-rk3x.c b/drivers/i2c/busses/i2c-rk3x.c
index 1e2677a..9eeb4e5 100644
--- a/drivers/i2c/busses/i2c-rk3x.c
+++ b/drivers/i2c/busses/i2c-rk3x.c
@@ -174,7 +174,6 @@ static void rk3x_i2c_start(struct rk3x_i2c *i2c)
 {
 	u32 val;
 
-	rk3x_i2c_clean_ipd(i2c);
 	i2c_writel(i2c, REG_INT_START, REG_IEN);
 
 	/* enable adapter with correct mode, send START condition */
-- 
1.9.1
