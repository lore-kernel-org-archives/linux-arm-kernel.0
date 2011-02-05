From: john.linn@xilinx.com (John Linn)
Date: Sat, 5 Feb 2011 09:17:14 -0700
Subject: [PATCH 1/4] ARM: Xilinx: Adding Xilinx platform infrastructure support
In-Reply-To: <1296922637-24662-1-git-send-email-john.linn@xilinx.com>
References: <1296922637-24662-1-git-send-email-john.linn@xilinx.com>
Message-ID: <a3c93b4f-f943-48d8-bcc8-5b798a4d2e04@VA3EHSMHS015.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Minimum infrastructure to add the Xilinx machine and allow it to
be selected in the build.

Signed-off-by: John Linn <john.linn@xilinx.com>
---
 arch/arm/Kconfig    |   13 +++++++++++++
 arch/arm/Makefile   |    1 +
 arch/arm/mm/Kconfig |    4 ++--
 3 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 5cff165..3317671 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -875,6 +875,17 @@ config PLAT_SPEAR
 	help
 	  Support for ST's SPEAr platform (SPEAr3xx, SPEAr6xx and SPEAr13xx).
 
+config ARCH_XILINX
+	bool "Xilinx ARM Cortex A9 Based FPGA"
+	select CPU_V7
+	select GENERIC_TIME
+	select GENERIC_CLOCKEVENTS
+	select CLKDEV_LOOKUP
+	select ARM_GIC
+	select ARM_AMBA
+	help
+	  Support for Xilinx ARM Cortex A9 Based FPGA
+
 endchoice
 
 #
@@ -1009,6 +1020,8 @@ source "arch/arm/mach-vexpress/Kconfig"
 
 source "arch/arm/mach-w90x900/Kconfig"
 
+source "arch/arm/mach-xilinx/Kconfig"
+
 # Definitions to make life easier
 config ARCH_ACORN
 	bool
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index c22c1ad..4bad6ef 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -197,6 +197,7 @@ machine-$(CONFIG_MACH_SPEAR300)		:= spear3xx
 machine-$(CONFIG_MACH_SPEAR310)		:= spear3xx
 machine-$(CONFIG_MACH_SPEAR320)		:= spear3xx
 machine-$(CONFIG_MACH_SPEAR600)		:= spear6xx
+machine-$(CONFIG_ARCH_XILINX)		:= xilinx
 
 # Platform directory name.  This list is sorted alphanumerically
 # by CONFIG_* macro name.
diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index 9d30c6f..cf0c6f6 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -415,7 +415,7 @@ config CPU_32v6K
 
 # ARMv7
 config CPU_V7
-	bool "Support ARM V7 processor" if ARCH_INTEGRATOR || MACH_REALVIEW_EB || MACH_REALVIEW_PBX
+	bool "Support ARM V7 processor" if ARCH_INTEGRATOR || MACH_REALVIEW_EB || MACH_REALVIEW_PBX || ARCH_XILINX
 	select CPU_32v6K if !ARCH_OMAP2
 	select CPU_32v7
 	select CPU_ABRT_EV7
@@ -813,7 +813,7 @@ config CACHE_L2X0
 	depends on REALVIEW_EB_ARM11MP || MACH_REALVIEW_PB11MP || MACH_REALVIEW_PB1176 || \
 		   REALVIEW_EB_A9MP || ARCH_MX35 || ARCH_MX31 || MACH_REALVIEW_PBX || \
 		   ARCH_NOMADIK || ARCH_OMAP4 || ARCH_S5PV310 || ARCH_TEGRA || \
-		   ARCH_U8500 || ARCH_VEXPRESS_CA9X4 || ARCH_SHMOBILE
+		   ARCH_U8500 || ARCH_VEXPRESS_CA9X4 || ARCH_SHMOBILE || ARCH_XILINX
 	default y
 	select OUTER_CACHE
 	select OUTER_CACHE_SYNC
-- 
1.6.2.1



This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
