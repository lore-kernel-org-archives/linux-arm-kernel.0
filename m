From: viresh.kumar@st.com (Viresh KUMAR)
Date: Mon, 30 Aug 2010 16:08:38 +0530
Subject: [PATCH 07/74] ST SPEAr13XX: Added compilation support in arch/arm/
In-Reply-To: <cover.1283161023.git.viresh.kumar@st.com>
References: <cover.1283161023.git.viresh.kumar@st.com>
Message-ID: <b2e8b6b95ceff7d90032be8cd614787519b5c57c.1283161023.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shiraz Hashim <shiraz.hashim@st.com>

Signed-off-by: Shiraz Hashim <shiraz.hashim@st.com>
Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 arch/arm/Kconfig  |   12 ++++++++----
 arch/arm/Makefile |    1 +
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 9295110..950c045 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1144,11 +1144,13 @@ config SMP
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
@@ -1218,10 +1220,11 @@ config LOCAL_TIMERS
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
@@ -1599,6 +1602,7 @@ config ZRELADDR
 		ARCH_NUC93X ||\
 		ARCH_NS9XXX ||\
 		ARCH_ORION5X ||\
+		ARCH_SPEAR13XX ||\
 		ARCH_SPEAR3XX ||\
 		ARCH_SPEAR6XX ||\
 		ARCH_U8500 ||\
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
