From: pierre-yves.mordret@st.com (Pierre-Yves MORDRET)
Date: Fri, 11 May 2018 10:20:25 +0200
Subject: [PATCH] i2c: i2c-stm32f7: fix documentation typo
Message-ID: <1526026825-2996-1-git-send-email-pierre-yves.mordret@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some data structure members were either misspelled or missing.

Fixes: aeb068c572 ("i2c: i2c-stm32f7: add driver")
Fixes: 380b8a85e7 ("i2c: i2c-stm32f7: Add initial SMBus protocols support")
Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
---
  Version history:
    v1:
       * Initial
---
---
 drivers/i2c/busses/i2c-stm32f7.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-stm32f7.c b/drivers/i2c/busses/i2c-stm32f7.c
index 0f87449..62d023e 100644
--- a/drivers/i2c/busses/i2c-stm32f7.c
+++ b/drivers/i2c/busses/i2c-stm32f7.c
@@ -211,11 +211,12 @@ struct stm32f7_i2c_setup {
 
 /**
  * struct stm32f7_i2c_timings - private I2C output parameters
- * @prec: Prescaler value
+ * @node: List entry
+ * @presc: Prescaler value
  * @scldel: Data setup time
  * @sdadel: Data hold time
  * @sclh: SCL high period (master mode)
- * @sclh: SCL low period (master mode)
+ * @scll: SCL low period (master mode)
  */
 struct stm32f7_i2c_timings {
 	struct list_head node;
@@ -237,7 +238,7 @@ struct stm32f7_i2c_timings {
  * @size: type of SMBus protocol
  * @read_write: direction of SMBus protocol
  * SMBus block read and SMBus block write - block read process call protocols
- * @smbus_buff: buffer to be used for SMBus protocol transfer. It will
+ * @smbus_buf: buffer to be used for SMBus protocol transfer. It will
  * contain a maximum of 32 bytes of data + byte command + byte count + PEC
  * This buffer has to be 32-bit aligned to be compliant with memory address
  * register in DMA mode.
-- 
2.7.4
