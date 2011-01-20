From: viresh.kumar@st.com (Viresh Kumar)
Date: Thu, 20 Jan 2011 12:55:49 +0530
Subject: [PATCH V5 10/63] ST SPEAr13XX: Added compilation support in arch/arm/
In-Reply-To: <cover.1295499392.git.viresh.kumar@st.com>
References: <cover.1295499392.git.viresh.kumar@st.com>
Message-ID: <d71b8689c5ffe1db4c6f253907804fdc83d9bbe3.1295499394.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shiraz Hashim <shiraz.hashim@st.com>

This patch adds compilation support for ST Microelectronics SPEAr13xx machines.
SPEAr13xx SOC's are based on Arm CortexA9 CPUs.

Signed-off-by: Shiraz Hashim <shiraz.hashim@st.com>
Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 arch/arm/Kconfig  |    4 ++--
 arch/arm/Makefile |    1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 5cff165..f3904ba 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1253,8 +1253,8 @@ config SMP
 	depends on GENERIC_CLOCKEVENTS
 	depends on REALVIEW_EB_ARM11MP || REALVIEW_EB_A9MP || \
 		 MACH_REALVIEW_PB11MP || MACH_REALVIEW_PBX || ARCH_OMAP4 || \
-		 ARCH_S5PV310 || ARCH_TEGRA || ARCH_U8500 || ARCH_VEXPRESS_CA9X4 || \
-		 ARCH_MSM_SCORPIONMP || ARCH_SHMOBILE
+		 ARCH_S5PV310 || ARCH_SPEAR13XX || ARCH_TEGRA || ARCH_U8500 || \
+		 ARCH_VEXPRESS_CA9X4 || ARCH_MSM_SCORPIONMP || ARCH_SHMOBILE
 	select USE_GENERIC_SMP_HELPERS
 	select HAVE_ARM_SCU if !ARCH_MSM_SCORPIONMP
 	help
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index c22c1ad..51769cc 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -193,6 +193,7 @@ machine-$(CONFIG_ARCH_VEXPRESS)		:= vexpress
 machine-$(CONFIG_ARCH_W90X900)		:= w90x900
 machine-$(CONFIG_ARCH_NUC93X)		:= nuc93x
 machine-$(CONFIG_FOOTBRIDGE)		:= footbridge
+machine-$(CONFIG_MACH_SPEAR1300)	:= spear13xx
 machine-$(CONFIG_MACH_SPEAR300)		:= spear3xx
 machine-$(CONFIG_MACH_SPEAR310)		:= spear3xx
 machine-$(CONFIG_MACH_SPEAR320)		:= spear3xx
-- 
1.7.3.4
