From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 24 Nov 2011 15:52:20 +0800
Subject: [PATCH] i2c-mxs: fix compile warning in mxs_i2c_xfer()
Message-ID: <1322121140-5216-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

  CC      drivers/i2c/busses/i2c-mxs.o
drivers/i2c/busses/i2c-mxs.c: In function ?mxs_i2c_xfer?:
drivers/i2c/busses/i2c-mxs.c:196:6: warning: ?data? may be used uninitialized in this function

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/i2c/busses/i2c-mxs.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mxs.c b/drivers/i2c/busses/i2c-mxs.c
index 7e78f7c..00f098f 100644
--- a/drivers/i2c/busses/i2c-mxs.c
+++ b/drivers/i2c/busses/i2c-mxs.c
@@ -193,7 +193,7 @@ static int mxs_i2c_wait_for_data(struct mxs_i2c_dev *i2c)
 
 static int mxs_i2c_finish_read(struct mxs_i2c_dev *i2c, u8 *buf, int len)
 {
-	u32 data;
+	u32 data = 0;
 	int i;
 
 	for (i = 0; i < len; i++) {
-- 
1.7.4.1
