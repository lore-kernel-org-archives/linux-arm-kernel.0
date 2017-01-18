From: jerry.huang@nxp.com (Changming Huang)
Date: Wed, 18 Jan 2017 16:12:16 +0800
Subject: [PATCH v4 1/3] USB3/DWC3: Add definition for global soc bus
 configuration register
Message-ID: <1484727138-3264-1-git-send-email-jerry.huang@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the macro definition for global soc bus configuration register 0/1

Signed-off-by: Changming Huang <jerry.huang@nxp.com>
---
Changes in v4:
  - no change
Changes in v3:
  - no change
Changes in v2:
  - split the patch
  - add more macro definition for soc bus configuration register

 drivers/usb/dwc3/core.h |   26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index de5a857..065aa6f 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -161,6 +161,32 @@
 
 /* Bit fields */
 
+/* Global SoC Bus Configuration Register 0 */
+#define AXI3_CACHE_TYPE_AW		0x8 /* write allocate */
+#define AXI3_CACHE_TYPE_AR		0x4 /* read allocate */
+#define AXI3_CACHE_TYPE_SNP		0x2 /* cacheable */
+#define AXI3_CACHE_TYPE_BUF		0x1 /* bufferable */
+#define DWC3_GSBUSCFG0_DATARD_SHIFT	28
+#define DWC3_GSBUSCFG0_DESCRD_SHIFT	24
+#define DWC3_GSBUSCFG0_DATAWR_SHIFT	20
+#define DWC3_GSBUSCFG0_DESCWR_SHIFT	16
+#define DWC3_GSBUSCFG0_SNP_MASK		0xffff0000
+#define DWC3_GSBUSCFG0_DATABIGEND	(1 << 11)
+#define DWC3_GSBUSCFG0_DESCBIGEND	(1 << 10)
+#define DWC3_GSBUSCFG0_INCR256BRSTENA	(1 << 7) /* INCR256 burst */
+#define DWC3_GSBUSCFG0_INCR128BRSTENA	(1 << 6) /* INCR128 burst */
+#define DWC3_GSBUSCFG0_INCR64BRSTENA	(1 << 5) /* INCR64 burst */
+#define DWC3_GSBUSCFG0_INCR32BRSTENA	(1 << 4) /* INCR32 burst */
+#define DWC3_GSBUSCFG0_INCR16BRSTENA	(1 << 3) /* INCR16 burst */
+#define DWC3_GSBUSCFG0_INCR8BRSTENA	(1 << 2) /* INCR8 burst */
+#define DWC3_GSBUSCFG0_INCR4BRSTENA	(1 << 1) /* INCR4 burst */
+#define DWC3_GSBUSCFG0_INCRBRSTENA	(1 << 0) /* undefined length enable */
+#define DWC3_GSBUSCFG0_INCRBRST_MASK	0xff
+
+/* Global SoC Bus Configuration Register 1 */
+#define DWC3_GSBUSCFG1_1KPAGEENA	(1 << 12) /* 1K page boundary enable */
+#define DWC3_GSBUSCFG1_PTRANSLIMIT_MASK	0xf00
+
 /* Global Debug Queue/FIFO Space Available Register */
 #define DWC3_GDBGFIFOSPACE_NUM(n)	((n) & 0x1f)
 #define DWC3_GDBGFIFOSPACE_TYPE(n)	(((n) << 5) & 0x1e0)
-- 
1.7.9.5
