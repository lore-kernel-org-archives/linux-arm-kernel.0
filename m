From: linus.walleij@stericsson.com (Linus Walleij)
Date: Tue, 8 Feb 2011 13:03:55 +0100
Subject: [PATCH 4/4] spi/pl022: minor kerneldoc updates
Message-ID: <1297166635-5205-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/spi/amba-pl022.c |   25 ++++++++++++++++---------
 1 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/amba-pl022.c b/drivers/spi/amba-pl022.c
index 2b591f0..4cd05cc 100644
--- a/drivers/spi/amba-pl022.c
+++ b/drivers/spi/amba-pl022.c
@@ -329,15 +329,16 @@ struct vendor_data {
 /**
  * struct pl022 - This is the private SSP driver data structure
  * @adev: AMBA device model hookup
- * @vendor: Vendor data for the IP block
- * @phybase: The physical memory where the SSP device resides
- * @virtbase: The virtual memory where the SSP is mapped
+ * @vendor: vendor data for the IP block
+ * @phybase: the physical memory where the SSP device resides
+ * @virtbase: the virtual memory where the SSP is mapped
+ * @clk: outgoing clock "SPICLK" for the SPI bus
  * @master: SPI framework hookup
  * @master_info: controller-specific data from machine setup
- * @regs: SSP controller register's virtual address
- * @pump_messages: Work struct for scheduling work to the workqueue
- * @lock: spinlock to syncronise access to driver data
  * @workqueue: a workqueue on which any spi_message request is queued
+ * @pump_messages: work struct for scheduling work to the workqueue
+ * @queue_lock: spinlock to syncronise access to message queue
+ * @queue: message queue
  * @busy: workqueue is busy
  * @running: workqueue is running
  * @pump_transfers: Tasklet used in Interrupt Transfer mode
@@ -348,8 +349,14 @@ struct vendor_data {
  * @tx_end: end position in TX buffer to be read
  * @rx: current position in RX buffer to be written
  * @rx_end: end position in RX buffer to be written
- * @readingtype: the type of read currently going on
- * @writingtype: the type or write currently going on
+ * @read: the type of read currently going on
+ * @write: the type of write currently going on
+ * @exp_fifo_level: expected FIFO level
+ * @dma_rx_channel: optional channel for RX DMA
+ * @dma_tx_channel: optional channel for TX DMA
+ * @sgt_rx: scattertable for the RX transfer
+ * @sgt_tx: scattertable for the TX transfer
+ * @dummypage: a dummy page used for driving data on the bus with DMA
  */
 struct pl022 {
 	struct amba_device		*adev;
@@ -397,8 +404,8 @@ struct pl022 {
  * @cpsr: Value of Clock prescale register
  * @n_bytes: how many bytes(power of 2) reqd for a given data width of client
  * @enable_dma: Whether to enable DMA or not
- * @write: function ptr to be used to write when doing xfer for this chip
  * @read: function ptr to be used to read when doing xfer for this chip
+ * @write: function ptr to be used to write when doing xfer for this chip
  * @cs_control: chip select callback provided by chip
  * @xfer_type: polling/interrupt/DMA
  *
-- 
1.7.3.2
