From: a.kesavan@samsung.com (Abhilash Kesavan)
Date: Fri, 12 Aug 2011 15:56:14 +0530
Subject: [PATCH 2/2] ARM: S5PV210: Remove unnecessary symbol for PM
In-Reply-To: <1313144774-30607-1-git-send-email-a.kesavan@samsung.com>
References: <1313144774-30607-1-git-send-email-a.kesavan@samsung.com>
Message-ID: <1313144774-30607-3-git-send-email-a.kesavan@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make the S5PV210 power management code depend directly on PM rather
than another S5PV210 specific symbol.

Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
---
 arch/arm/mach-s5pv210/Kconfig  |    6 ------
 arch/arm/mach-s5pv210/Makefile |    2 +-
 2 files changed, 1 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-s5pv210/Kconfig b/arch/arm/mach-s5pv210/Kconfig
index 69dd87c..aaeb44a 100644
--- a/arch/arm/mach-s5pv210/Kconfig
+++ b/arch/arm/mach-s5pv210/Kconfig
@@ -14,7 +14,6 @@ config CPU_S5PV210
 	select S3C_PL330_DMA
 	select S5P_EXT_INT
 	select S5P_HRT
-	select S5PV210_PM if PM
 	help
 	  Enable S5PV210 CPU support
 
@@ -169,9 +168,4 @@ config MACH_TORBRECK
 
 endmenu
 
-config S5PV210_PM
-	bool
-	help
-	  Power Management code common to S5PV210
-
 endif
diff --git a/arch/arm/mach-s5pv210/Makefile b/arch/arm/mach-s5pv210/Makefile
index 599a3c0..ef7e466 100644
--- a/arch/arm/mach-s5pv210/Makefile
+++ b/arch/arm/mach-s5pv210/Makefile
@@ -14,7 +14,7 @@ obj-				:=
 
 obj-$(CONFIG_CPU_S5PV210)	+= cpu.o init.o clock.o dma.o
 obj-$(CONFIG_CPU_S5PV210)	+= setup-i2c0.o
-obj-$(CONFIG_S5PV210_PM)	+= pm.o sleep.o
+obj-$(CONFIG_PM)		+= pm.o sleep.o
 
 # machine support
 
-- 
1.7.4.1
