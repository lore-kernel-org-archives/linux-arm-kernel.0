From: hofrat@osadl.org (Nicholas Mc Guire)
Date: Sun,  8 Feb 2015 07:34:33 -0500
Subject: [PATCH 1/2] i2c: nomadik: match return type of
 wait_for_completion_timeout
Message-ID: <1423398873-24653-1-git-send-email-hofrat@osadl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

return type of wait_for_completion_timeout is unsigned long not int. as
timeout is used for wait_for_completion_timeout exclusively here its
type is simply changed to unsigned long.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
---

Patch was only compile tested with multi_v5_defconfig
(implies CONFIG_I2C_NOMADIK=y)

Patch is against 3.19.0-rc7 (localversion-next is -next-20150204)

 drivers/i2c/busses/i2c-nomadik.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-nomadik.c b/drivers/i2c/busses/i2c-nomadik.c
index 9799894..6ca6ad6 100644
--- a/drivers/i2c/busses/i2c-nomadik.c
+++ b/drivers/i2c/busses/i2c-nomadik.c
@@ -448,7 +448,7 @@ static int read_i2c(struct nmk_i2c_dev *dev, u16 flags)
 {
 	u32 status = 0;
 	u32 mcr, irq_mask;
-	int timeout;
+	unsigned long timeout;
 
 	mcr = load_i2c_mcr_reg(dev, flags);
 	writel(mcr, dev->virtbase + I2C_MCR);
@@ -517,7 +517,7 @@ static int write_i2c(struct nmk_i2c_dev *dev, u16 flags)
 {
 	u32 status = 0;
 	u32 mcr, irq_mask;
-	int timeout;
+	unsigned long timeout;
 
 	mcr = load_i2c_mcr_reg(dev, flags);
 
-- 
1.7.10.4
