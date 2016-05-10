From: david.wu@rock-chips.com (David Wu)
Date: Wed, 11 May 2016 03:24:05 +0800
Subject: [PATCH v8 1/8] i2c: rk3x: add documentation to fields in "struct
 rk3x_i2c"
In-Reply-To: <1462908252-27016-1-git-send-email-david.wu@rock-chips.com>
References: <1462908252-27016-1-git-send-email-david.wu@rock-chips.com>
Message-ID: <1462908252-27016-2-git-send-email-david.wu@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: David Wu <david.wu@rock-chips.com>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---
Change in v8:
- none

 drivers/i2c/busses/i2c-rk3x.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-rk3x.c b/drivers/i2c/busses/i2c-rk3x.c
index 80bed02..7e45d51 100644
--- a/drivers/i2c/busses/i2c-rk3x.c
+++ b/drivers/i2c/busses/i2c-rk3x.c
@@ -90,6 +90,26 @@ struct rk3x_i2c_soc_data {
 	int grf_offset;
 };
 
+/**
+ * struct rk3x_i2c - private data of the controller
+ * @adap: corresponding I2C adapter
+ * @dev: device for this controller
+ * @soc_data: related soc data struct
+ * @regs: virtual memory area
+ * @clk: clock of i2c bus
+ * @clk_rate_nb: i2c clk rate change notify
+ * @t: I2C known timing information
+ * @lock: spinlock for the i2c bus
+ * @wait: the waitqueue to wait for i2c transfer
+ * @busy: the condition for the event to wait for
+ * @msg: current i2c message
+ * @addr: addr of i2c slave device
+ * @mode: mode of i2c transfer
+ * @is_last_msg: flag determines whether it is the last msg in this transfer
+ * @state: state of i2c transfer
+ * @processed: byte length which has been send or received
+ * @error: error code for i2c transfer
+ */
 struct rk3x_i2c {
 	struct i2c_adapter adap;
 	struct device *dev;
@@ -116,7 +136,7 @@ struct rk3x_i2c {
 
 	/* I2C state machine */
 	enum rk3x_i2c_state state;
-	unsigned int processed; /* sent/received bytes */
+	unsigned int processed;
 	int error;
 };
 
-- 
1.9.1
