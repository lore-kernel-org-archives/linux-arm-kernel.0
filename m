From: dwalker@codeaurora.org (Daniel Walker)
Date: Thu,  9 Sep 2010 12:58:06 -0700
Subject: [PATCH 1/4] arm: Kconfig option for ARCH_MSM_SCORPIONMP
In-Reply-To: <1284062289-10914-1-git-send-email-dwalker@codeaurora.org>
References: <1284062289-10914-1-git-send-email-dwalker@codeaurora.org>
Message-ID: <1284062289-10914-2-git-send-email-dwalker@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Steve Muckle <smuckle@codeaurora.org>

ScorpionMP is a configuration of Scorpion processors. It supports local
timers.

Signed-off-by: Steve Muckle <smuckle@codeaurora.org>
Signed-off-by: Jeff Ohlstein <johlstei@codeaurora.org>
Signed-off-by: Daniel Walker <dwalker@codeaurora.org>
---
 arch/arm/Kconfig          |    6 ++++--
 arch/arm/mach-msm/Kconfig |    2 ++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index a7ed21f..d2dfbc2 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1144,7 +1144,8 @@ config SMP
 	bool "Symmetric Multi-Processing (EXPERIMENTAL)"
 	depends on EXPERIMENTAL && (REALVIEW_EB_ARM11MP || REALVIEW_EB_A9MP ||\
 		 MACH_REALVIEW_PB11MP || MACH_REALVIEW_PBX || ARCH_OMAP4 ||\
-		 ARCH_S5PV310 || ARCH_TEGRA || ARCH_U8500 || ARCH_VEXPRESS_CA9X4)
+		 ARCH_S5PV310 || ARCH_TEGRA || ARCH_U8500 || ARCH_VEXPRESS_CA9X4||\
+		 ARCH_MSM_SCORPIONMP)
 	depends on GENERIC_CLOCKEVENTS
 	select USE_GENERIC_SMP_HELPERS
 	select HAVE_ARM_SCU if ARCH_REALVIEW || ARCH_OMAP4 || ARCH_S5PV310 ||\
@@ -1218,7 +1219,8 @@ config LOCAL_TIMERS
 	bool "Use local timer interrupts"
 	depends on SMP && (REALVIEW_EB_ARM11MP || MACH_REALVIEW_PB11MP || \
 		REALVIEW_EB_A9MP || MACH_REALVIEW_PBX || ARCH_OMAP4 || \
-		ARCH_S5PV310 || ARCH_TEGRA || ARCH_U8500 || ARCH_VEXPRESS_CA9X4)
+		ARCH_S5PV310 || ARCH_TEGRA || ARCH_U8500 || ARCH_VEXPRESS_CA9X4 ||\
+		ARCH_MSM_SCORPIONMP)
 	default y
 	select HAVE_ARM_TWD if ARCH_REALVIEW || ARCH_OMAP4 || ARCH_S5PV310 || \
 		ARCH_TEGRA || ARCH_U8500 || ARCH_VEXPRESS
diff --git a/arch/arm/mach-msm/Kconfig b/arch/arm/mach-msm/Kconfig
index 47264a7..cc59b0c 100644
--- a/arch/arm/mach-msm/Kconfig
+++ b/arch/arm/mach-msm/Kconfig
@@ -35,6 +35,8 @@ config  ARCH_MSM_ARM11
 	bool
 config  ARCH_MSM_SCORPION
 	bool
+config  ARCH_MSM_SCORPIONMP
+	bool
 
 config  MSM_VIC
 	bool
-- 
1.7.1
