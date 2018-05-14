From: peda@axentia.se (Peter Rosin)
Date: Mon, 14 May 2018 16:53:16 +0200
Subject: [PATCH 07/21] i2c: efm32: make use of i2c_8bit_addr_from_msg
In-Reply-To: <20180514145330.4857-1-peda@axentia.se>
References: <20180514145330.4857-1-peda@axentia.se>
Message-ID: <20180514145330.4857-8-peda@axentia.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Because it looks neater.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/i2c/busses/i2c-efm32.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-efm32.c b/drivers/i2c/busses/i2c-efm32.c
index aa336ba89aa3..5f2bab878b2c 100644
--- a/drivers/i2c/busses/i2c-efm32.c
+++ b/drivers/i2c/busses/i2c-efm32.c
@@ -144,8 +144,7 @@ static void efm32_i2c_send_next_msg(struct efm32_i2c_ddata *ddata)
 	struct i2c_msg *cur_msg = &ddata->msgs[ddata->current_msg];
 
 	efm32_i2c_write32(ddata, REG_CMD, REG_CMD_START);
-	efm32_i2c_write32(ddata, REG_TXDATA, cur_msg->addr << 1 |
-			(cur_msg->flags & I2C_M_RD ? 1 : 0));
+	efm32_i2c_write32(ddata, REG_TXDATA, i2c_8bit_addr_from_msg(cur_msg));
 }
 
 static void efm32_i2c_send_next_byte(struct efm32_i2c_ddata *ddata)
-- 
2.11.0
