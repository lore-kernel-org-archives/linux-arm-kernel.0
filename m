From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Sun, 25 Jun 2017 19:00:17 +0200
Subject: [PATCH 2/5] ARM: Prepare Socionext MB86S71
In-Reply-To: <20170625170020.11791-1-afaerber@suse.de>
References: <20170625170020.11791-1-afaerber@suse.de>
Message-ID: <20170625170020.11791-3-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Introduce CONFIG_ARCH_MB86S7X, which was already being used.

Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 arch/arm/Kconfig               |  2 ++
 arch/arm/Makefile              |  1 +
 arch/arm/mach-mb86s7x/Kconfig  | 10 ++++++++++
 arch/arm/mach-mb86s7x/Makefile |  1 +
 4 files changed, 14 insertions(+)
 create mode 100644 arch/arm/mach-mb86s7x/Kconfig
 create mode 100644 arch/arm/mach-mb86s7x/Makefile

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 6d2f77c77556..cbf56aa0a9e5 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -763,6 +763,8 @@ source "arch/arm/mach-keystone/Kconfig"
 
 source "arch/arm/mach-ks8695/Kconfig"
 
+source "arch/arm/mach-mb86s7x/Kconfig"
+
 source "arch/arm/mach-meson/Kconfig"
 
 source "arch/arm/mach-moxart/Kconfig"
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 47d3a1ab08d2..d728548e0e59 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -180,6 +180,7 @@ machine-$(CONFIG_ARCH_KEYSTONE)		+= keystone
 machine-$(CONFIG_ARCH_KS8695)		+= ks8695
 machine-$(CONFIG_ARCH_LPC18XX)		+= lpc18xx
 machine-$(CONFIG_ARCH_LPC32XX)		+= lpc32xx
+machine-$(CONFIG_ARCH_MB86S7X)		+= mb86s7x
 machine-$(CONFIG_ARCH_MESON)		+= meson
 machine-$(CONFIG_ARCH_MMP)		+= mmp
 machine-$(CONFIG_ARCH_MPS2)		+= vexpress
diff --git a/arch/arm/mach-mb86s7x/Kconfig b/arch/arm/mach-mb86s7x/Kconfig
new file mode 100644
index 000000000000..8fe81bb7da0d
--- /dev/null
+++ b/arch/arm/mach-mb86s7x/Kconfig
@@ -0,0 +1,10 @@
+config ARCH_MB86S7X
+	bool "Socionext MB86S7x SoCs"
+	depends on ARCH_MULTI_V7
+	select ARM_AMBA
+	select ARM_GLOBAL_TIMER
+	select ARM_GIC
+	select HAVE_ARM_SCU
+	select HAVE_ARM_TWD if SMP
+	help
+	  Support for MB86S71 SoC family developed by Socionext Inc.
diff --git a/arch/arm/mach-mb86s7x/Makefile b/arch/arm/mach-mb86s7x/Makefile
new file mode 100644
index 000000000000..6bea3d3a2dd7
--- /dev/null
+++ b/arch/arm/mach-mb86s7x/Makefile
@@ -0,0 +1 @@
+obj- += dummy.o
-- 
2.12.3
