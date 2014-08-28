From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 28 Aug 2014 15:44:45 +0100
Subject: [PATCH 3/4] mfd: max8925-i2c: Fix variable length array Sparse warning
In-Reply-To: <1409237086-21421-1-git-send-email-lee.jones@linaro.org>
References: <1409237086-21421-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1409237086-21421-3-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The largest byte size in use currently is 8.  Fix array size to 9.

drivers/mfd/max8925-i2c.c:40:33:
  warning: Variable length array is used

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/max8925-i2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/max8925-i2c.c b/drivers/mfd/max8925-i2c.c
index ecbe78e..c880c89 100644
--- a/drivers/mfd/max8925-i2c.c
+++ b/drivers/mfd/max8925-i2c.c
@@ -37,7 +37,7 @@ static inline int max8925_read_device(struct i2c_client *i2c,
 static inline int max8925_write_device(struct i2c_client *i2c,
 				       int reg, int bytes, void *src)
 {
-	unsigned char buf[bytes + 1];
+	unsigned char buf[9];
 	int ret;
 
 	buf[0] = (unsigned char)reg;
-- 
1.9.1
