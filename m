From: viresh.kumar@st.com (Viresh Kumar)
Date: Tue, 1 Mar 2011 16:57:04 +0530
Subject: [PATCH V6 04/10] ST SPEAr13xx: Added compilation support in arch/arm/
In-Reply-To: <cover.1298977719.git.viresh.kumar@st.com>
References: <cover.1298977719.git.viresh.kumar@st.com>
Message-ID: <a9860793c9bf4e0a49874eba475bc8fe7674022a.1298977719.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shiraz Hashim <shiraz.hashim@st.com>

This patch adds compilation support for ST Microelectronics SPEAr13xx machines.
SPEAr13xx SOC's are based on Arm CortexA9 CPUs.

Reviewed-by: Stanley Miao <stanley.miao@windriver.com>
Signed-off-by: Shiraz Hashim <shiraz.hashim@st.com>
Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 arch/arm/Kconfig  |    4 ++--
 arch/arm/Makefile |    1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 166efa2..d9efe86 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1278,8 +1278,8 @@ config SMP
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
index 6f7b292..f4f3021 100644
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
1.7.2.2
