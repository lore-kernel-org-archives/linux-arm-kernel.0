From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Sun,  1 Jul 2012 23:34:30 +0200
Subject: [PATCH] i2c: mxs: mxs_i2c_finish_read: mute flase positive
 uninitialized var
Message-ID: <1341178470-14904-1-git-send-email-mkl@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch mutes the false positive compiler warning:

drivers/i2c/busses/i2c-mxs.c: In function 'mxs_i2c_xfer_msg':
drivers/i2c/busses/i2c-mxs.c:206:8: warning: 'data' may be used uninitialized in this function [-Wuninitialized]
drivers/i2c/busses/i2c-mxs.c:196:6: note: 'data' was declared here

Cc: "Wolfram Sang" <w.sang@pengutronix.de>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/i2c/busses/i2c-mxs.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-mxs.c b/drivers/i2c/busses/i2c-mxs.c
index 04eb441..02ce1fa 100644
--- a/drivers/i2c/busses/i2c-mxs.c
+++ b/drivers/i2c/busses/i2c-mxs.c
@@ -193,7 +193,7 @@ static int mxs_i2c_wait_for_data(struct mxs_i2c_dev *i2c)
 
 static int mxs_i2c_finish_read(struct mxs_i2c_dev *i2c, u8 *buf, int len)
 {
-	u32 data;
+	u32 uninitialized_var(data);
 	int i;
 
 	for (i = 0; i < len; i++) {
-- 
1.7.10
