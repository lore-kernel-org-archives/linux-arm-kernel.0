From: michal.simek@xilinx.com (Michal Simek)
Date: Fri, 28 Jul 2017 15:17:25 +0200
Subject: [PATCH 1/2] char: xilinx_hwicap: Fix kernel doc warnings
Message-ID: <6da0afe2afd2c7a21d16da9a9c7acab09385ae2c.1501247838.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nava kishore Manne <nava.manne@xilinx.com>

This patch fixes the kernel doc warnings in the driver.

Signed-off-by: Nava kishore Manne <navam@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 drivers/char/xilinx_hwicap/xilinx_hwicap.c | 4 ++++
 drivers/char/xilinx_hwicap/xilinx_hwicap.h | 7 +++++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/char/xilinx_hwicap/xilinx_hwicap.c b/drivers/char/xilinx_hwicap/xilinx_hwicap.c
index 3e6b23c3453c..5e5c8ee23a5b 100644
--- a/drivers/char/xilinx_hwicap/xilinx_hwicap.c
+++ b/drivers/char/xilinx_hwicap/xilinx_hwicap.c
@@ -222,6 +222,8 @@
  * hwicap_command_desync - Send a DESYNC command to the ICAP port.
  * @drvdata: a pointer to the drvdata.
  *
+ * Returns: '0' on success and failure value on error
+ *
  * This command desynchronizes the ICAP After this command, a
  * bitstream containing a NULL packet, followed by a SYNCH packet is
  * required before the ICAP will recognize commands.
@@ -255,6 +257,8 @@ static int hwicap_command_desync(struct hwicap_drvdata *drvdata)
  * 		Examples:  XHI_IDCODE, XHI_FLR.
  * @reg_data: returns the value of the register.
  *
+ * Returns: '0' on success and failure value on error
+ *
  * Sends a query packet to the ICAP and then receives the response.
  * The icap is left in Synched state.
  */
diff --git a/drivers/char/xilinx_hwicap/xilinx_hwicap.h b/drivers/char/xilinx_hwicap/xilinx_hwicap.h
index 38b145eaf24d..1f687a71e36e 100644
--- a/drivers/char/xilinx_hwicap/xilinx_hwicap.h
+++ b/drivers/char/xilinx_hwicap/xilinx_hwicap.h
@@ -193,11 +193,12 @@ struct config_registers {
  * hwicap_type_1_read - Generates a Type 1 read packet header.
  * @reg: is the address of the register to be read back.
  *
+ * Return:
  * Generates a Type 1 read packet header, which is used to indirectly
  * read registers in the configuration logic.  This packet must then
  * be sent through the icap device, and a return packet received with
  * the information.
- **/
+ */
 static inline u32 hwicap_type_1_read(u32 reg)
 {
 	return (XHI_TYPE_1 << XHI_TYPE_SHIFT) |
@@ -208,7 +209,9 @@ static inline u32 hwicap_type_1_read(u32 reg)
 /**
  * hwicap_type_1_write - Generates a Type 1 write packet header
  * @reg: is the address of the register to be read back.
- **/
+ *
+ * Return: Type 1 write packet header
+ */
 static inline u32 hwicap_type_1_write(u32 reg)
 {
 	return (XHI_TYPE_1 << XHI_TYPE_SHIFT) |
-- 
1.9.1
