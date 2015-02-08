From: hofrat@osadl.org (Nicholas Mc Guire)
Date: Sun,  8 Feb 2015 07:55:55 -0500
Subject: [PATCH] i2c: cadence: match return type of wait_for_completion_timeout
Message-ID: <1423400155-28078-1-git-send-email-hofrat@osadl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

return type of wait_for_completion_timeout is unsigned long not int. as
ret is only used for wait_for_completion_timeout anyway the type is simply 
changed to unsigned long.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
---

Patch was only compile tested with multi_v7_defconfig
(implies CONFIG_I2C_CADENCE=y)

Patch is against 3.19.0-rc7 (localversion-next is -next-20150204)

 drivers/i2c/busses/i2c-cadence.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-cadence.c b/drivers/i2c/busses/i2c-cadence.c
index 7d7a14c..5fbffe0 100644
--- a/drivers/i2c/busses/i2c-cadence.c
+++ b/drivers/i2c/busses/i2c-cadence.c
@@ -475,7 +475,7 @@ static void cdns_i2c_master_reset(struct i2c_adapter *adap)
 static int cdns_i2c_process_msg(struct cdns_i2c *id, struct i2c_msg *msg,
 		struct i2c_adapter *adap)
 {
-	int ret;
+	unsigned long ret;
 	u32 reg;
 
 	id->p_msg = msg;
-- 
1.7.10.4
