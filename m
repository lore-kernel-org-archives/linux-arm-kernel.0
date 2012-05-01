From: marex@denx.de (Marek Vasut)
Date: Tue,  1 May 2012 04:00:21 +0200
Subject: =?UTF-8?q?=5BPATCH=204/4=5D=20MXS=3A=20Fix=20GCC4=2E7=20complaint=20in=20mxs-i2c?=
In-Reply-To: <1335837621-14816-1-git-send-email-marex@denx.de>
References: <1335837621-14816-1-git-send-email-marex@denx.de>
Message-ID: <1335837621-14816-5-git-send-email-marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

drivers/i2c/busses/i2c-mxs.c: In function 'mxs_i2c_xfer':
drivers/i2c/busses/i2c-mxs.c:253:8: warning: 'data' may be used uninitialized in this function [-Wmaybe-uninitialized]
drivers/i2c/busses/i2c-mxs.c:243:6: note: 'data' was declared here

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Detlev Zundel <dzu@denx.de>
CC: Dong Aisheng <b29396@freescale.com>
CC: Fabio Estevam <fabio.estevam@freescale.com>
Cc: Linux ARM kernel <linux-arm-kernel@lists.infradead.org>
Cc: linux-i2c at vger.kernel.org
CC: Sascha Hauer <s.hauer@pengutronix.de>
CC: Shawn Guo <shawn.guo@linaro.org>
Cc: Stefano Babic <sbabic@denx.de>
CC: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
Cc: Wolfgang Denk <wd@denx.de>
Cc: Wolfram Sang <w.sang@pengutronix.de>
---
 drivers/i2c/busses/i2c-mxs.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-mxs.c b/drivers/i2c/busses/i2c-mxs.c
index 7491194..89ea19d 100644
--- a/drivers/i2c/busses/i2c-mxs.c
+++ b/drivers/i2c/busses/i2c-mxs.c
@@ -240,7 +240,7 @@ static int mxs_i2c_wait_for_data(struct mxs_i2c_dev *i2c)
 
 static int mxs_i2c_finish_read(struct mxs_i2c_dev *i2c, u8 *buf, int len)
 {
-	u32 data;
+	u32 data = 0;
 	int i;
 
 	for (i = 0; i < len; i++) {
-- 
1.7.10
