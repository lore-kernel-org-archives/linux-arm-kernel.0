From: axel.lin@gmail.com (Axel Lin)
Date: Fri, 13 Aug 2010 11:39:07 +0800
Subject: [PATCH] pxa: fix CI_HSYNC and CI_VSYNC MFP defines
Message-ID: <1281670747.13407.2.camel@mola>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to PXA3xx Processor Family Developer Manuall Vol1. section
"Pin Descriptions and Control", PXA30x and PXA31x Processor Alternate Function
Table shows the Alt FN 0 for GPIO51 is CI_HSYNC and for GPIO52 is CI_VSYNC.
This patch fixes the MFP defines and also corrects the order of MFD defines.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 arch/arm/mach-pxa/include/mach/mfp-pxa300.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-pxa/include/mach/mfp-pxa300.h b/arch/arm/mach-pxa/include/mach/mfp-pxa300.h
index 7139e0d..4e12870 100644
--- a/arch/arm/mach-pxa/include/mach/mfp-pxa300.h
+++ b/arch/arm/mach-pxa/include/mach/mfp-pxa300.h
@@ -71,10 +71,10 @@
 #define GPIO46_CI_DD_7		MFP_CFG_DRV(GPIO46, AF0, DS04X)
 #define GPIO47_CI_DD_8		MFP_CFG_DRV(GPIO47, AF1, DS04X)
 #define GPIO48_CI_DD_9		MFP_CFG_DRV(GPIO48, AF1, DS04X)
-#define GPIO52_CI_HSYNC		MFP_CFG_DRV(GPIO52, AF0, DS04X)
-#define GPIO51_CI_VSYNC		MFP_CFG_DRV(GPIO51, AF0, DS04X)
 #define GPIO49_CI_MCLK		MFP_CFG_DRV(GPIO49, AF0, DS04X)
 #define GPIO50_CI_PCLK		MFP_CFG_DRV(GPIO50, AF0, DS04X)
+#define GPIO51_CI_HSYNC		MFP_CFG_DRV(GPIO51, AF0, DS04X)
+#define GPIO52_CI_VSYNC		MFP_CFG_DRV(GPIO52, AF0, DS04X)
 
 /* KEYPAD */
 #define GPIO3_KP_DKIN_6		MFP_CFG_LPM(GPIO3,   AF2, FLOAT)
-- 
1.7.2
