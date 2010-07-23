From: johlstei@codeaurora.org (Jeff Ohlstein)
Date: Fri, 23 Jul 2010 11:58:01 -0700
Subject: [PATCH 1/3] arm: Kconfig option for ARCH_MSM_SCORPIONMP
In-Reply-To: <1279911483-7039-1-git-send-email-johlstei@codeaurora.org>
References: <1279911483-7039-1-git-send-email-johlstei@codeaurora.org>
Message-ID: <1279911483-7039-2-git-send-email-johlstei@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ScorpionMP is a configuration of Scorpion processors. It supports SMP
and local timers.

Signed-off-by: Jeff Ohlstein <johlstei@codeaurora.org>
---
 arch/arm/Kconfig          |    5 +++--
 arch/arm/mach-msm/Kconfig |    2 ++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 98922f7..08518ae 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1100,7 +1100,7 @@ config SMP
 	bool "Symmetric Multi-Processing (EXPERIMENTAL)"
 	depends on EXPERIMENTAL && (REALVIEW_EB_ARM11MP || REALVIEW_EB_A9MP ||\
 		 MACH_REALVIEW_PB11MP || MACH_REALVIEW_PBX || ARCH_OMAP4 ||\
-		 ARCH_U8500 || ARCH_VEXPRESS_CA9X4)
+		 ARCH_U8500 || ARCH_VEXPRESS_CA9X4 || ARCH_MSM_SCORPIONMP)
 	depends on GENERIC_CLOCKEVENTS
 	select USE_GENERIC_SMP_HELPERS
 	select HAVE_ARM_SCU if (ARCH_REALVIEW || ARCH_OMAP4 || ARCH_U8500 || ARCH_VEXPRESS_CA9X4)
@@ -1172,7 +1172,8 @@ config HOTPLUG_CPU
 config LOCAL_TIMERS
 	bool "Use local timer interrupts"
 	depends on SMP && (REALVIEW_EB_ARM11MP || MACH_REALVIEW_PB11MP || \
-		REALVIEW_EB_A9MP || MACH_REALVIEW_PBX || ARCH_OMAP4 || ARCH_U8500)
+		REALVIEW_EB_A9MP || MACH_REALVIEW_PBX || ARCH_OMAP4 || ARCH_U8500 || \
+		ARCH_MSM_SCORPIONMP)
 	default y
 	select HAVE_ARM_TWD if (ARCH_REALVIEW || ARCH_OMAP4 || ARCH_U8500)
 	help
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
1.7.1.1
