From: viresh.linux@gmail.com (Viresh Kumar)
Date: Fri, 20 Apr 2012 22:52:47 +0530
Subject: [PATCH 7/9] SPEAr13xx: Add compilation support
In-Reply-To: <cover.1334942163.git.viresh.kumar@st.com>
References: <cover.1334942163.git.viresh.kumar@st.com>
Message-ID: <8633d18f089b17c6d7a37641204f529f2400308a.1334942163.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 arch/arm/Makefile            |    2 ++
 arch/arm/plat-spear/Kconfig  |   12 ++++++++++++
 arch/arm/plat-spear/Makefile |    5 +++--
 3 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index a0c40a0..68d61ad 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -190,6 +190,8 @@ machine-$(CONFIG_ARCH_VEXPRESS)		:= vexpress
 machine-$(CONFIG_ARCH_VT8500)		:= vt8500
 machine-$(CONFIG_ARCH_W90X900)		:= w90x900
 machine-$(CONFIG_FOOTBRIDGE)		:= footbridge
+machine-$(CONFIG_MACH_SPEAR1310)	:= spear13xx
+machine-$(CONFIG_MACH_SPEAR1340)	:= spear13xx
 machine-$(CONFIG_MACH_SPEAR300)		:= spear3xx
 machine-$(CONFIG_MACH_SPEAR310)		:= spear3xx
 machine-$(CONFIG_MACH_SPEAR320)		:= spear3xx
diff --git a/arch/arm/plat-spear/Kconfig b/arch/arm/plat-spear/Kconfig
index 387655b..4404f82 100644
--- a/arch/arm/plat-spear/Kconfig
+++ b/arch/arm/plat-spear/Kconfig
@@ -8,6 +8,17 @@ choice
 	prompt "ST SPEAr Family"
 	default ARCH_SPEAR3XX
 
+config ARCH_SPEAR13XX
+	bool "ST SPEAr13xx with Device Tree"
+	select ARM_GIC
+	select CPU_V7
+	select USE_OF
+	select HAVE_SMP
+	select MIGHT_HAVE_CACHE_L2X0
+	select PINCTRL
+	help
+	  Supports for ARM's SPEAR13XX family
+
 config ARCH_SPEAR3XX
 	bool "ST SPEAr3xx with Device Tree"
 	select ARM_VIC
@@ -27,6 +38,7 @@ config ARCH_SPEAR6XX
 endchoice
 
 # Adding SPEAr machine specific configuration files
+source "arch/arm/mach-spear13xx/Kconfig"
 source "arch/arm/mach-spear3xx/Kconfig"
 source "arch/arm/mach-spear6xx/Kconfig"
 
diff --git a/arch/arm/plat-spear/Makefile b/arch/arm/plat-spear/Makefile
index 38f1235..2607bd0 100644
--- a/arch/arm/plat-spear/Makefile
+++ b/arch/arm/plat-spear/Makefile
@@ -3,6 +3,7 @@
 #
 
 # Common support
-obj-y	:= restart.o time.o pl080.o
+obj-y	:= restart.o time.o
 
-obj-$(CONFIG_ARCH_SPEAR3XX)	+= shirq.o
+obj-$(CONFIG_ARCH_SPEAR3XX)	+= pl080.o shirq.o
+obj-$(CONFIG_ARCH_SPEAR6XX)	+= pl080.o
-- 
1.7.9
