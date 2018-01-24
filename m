From: yixun.lan@amlogic.com (Yixun Lan)
Date: Wed, 24 Jan 2018 15:05:14 +0800
Subject: [PATCH] i2c: meson: update doc description to fix build warnings
Message-ID: <20180124070514.183119-1-yixun.lan@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add description for 'data' parameter and drop unused 'irq' memeber.

Here is the warnings:
drivers/i2c/busses/i2c-meson.c:103: warning: No description found for
parameter 'data'
drivers/i2c/busses/i2c-meson.c:103: warning: Excess struct member 'irq'
description in 'meson_i2c'

Suggested-by: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
---
 drivers/i2c/busses/i2c-meson.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-meson.c b/drivers/i2c/busses/i2c-meson.c
index 37c4aa76f37a..90f5d0407d73 100644
--- a/drivers/i2c/busses/i2c-meson.c
+++ b/drivers/i2c/busses/i2c-meson.c
@@ -69,7 +69,6 @@ struct meson_i2c_data {
  * @dev:	Pointer to device structure
  * @regs:	Base address of the device memory mapped registers
  * @clk:	Pointer to clock structure
- * @irq:	IRQ number
  * @msg:	Pointer to the current I2C message
  * @state:	Current state in the driver state machine
  * @last:	Flag set for the last message in the transfer
@@ -80,6 +79,7 @@ struct meson_i2c_data {
  * @done:	Completion used to wait for transfer termination
  * @tokens:	Sequence of tokens to be written to the device
  * @num_tokens:	Number of tokens
+ * @data:	Pointer to the controlller's platform data
  */
 struct meson_i2c {
 	struct i2c_adapter	adap;
-- 
2.15.1
