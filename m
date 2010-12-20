From: viresh.kumar@st.com (Viresh Kumar)
Date: Mon, 20 Dec 2010 13:55:30 +0530
Subject: [PATCH V3 09/63] ST SPEAr13XX: Added compilation support in arch/arm/
In-Reply-To: <cover.1292833228.git.viresh.kumar@st.com>
References: <cover.1292833228.git.viresh.kumar@st.com>
Message-ID: <f5dd58b9a7f52a9d727ebcddf9805825aa5f299a.1292833228.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shiraz Hashim <shiraz.hashim@st.com>

This patch adds compilation support for ST Microelectronics SPEAr13xx machines.
SPEAr13xx SOC's are based on Arm CortexA9 CPUs.

Signed-off-by: Shiraz Hashim <shiraz.hashim@st.com>
Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 arch/arm/Kconfig  |    3 ++-
 arch/arm/Makefile |    1 +
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index d56d21c..7c8ba2c 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1206,7 +1206,8 @@ config SMP
 	depends on GENERIC_CLOCKEVENTS
 	depends on REALVIEW_EB_ARM11MP || REALVIEW_EB_A9MP || \
 		 MACH_REALVIEW_PB11MP || MACH_REALVIEW_PBX || ARCH_OMAP4 ||\
-		 ARCH_S5PV310 || ARCH_TEGRA || ARCH_U8500 || ARCH_VEXPRESS_CA9X4
+		 ARCH_S5PV310 || ARCH_SPEAR13XX || ARCH_TEGRA || ARCH_U8500 ||\
+		 ARCH_VEXPRESS_CA9X4
 	select USE_GENERIC_SMP_HELPERS
 	select HAVE_ARM_SCU
 	help
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index b87aed0..39f0e93 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -192,6 +192,7 @@ machine-$(CONFIG_ARCH_VEXPRESS)		:= vexpress
 machine-$(CONFIG_ARCH_W90X900)		:= w90x900
 machine-$(CONFIG_ARCH_NUC93X)		:= nuc93x
 machine-$(CONFIG_FOOTBRIDGE)		:= footbridge
+machine-$(CONFIG_MACH_SPEAR1300)	:= spear13xx
 machine-$(CONFIG_MACH_SPEAR300)		:= spear3xx
 machine-$(CONFIG_MACH_SPEAR310)		:= spear3xx
 machine-$(CONFIG_MACH_SPEAR320)		:= spear3xx
-- 
1.7.2.2
