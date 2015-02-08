From: hofrat@osadl.org (Nicholas Mc Guire)
Date: Sun,  8 Feb 2015 07:34:43 -0500
Subject: [PATCH 2/2] i2c: nomadik: match status to return type of read_i2c
Message-ID: <1423398883-24687-1-git-send-email-hofrat@osadl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

return type of read_i2c() is int not u32. As the assignments to status
are consistent with int here its type is changed to int.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
---

This patch depends on "[PATCH 1/2] i2c: nomadik: match return type of
wait_for_completion_timeout" 

Patch was only compile tested with multi_v5_defconfig
(implies CONFIG_I2C_NOMADIK=y)

Patch is against 3.19.0-rc7 (localversion-next is -next-20150204)

 drivers/i2c/busses/i2c-nomadik.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-nomadik.c b/drivers/i2c/busses/i2c-nomadik.c
index 6ca6ad6..bcd17e8 100644
--- a/drivers/i2c/busses/i2c-nomadik.c
+++ b/drivers/i2c/busses/i2c-nomadik.c
@@ -446,7 +446,7 @@ static void setup_i2c_controller(struct nmk_i2c_dev *dev)
  */
 static int read_i2c(struct nmk_i2c_dev *dev, u16 flags)
 {
-	u32 status = 0;
+	int status = 0;
 	u32 mcr, irq_mask;
 	unsigned long timeout;
 
-- 
1.7.10.4
