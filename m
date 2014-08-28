From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 28 Aug 2014 15:44:44 +0100
Subject: [PATCH 2/4] mfd: 88pm860x-i2c: Fix variable length array Sparse
 warning
In-Reply-To: <1409237086-21421-1-git-send-email-lee.jones@linaro.org>
References: <1409237086-21421-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1409237086-21421-2-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

drivers/mfd/88pm860x-i2c.c:125:33:
  warning: Variable length array is used.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/88pm860x-i2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/88pm860x-i2c.c b/drivers/mfd/88pm860x-i2c.c
index 7063cfd..84e3131 100644
--- a/drivers/mfd/88pm860x-i2c.c
+++ b/drivers/mfd/88pm860x-i2c.c
@@ -122,7 +122,7 @@ static int read_device(struct i2c_client *i2c, int reg,
 static int write_device(struct i2c_client *i2c, int reg,
 			int bytes, void *src)
 {
-	unsigned char buf[bytes + 1];
+	unsigned char buf[2];
 	struct i2c_adapter *adap = i2c->adapter;
 	struct i2c_msg msg;
 	int ret;
-- 
1.9.1
