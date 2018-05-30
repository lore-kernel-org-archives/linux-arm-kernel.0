From: Anson.Huang@nxp.com (Anson Huang)
Date: Wed, 30 May 2018 09:30:42 +0800
Subject: [PATCH V2] soc: imx: gpcv2: correct PGC offset
Message-ID: <1527643842-17643-1-git-send-email-Anson.Huang@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Correct MIPI/PCIe/USB_HSIC's PGC offset based on
design RTL, the values in the Reference Manual
(Rev. 1, 01/2018 and the older ones) are incorrect.

The correct offset values should be as below:

0x800 ~ 0x83F: PGC for core0 of A7 platform;
0x840 ~ 0x87F: PGC for core1 of A7 platform;
0x880 ~ 0x8BF: PGC for SCU of A7 platform;
0xA00 ~ 0xA3F: PGC for fastmix/megamix;
0xC00 ~ 0xC3F: PGC for MIPI PHY;
0xC40 ~ 0xC7F: PGC for PCIe_PHY;
0xC80 ~ 0xCBF: PGC for USB OTG1 PHY;
0xCC0 ~ 0xCFF: PGC for USB OTG2 PHY;
0xD00 ~ 0xD3F: PGC for USB HSIC PHY;

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Acked-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
changes since V1:
	add comment in code to make it more readable;
	improve the commit message.
 drivers/soc/imx/gpcv2.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c
index f4e3bd4..6ef18cf 100644
--- a/drivers/soc/imx/gpcv2.c
+++ b/drivers/soc/imx/gpcv2.c
@@ -39,10 +39,15 @@
 
 #define GPC_M4_PU_PDN_FLG		0x1bc
 
-
-#define PGC_MIPI			4
-#define PGC_PCIE			5
-#define PGC_USB_HSIC			8
+/*
+ * The PGC offset values in Reference Manual
+ * (Rev. 1, 01/2018 and the older ones) GPC chapter's
+ * GPC_PGC memory map are incorrect, below offset
+ * values are from design RTL.
+ */
+#define PGC_MIPI			16
+#define PGC_PCIE			17
+#define PGC_USB_HSIC			20
 #define GPC_PGC_CTRL(n)			(0x800 + (n) * 0x40)
 #define GPC_PGC_SR(n)			(GPC_PGC_CTRL(n) + 0xc)
 
-- 
2.7.4
