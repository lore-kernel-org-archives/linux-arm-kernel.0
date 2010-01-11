From: eric.y.miao@gmail.com (Eric Miao)
Date: Mon, 11 Jan 2010 22:04:14 +0800
Subject: [PATCH 06/16] [ARM] pxa: fix the incorrect naming of AC97 reset pin
	config for pxa26x
In-Reply-To: <1263218664-11546-1-git-send-email-eric.y.miao@gmail.com>
References: <1263218664-11546-1-git-send-email-eric.y.miao@gmail.com>
Message-ID: <1263218664-11546-7-git-send-email-eric.y.miao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

GPIO89_AC97_nRESET is really a PXA26x specific option and was
incorrectly named.

Signed-off-by: Eric Miao <eric.y.miao@gmail.com>
---
 arch/arm/mach-pxa/include/mach/mfp-pxa25x.h |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-pxa/include/mach/mfp-pxa25x.h b/arch/arm/mach-pxa/include/mach/mfp-pxa25x.h
index 8910a3b..cafadc3 100644
--- a/arch/arm/mach-pxa/include/mach/mfp-pxa25x.h
+++ b/arch/arm/mach-pxa/include/mach/mfp-pxa25x.h
@@ -169,7 +169,6 @@
 #define GPIO86_nSDCS2		MFP_CFG_OUT(GPIO86, AF0, DRIVE_HIGH)
 #define GPIO87_nSDCS3		MFP_CFG_OUT(GPIO87, AF0, DRIVE_HIGH)
 #define GPIO88_RDnWR		MFP_CFG_OUT(GPIO88, AF0, DRIVE_HIGH)
-#define GPIO89_nACRESET		MFP_CFG_OUT(GPIO89, AF0, DRIVE_HIGH)
 
 /* USB */
 #define GPIO9_USB_RCV		MFP_CFG_IN(GPIO9, AF1)
@@ -186,7 +185,10 @@
 #define GPIO30_ASSP_TXD		MFP_CFG_OUT(GPIO30, AF3, DRIVE_LOW)
 #define GPIO31_ASSP_SFRM_IN	MFP_CFG_IN(GPIO31, AF1)
 #define GPIO31_ASSP_SFRM_OUT	MFP_CFG_OUT(GPIO31, AF3, DRIVE_LOW)
-#endif
+
+/* AC97 */
+#define GPIO89_AC97_nRESET	MFP_CFG_OUT(GPIO89, AF0, DRIVE_HIGH)
+#endif	/* CONFIG_CPU_PXA26x */
 
 /* commonly used pin configurations */
 #define GPIOxx_LCD_16BPP	\
-- 
1.6.3.3
