From: eric.y.miao@gmail.com (Eric Miao)
Date: Mon, 9 Nov 2009 14:37:59 +0800
Subject: [PATCH 3/3] [ARM] pxa: make CPU_PXA* to be selectable hidden options
Message-ID: <mailman.3.1257749500.2170.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CONFIG_CPU_PXA{300,310,320,930,935,950} are really platform dependent
and should be made into selectable hidden options.

Signed-off-by: Eric Miao <eric.y.miao@gmail.com>
---
 arch/arm/mach-pxa/Kconfig |   65 +++++++++++++++++++++++++--------------------
 1 files changed, 36 insertions(+), 29 deletions(-)

diff --git a/arch/arm/mach-pxa/Kconfig b/arch/arm/mach-pxa/Kconfig
index 4bd0f87..20e645a 100644
--- a/arch/arm/mach-pxa/Kconfig
+++ b/arch/arm/mach-pxa/Kconfig
@@ -2,35 +2,6 @@ if ARCH_PXA

 menu "Intel PXA2xx/PXA3xx Implementations"

-if PXA3xx
-
-menu "Supported PXA3xx Processor Variants"
-
-config CPU_PXA300
-	bool "PXA300 (codename Monahans-L)"
-
-config CPU_PXA310
-	bool "PXA310 (codename Monahans-LV)"
-	select CPU_PXA300
-
-config CPU_PXA320
-	bool "PXA320 (codename Monahans-P)"
-
-config CPU_PXA930
-	bool "PXA930 (codename Tavor-P)"
-
-config CPU_PXA935
-	bool "PXA935 (codename Tavor-P65)"
-	select CPU_PXA930
-
-config CPU_PXA950
-	bool "PXA950 (codename Tavor-PV2)"
-	select CPU_PXA930
-
-endmenu
-
-endif
-
 comment "Intel/Marvell Dev Platforms (sorted by hardware release time)"

 config ARCH_LUBBOCK
@@ -585,6 +556,42 @@ config PXA3xx
 	help
 	  Select code specific to PXA3xx variants

+config CPU_PXA300
+	bool
+	select PXA3xx
+	help
+	  PXA300 (codename Monahans-L)
+
+config CPU_PXA310
+	bool
+	select CPU_PXA300
+	help
+	  PXA310 (codename Monahans-LV)
+
+config CPU_PXA320
+	bool
+	select PXA3xx
+	help
+	  PXA320 (codename Monahans-P)
+
+config CPU_PXA930
+	bool
+	select PXA3xx
+	help
+	  PXA930 (codename Tavor-P)
+
+config CPU_PXA935
+	bool
+	select CPU_PXA930
+	help
+	  PXA935 (codename Tavor-P65)
+
+config CPU_PXA950
+	bool
+	select CPU_PXA930
+	help
+	  PXA950 (codename Tavor-PV2)
+
 config PXA_SHARP_C7xx
 	bool
 	select PXA_SSP
-- 
1.6.3.3
