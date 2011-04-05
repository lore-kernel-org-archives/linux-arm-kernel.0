From: john.linn@xilinx.com (John Linn)
Date: Tue, 5 Apr 2011 12:28:05 -0600
Subject: [PATCH V6 4/5] ARM: Xilinx: Adding Xilinx platform infrastructure
	support
In-Reply-To: <1302028086-17603-4-git-send-email-john.linn@xilinx.com>
References: <1302028086-17603-1-git-send-email-john.linn@xilinx.com>
	<1302028086-17603-2-git-send-email-john.linn@xilinx.com>
	<1302028086-17603-3-git-send-email-john.linn@xilinx.com>
	<1302028086-17603-4-git-send-email-john.linn@xilinx.com>
Message-ID: <7cf252b5-03c7-45e3-b7d9-f6094bf8a467@VA3EHSMHS033.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Minimum infrastructure to add the Xilinx machine and allow it to
be selected in the build.

Signed-off-by: John Linn <john.linn@xilinx.com>
---

V6 Changes
	Only change was the renaming of mach-xilinx to mach-zynq
	which rippled thru as a minor change. 

No updates for V5

V4

Updated to apply against linux-next branch.

No updates for V3

V2 Changes

Updates based on Russell King's comments	
	Cleanup of the Kconfig
	Moved this patch to be last in the patch series


 arch/arm/Kconfig    |   14 ++++++++++++++
 arch/arm/Makefile   |    1 +
 arch/arm/mm/Kconfig |    2 +-
 3 files changed, 16 insertions(+), 1 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 70429c2..d00dbcc 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -889,6 +889,18 @@ config ARCH_VT8500
 	select HAVE_PWM
 	help
 	  Support for VIA/WonderMedia VT8500/WM85xx System-on-Chip.
+
+config ARCH_ZYNQ
+	bool "Xilinx Zynq ARM Cortex A9 Platform"
+	select CPU_V7
+	select GENERIC_TIME
+	select GENERIC_CLOCKEVENTS
+	select CLKDEV_LOOKUP
+	select ARM_GIC
+	select ARM_AMBA
+	help
+	  Support for Xilinx Zynq ARM Cortex A9 Platform
+
 endchoice
 
 #
@@ -1022,6 +1034,8 @@ source "arch/arm/mach-vt8500/Kconfig"
 
 source "arch/arm/mach-w90x900/Kconfig"
 
+source "arch/arm/mach-zynq/Kconfig"
+
 # Definitions to make life easier
 config ARCH_ACORN
 	bool
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 83db7bb..99e7cbd 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -201,6 +201,7 @@ machine-$(CONFIG_MACH_SPEAR300)		:= spear3xx
 machine-$(CONFIG_MACH_SPEAR310)		:= spear3xx
 machine-$(CONFIG_MACH_SPEAR320)		:= spear3xx
 machine-$(CONFIG_MACH_SPEAR600)		:= spear6xx
+machine-$(CONFIG_ARCH_ZYNQ)		:= zynq
 
 # Platform directory name.  This list is sorted alphanumerically
 # by CONFIG_* macro name.
diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index 0074b8d..f046982 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -821,7 +821,7 @@ config CACHE_L2X0
 	depends on REALVIEW_EB_ARM11MP || MACH_REALVIEW_PB11MP || MACH_REALVIEW_PB1176 || \
 		   REALVIEW_EB_A9MP || SOC_IMX35 || SOC_IMX31 || MACH_REALVIEW_PBX || \
 		   ARCH_NOMADIK || ARCH_OMAP4 || ARCH_EXYNOS4 || ARCH_TEGRA || \
-		   ARCH_U8500 || ARCH_VEXPRESS_CA9X4 || ARCH_SHMOBILE
+		   ARCH_U8500 || ARCH_VEXPRESS_CA9X4 || ARCH_SHMOBILE || ARCH_ZYNQ
 	default y
 	select OUTER_CACHE
 	select OUTER_CACHE_SYNC
-- 
1.5.4.7



This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
