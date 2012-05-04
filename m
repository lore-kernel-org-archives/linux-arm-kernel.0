From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Fri,  4 May 2012 20:30:19 +0800
Subject: [PATCH v2 2/9] ARM: mmp: append CONFIG_MACH_MMP2_DT
In-Reply-To: <1336134626-12262-1-git-send-email-haojian.zhuang@gmail.com>
References: <1336134626-12262-1-git-send-email-haojian.zhuang@gmail.com>
Message-ID: <1336134626-12262-3-git-send-email-haojian.zhuang@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Append CONFIG_MACH_MMP2_DT.

CONFIG_MACH_MMP_DT is used to ARMv5 DT support. CONFIG_MACH_MMP2_DT
is used to ARMv7 DT support. These two machine support can't be
selected at the same time.

Signed-off-by: Haojian Zhuang <haojian.zhuang@gmail.com>
---
 arch/arm/mach-mmp/Kconfig |   29 +++++++++++++++++++----------
 1 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-mmp/Kconfig b/arch/arm/mach-mmp/Kconfig
index 5a90b9a..ede7216 100644
--- a/arch/arm/mach-mmp/Kconfig
+++ b/arch/arm/mach-mmp/Kconfig
@@ -2,16 +2,6 @@ if ARCH_MMP
 
 menu "Marvell PXA168/910/MMP2 Implmentations"
 
-config MACH_MMP_DT
-	bool "Support MMP2 platforms from device tree"
-	select CPU_PXA168
-	select CPU_PXA910
-	select USE_OF
-	help
-	  Include support for Marvell MMP2 based platforms using
-	  the device tree. Needn't select any other machine while
-	  MACH_MMP_DT is enabled.
-
 config MACH_ASPENITE
 	bool "Marvell's PXA168 Aspenite Development Board"
 	select CPU_PXA168
@@ -94,6 +84,25 @@ config MACH_GPLUGD
 	  Say 'Y' here if you want to support the Marvell PXA168-based
 	  GuruPlug Display (gplugD) Board
 
+config MACH_MMP_DT
+	bool "Support MMP (ARMv5) platforms from device tree"
+	select CPU_PXA168
+	select CPU_PXA910
+	select USE_OF
+	help
+	  Include support for Marvell MMP2 based platforms using
+	  the device tree. Needn't select any other machine while
+	  MACH_MMP_DT is enabled.
+
+config MACH_MMP2_DT
+	bool "Support MMP2 (ARMv7) platforms from device tree"
+	depends on !CPU_MOHAWK
+	select CPU_MMP2
+	select USE_OF
+	help
+	  Include support for Marvell MMP2 based platforms using
+	  the device tree.
+
 endmenu
 
 config CPU_PXA168
-- 
1.7.5.4
