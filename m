From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Fri,  8 Apr 2011 20:15:39 +0800
Subject: [PATCH 2/7] ARM: pxa: always clear LPM bits for PXA168 MFPR
In-Reply-To: <1302264944-2759-1-git-send-email-haojian.zhuang@marvell.com>
References: <2011040801>
	<1302264944-2759-1-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <1302264944-2759-2-git-send-email-haojian.zhuang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Bit[9:7] should always be zero in PXA168.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 arch/arm/mach-mmp/include/mach/mfp-pxa168.h |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mmp/include/mach/mfp-pxa168.h b/arch/arm/mach-mmp/include/mach/mfp-pxa168.h
index 4621067..713be15 100644
--- a/arch/arm/mach-mmp/include/mach/mfp-pxa168.h
+++ b/arch/arm/mach-mmp/include/mach/mfp-pxa168.h
@@ -8,6 +8,15 @@
 #define MFP_DRIVE_MEDIUM	(0x2 << 13)
 #define MFP_DRIVE_FAST		(0x3 << 13)
 
+#undef MFP_CFG
+#undef MFP_CFG_DRV
+
+#define MFP_CFG(pin, af)		\
+	(MFP_LPM_INPUT | MFP_PIN(MFP_PIN_##pin) | MFP_##af | MFP_DRIVE_MEDIUM)
+
+#define MFP_CFG_DRV(pin, af, drv)	\
+	(MFP_LPM_INPUT | MFP_PIN(MFP_PIN_##pin) | MFP_##af | MFP_DRIVE_##drv)
+
 /* GPIO */
 #define GPIO0_GPIO		MFP_CFG(GPIO0, AF5)
 #define GPIO1_GPIO		MFP_CFG(GPIO1, AF5)
-- 
1.5.6.5
