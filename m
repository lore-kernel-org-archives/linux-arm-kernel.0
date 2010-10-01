From: viresh.kumar@st.com (Viresh KUMAR)
Date: Fri,  1 Oct 2010 17:25:29 +0530
Subject: [PATCH V2 09/69] ST SPEAr13XX: Added compilation support in arch/arm/
In-Reply-To: <cover.1285933331.git.viresh.kumar@st.com>
References: <cover.1285933331.git.viresh.kumar@st.com>
Message-ID: <dd1f4f0fd3727815d27106c7cc7f500173ff42e4.1285933331.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shiraz Hashim <shiraz.hashim@st.com>

This patch adds compilation support for ST Microelectronics SPEAr13xx machines.
SPEAr13xx SOC's are based on Arm CortexA9 CPUs.

Signed-off-by: Shiraz Hashim <shiraz.hashim@st.com>
Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 arch/arm/Kconfig  |   11 +++++++----
 arch/arm/Makefile |    1 +
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 88c97bc..42819a2 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1169,11 +1169,13 @@ config SMP
 	bool "Symmetric Multi-Processing (EXPERIMENTAL)"
 	depends on EXPERIMENTAL && (REALVIEW_EB_ARM11MP || REALVIEW_EB_A9MP ||\
 		 MACH_REALVIEW_PB11MP || MACH_REALVIEW_PBX || ARCH_OMAP4 ||\
-		 ARCH_S5PV310 || ARCH_TEGRA || ARCH_U8500 || ARCH_VEXPRESS_CA9X4)
+		 ARCH_S5PV310 || ARCH_SPEAR13XX || ARCH_TEGRA || ARCH_U8500 ||\
+		 ARCH_VEXPRESS_CA9X4)
 	depends on GENERIC_CLOCKEVENTS
 	select USE_GENERIC_SMP_HELPERS
 	select HAVE_ARM_SCU if ARCH_REALVIEW || ARCH_OMAP4 || ARCH_S5PV310 ||\
-		 ARCH_TEGRA || ARCH_U8500 || ARCH_VEXPRESS_CA9X4
+		 ARCH_SPEAR13XX || ARCH_TEGRA || ARCH_U8500 ||\
+		 ARCH_VEXPRESS_CA9X4
 	help
 	  This enables support for systems with more than one CPU. If you have
 	  a system with only one CPU, like most personal computers, say N. If
@@ -1243,10 +1245,11 @@ config LOCAL_TIMERS
 	bool "Use local timer interrupts"
 	depends on SMP && (REALVIEW_EB_ARM11MP || MACH_REALVIEW_PB11MP || \
 		REALVIEW_EB_A9MP || MACH_REALVIEW_PBX || ARCH_OMAP4 || \
-		ARCH_S5PV310 || ARCH_TEGRA || ARCH_U8500 || ARCH_VEXPRESS_CA9X4)
+		ARCH_S5PV310 || ARCH_SPEAR13XX || ARCH_TEGRA || ARCH_U8500 ||\
+		ARCH_VEXPRESS_CA9X4)
 	default y
 	select HAVE_ARM_TWD if ARCH_REALVIEW || ARCH_OMAP4 || ARCH_S5PV310 || \
-		ARCH_TEGRA || ARCH_U8500 || ARCH_VEXPRESS
+		ARCH_SPEAR13XX || ARCH_TEGRA || ARCH_U8500 || ARCH_VEXPRESS
 	help
 	  Enable support for local timers on SMP platforms, rather then the
 	  legacy IPI broadcast method.  Local timers allows the system
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 59c1ce8..d5177d7 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -191,6 +191,7 @@ machine-$(CONFIG_ARCH_VEXPRESS)		:= vexpress
 machine-$(CONFIG_ARCH_W90X900)		:= w90x900
 machine-$(CONFIG_ARCH_NUC93X)		:= nuc93x
 machine-$(CONFIG_FOOTBRIDGE)		:= footbridge
+machine-$(CONFIG_MACH_SPEAR1300)	:= spear13xx
 machine-$(CONFIG_MACH_SPEAR300)		:= spear3xx
 machine-$(CONFIG_MACH_SPEAR310)		:= spear3xx
 machine-$(CONFIG_MACH_SPEAR320)		:= spear3xx
-- 
1.7.2.2
