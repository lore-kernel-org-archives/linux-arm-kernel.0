From: manish.narani@xilinx.com (Manish Narani)
Date: Thu, 4 Oct 2018 21:05:21 +0530
Subject: [PATCH v8 03/10] edac: synopsys: Modify the comments in the driver
In-Reply-To: <1538667328-9465-1-git-send-email-manish.narani@xilinx.com>
References: <1538667328-9465-1-git-send-email-manish.narani@xilinx.com>
Message-ID: <1538667328-9465-4-git-send-email-manish.narani@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are some comments which can be updated for better readability of
the driver. Update abbreviations to capital letters in the comments.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 drivers/edac/synopsys_edac.c | 98 ++++++++++++++++++++++----------------------
 1 file changed, 48 insertions(+), 50 deletions(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index abb5de8..7db5928 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -96,12 +96,12 @@
 #define SCRUB_MODE_SECDED		0x4
 
 /**
- * struct ecc_error_info - ECC error log information
- * @row:	Row number
- * @col:	Column number
- * @bank:	Bank number
- * @bitpos:	Bit position
- * @data:	Data causing the error
+ * struct ecc_error_info - ECC error log information.
+ * @row:	Row number.
+ * @col:	Column number.
+ * @bank:	Bank number.
+ * @bitpos:	Bit position.
+ * @data:	Data causing the error.
  */
 struct ecc_error_info {
 	u32 row;
@@ -112,11 +112,11 @@ struct ecc_error_info {
 };
 
 /**
- * struct synps_ecc_status - ECC status information to report
- * @ce_cnt:	Correctable error count
- * @ue_cnt:	Uncorrectable error count
- * @ceinfo:	Correctable error log information
- * @ueinfo:	Uncorrectable error log information
+ * struct synps_ecc_status - ECC status information to report.
+ * @ce_cnt:	Correctable error count.
+ * @ue_cnt:	Uncorrectable error count.
+ * @ceinfo:	Correctable error log information.
+ * @ueinfo:	Uncorrectable error log information.
  */
 struct synps_ecc_status {
 	u32 ce_cnt;
@@ -126,12 +126,12 @@ struct synps_ecc_status {
 };
 
 /**
- * struct synps_edac_priv - DDR memory controller private instance data
- * @baseaddr:	Base address of the DDR controller
- * @message:	Buffer for framing the event specific info
- * @stat:	ECC status information
- * @ce_cnt:	Correctable Error count
- * @ue_cnt:	Uncorrectable Error count
+ * struct synps_edac_priv - DDR memory controller private instance data.
+ * @baseaddr:	Base address of the DDR controller.
+ * @message:	Buffer for framing the event specific info.
+ * @stat:	ECC status information.
+ * @ce_cnt:	Correctable Error count.
+ * @ue_cnt:	Uncorrectable Error count.
  */
 struct synps_edac_priv {
 	void __iomem *baseaddr;
@@ -142,13 +142,11 @@ struct synps_edac_priv {
 };
 
 /**
- * edac_geterror_info - Get the current ecc error info
- * @base:	Pointer to the base address of the ddr memory controller
- * @p:		Pointer to the synopsys ecc status structure
+ * edac_geterror_info - Get the current ECC error info.
+ * @base:	Base address of the DDR memory controller.
+ * @p:		Synopsys ECC status structure.
  *
- * Determines there is any ecc error or not
- *
- * Return: one if there is no error otherwise returns zero
+ * Return: one if there is no error otherwise returns zero.
  */
 static int edac_geterror_info(void __iomem *base,
 				    struct synps_ecc_status *p)
@@ -196,11 +194,11 @@ static int edac_geterror_info(void __iomem *base,
 }
 
 /**
- * edac_handle_error - Handle controller error types CE and UE
- * @mci:	Pointer to the edac memory controller instance
- * @p:		Pointer to the synopsys ecc status structure
+ * edac_handle_error - Handle controller error types CE and UE.
+ * @mci:	EDAC memory controller instance.
+ * @p:		Synopsys ECC status structure.
  *
- * Handles the controller ECC correctable and un correctable error.
+ * Handles the controller ECC correctable and un-correctable error.
  */
 static void edac_handle_error(struct mem_ctl_info *mci,
 				    struct synps_ecc_status *p)
@@ -232,10 +230,10 @@ static void edac_handle_error(struct mem_ctl_info *mci,
 }
 
 /**
- * edac_check - Check controller for ECC errors
- * @mci:	Pointer to the edac memory controller instance
+ * edac_check - Check controller for ECC errors.
+ * @mci:	EDAC memory controller instance.
  *
- * Used to check and post ECC errors. Called by the polling thread
+ * Used to check and post ECC errors. Called by the polling thread.
  */
 static void edac_check(struct mem_ctl_info *mci)
 {
@@ -255,8 +253,8 @@ static void edac_check(struct mem_ctl_info *mci)
 }
 
 /**
- * edac_get_dtype - Return the controller memory width
- * @base:	Pointer to the ddr memory controller base address
+ * edac_get_dtype - Return the controller memory width.
+ * @base:	DDR memory controller base address.
  *
  * Get the EDAC device type width appropriate for the current controller
  * configuration.
@@ -286,12 +284,12 @@ static enum dev_type edac_get_dtype(const void __iomem *base)
 }
 
 /**
- * edac_get_eccstate - Return the controller ecc enable/disable status
- * @base:	Pointer to the ddr memory controller base address
+ * edac_get_eccstate - Return the controller ECC enable/disable status.
+ * @base:	DDR memory controller base address.
  *
- * Get the ECC enable/disable status for the controller
+ * Get the ECC enable/disable status for the controller.
  *
- * Return: a ecc status boolean i.e true/false - enabled/disabled.
+ * Return: a ECC status boolean i.e true/false - enabled/disabled.
  */
 static bool edac_get_eccstate(void __iomem *base)
 {
@@ -311,9 +309,9 @@ static bool edac_get_eccstate(void __iomem *base)
 }
 
 /**
- * edac_get_memsize - reads the size of the attached memory device
+ * edac_get_memsize - reads the size of the attached memory device.
  *
- * Return: the memory size in bytes
+ * Return: the memory size in bytes.
  */
 static u32 edac_get_memsize(void)
 {
@@ -325,8 +323,8 @@ static u32 edac_get_memsize(void)
 }
 
 /**
- * edac_get_mtype - Returns controller memory type
- * @base:	pointer to the synopsys ecc status structure
+ * edac_get_mtype - Returns controller memory type.
+ * @base:	Synopsys ECC status structure.
  *
  * Get the EDAC memory type appropriate for the current controller
  * configuration.
@@ -349,11 +347,11 @@ static enum mem_type edac_get_mtype(const void __iomem *base)
 }
 
 /**
- * edac_init_csrows - Initialize the cs row data
- * @mci:	Pointer to the edac memory controller instance
+ * edac_init_csrows - Initialize the cs row data.
+ * @mci:	EDAC memory controller instance.
  *
  * Initializes the chip select rows associated with the EDAC memory
- * controller instance
+ * controller instance.
  *
  * Return: Unconditionally 0.
  */
@@ -383,9 +381,9 @@ static int edac_init_csrows(struct mem_ctl_info *mci)
 }
 
 /**
- * edac_mc_init - Initialize driver instance
- * @mci:	Pointer to the edac memory controller instance
- * @pdev:	Pointer to the platform_device struct
+ * edac_mc_init - Initialize driver instance.
+ * @mci:	EDAC memory controller instance.
+ * @pdev:	platform_device struct.
  *
  * Performs initialization of the EDAC memory controller instance and
  * related driver-private data associated with the memory controller the
@@ -424,8 +422,8 @@ static int edac_mc_init(struct mem_ctl_info *mci,
 }
 
 /**
- * synps_edac_mc_probe - Check controller and bind driver
- * @pdev:	Pointer to the platform_device struct
+ * synps_edac_mc_probe - Check controller and bind driver.
+ * @pdev:	platform_device struct.
  *
  * Probes a specific controller instance for binding with the driver.
  *
@@ -496,8 +494,8 @@ static int synps_edac_mc_probe(struct platform_device *pdev)
 }
 
 /**
- * synps_edac_mc_remove - Unbind driver from controller
- * @pdev:	Pointer to the platform_device struct
+ * synps_edac_mc_remove - Unbind driver from controller.
+ * @pdev:	Platform_device struct.
  *
  * Return: Unconditionally 0
  */
-- 
2.1.1
