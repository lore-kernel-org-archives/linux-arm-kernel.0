From: shubhrajyoti@ti.com (Shubhrajyoti D)
Date: Thu, 21 Jul 2011 12:23:04 +0530
Subject: [PATCH 4/5] OMAP: I2C: Remove the SYSC register definition
In-Reply-To: <1311231185-5503-1-git-send-email-shubhrajyoti@ti.com>
References: <1311231185-5503-1-git-send-email-shubhrajyoti@ti.com>
Message-ID: <1311231185-5503-5-git-send-email-shubhrajyoti@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The SYSC register should not accessed in the driver removing the
define from the driver.

Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
 drivers/i2c/busses/i2c-omap.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index d6ea7de..07e5a64 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -63,7 +63,6 @@ enum {
 	OMAP_I2C_BUF_REG,
 	OMAP_I2C_CNT_REG,
 	OMAP_I2C_DATA_REG,
-	OMAP_I2C_SYSC_REG,
 	OMAP_I2C_CON_REG,
 	OMAP_I2C_OA_REG,
 	OMAP_I2C_SA_REG,
@@ -214,7 +213,6 @@ const static u8 reg_map_ip_v1[] = {
 	[OMAP_I2C_BUF_REG] = 0x05,
 	[OMAP_I2C_CNT_REG] = 0x06,
 	[OMAP_I2C_DATA_REG] = 0x07,
-	[OMAP_I2C_SYSC_REG] = 0x08,
 	[OMAP_I2C_CON_REG] = 0x09,
 	[OMAP_I2C_OA_REG] = 0x0a,
 	[OMAP_I2C_SA_REG] = 0x0b,
@@ -235,7 +233,6 @@ const static u8 reg_map_ip_v2[] = {
 	[OMAP_I2C_BUF_REG] = 0x94,
 	[OMAP_I2C_CNT_REG] = 0x98,
 	[OMAP_I2C_DATA_REG] = 0x9c,
-	[OMAP_I2C_SYSC_REG] = 0x20,
 	[OMAP_I2C_CON_REG] = 0xa4,
 	[OMAP_I2C_OA_REG] = 0xa8,
 	[OMAP_I2C_SA_REG] = 0xac,
@@ -282,7 +279,6 @@ static void omap_i2c_unidle(struct omap_i2c_dev *dev)
 		omap_i2c_write_reg(dev, OMAP_I2C_SCLL_REG, dev->scllstate);
 		omap_i2c_write_reg(dev, OMAP_I2C_SCLH_REG, dev->sclhstate);
 		omap_i2c_write_reg(dev, OMAP_I2C_BUF_REG, dev->bufstate);
-		omap_i2c_write_reg(dev, OMAP_I2C_SYSC_REG, dev->syscstate);
 		omap_i2c_write_reg(dev, OMAP_I2C_WE_REG, dev->westate);
 		omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, OMAP_I2C_CON_EN);
 	}
-- 
1.7.1
