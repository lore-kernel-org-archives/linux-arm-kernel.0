From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 19 Aug 2013 12:38:33 +0100
Subject: [PATCH] mfd: dbx500: Remove any mention of the BML8580CLK
Message-ID: <1376912313-26512-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The platform which it pertains to is no longer supported and is actually
causing some confusion in the new common clock implementation. A recent
patch removed its use in the clock driver, let's take out the definitions
too.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/dbx500-prcmu-regs.h        |  1 -
 include/dt-bindings/mfd/dbx500-prcmu.h | 27 +++++++++++++--------------
 2 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/drivers/mfd/dbx500-prcmu-regs.h b/drivers/mfd/dbx500-prcmu-regs.h
index 4f6f0fa..7cc32a8 100644
--- a/drivers/mfd/dbx500-prcmu-regs.h
+++ b/drivers/mfd/dbx500-prcmu-regs.h
@@ -32,7 +32,6 @@
 #define PRCM_PER7CLK_MGT	(0x040)
 #define PRCM_LCDCLK_MGT		(0x044)
 #define PRCM_BMLCLK_MGT		(0x04C)
-#define PRCM_BML8580CLK_MGT	(0x108)
 #define PRCM_HSITXCLK_MGT	(0x050)
 #define PRCM_HSIRXCLK_MGT	(0x054)
 #define PRCM_HDMICLK_MGT	(0x058)
diff --git a/include/dt-bindings/mfd/dbx500-prcmu.h b/include/dt-bindings/mfd/dbx500-prcmu.h
index b7ee8c9..552a2d1 100644
--- a/include/dt-bindings/mfd/dbx500-prcmu.h
+++ b/include/dt-bindings/mfd/dbx500-prcmu.h
@@ -61,24 +61,23 @@
 #define PRCMU_PLLSOC1  	 	43
 #define PRCMU_ARMSS  	 	44
 #define PRCMU_PLLDDR  	 	45
-#define PRCMU_BML8580CLK        46
 
 /* DSI Clocks */
-#define PRCMU_PLLDSI  	 	47
-#define PRCMU_DSI0CLK 	  	48
-#define PRCMU_DSI1CLK  	 	49
-#define PRCMU_DSI0ESCCLK  	50
-#define PRCMU_DSI1ESCCLK  	51
-#define PRCMU_DSI2ESCCLK  	52
+#define PRCMU_PLLDSI  	 	46
+#define PRCMU_DSI0CLK 	  	47
+#define PRCMU_DSI1CLK  	 	48
+#define PRCMU_DSI0ESCCLK  	49
+#define PRCMU_DSI1ESCCLK  	50
+#define PRCMU_DSI2ESCCLK  	51
 
 /* LCD DSI PLL - Ux540 only */
-#define PRCMU_PLLDSI_LCD        53
-#define PRCMU_DSI0CLK_LCD       54
-#define PRCMU_DSI1CLK_LCD       55
-#define PRCMU_DSI0ESCCLK_LCD    56
-#define PRCMU_DSI1ESCCLK_LCD    57
-#define PRCMU_DSI2ESCCLK_LCD    58
+#define PRCMU_PLLDSI_LCD        52
+#define PRCMU_DSI0CLK_LCD       53
+#define PRCMU_DSI1CLK_LCD       54
+#define PRCMU_DSI0ESCCLK_LCD    55
+#define PRCMU_DSI1ESCCLK_LCD    56
+#define PRCMU_DSI2ESCCLK_LCD    57
 
-#define PRCMU_NUM_CLKS  	59
+#define PRCMU_NUM_CLKS  	58
 
 #endif
-- 
1.8.1.2
