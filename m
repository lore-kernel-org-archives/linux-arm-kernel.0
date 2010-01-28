From: dwalker@codeaurora.org (Daniel Walker)
Date: Thu, 28 Jan 2010 14:59:34 -0800
Subject: [RFC PATCH 09/12] arm: msm: Enable frequency scaling.
Message-ID: <1264719577-5436-10-git-send-email-dwalker@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Praveen Chidambaram <pchidamb@quicinc.com>

Acked-by: Saravana Kannan <skannan@quicinc.com>
Signed-off-by: Praveen Chidambaram <pchidamb@quicinc.com>
Signed-off-by: Daniel Walker <dwalker@codeaurora.org>
---
 arch/arm/Kconfig |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 71fb8b1..02c029a 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -575,6 +575,7 @@ config ARCH_PXA
 
 config ARCH_MSM
 	bool "Qualcomm MSM"
+	select ARCH_HAS_CPUFREQ
 	select GENERIC_TIME
 	select GENERIC_CLOCKEVENTS
 	help
@@ -1440,6 +1441,14 @@ source "drivers/cpuidle/Kconfig"
 
 endmenu
 
+config CPU_FREQ_MSM
+	bool
+	depends on CPU_FREQ && ARCH_MSM
+	default y
+	help
+	  This enables the CPUFreq driver for Qualcomm CPUs.
+	  If in doubt, say Y.
+
 menu "Floating point emulation"
 
 comment "At least one emulation must be selected"
-- 
1.6.3.3
