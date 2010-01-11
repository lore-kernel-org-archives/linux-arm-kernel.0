From: dwalker@codeaurora.org (Daniel Walker)
Date: Mon, 11 Jan 2010 14:47:31 -0800
Subject: [RFC 12/18] arm: msm: Enable frequency scaling.
In-Reply-To: <1263250057-26692-1-git-send-email-dwalker@codeaurora.org>
References: <1263250057-26692-1-git-send-email-dwalker@codeaurora.org>
Message-ID: <1263250057-26692-13-git-send-email-dwalker@codeaurora.org>
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
index c752b7d..2db3739 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -573,6 +573,7 @@ config ARCH_PXA
 
 config ARCH_MSM
 	bool "Qualcomm MSM"
+	select ARCH_HAS_CPUFREQ
 	select GENERIC_TIME
 	select GENERIC_CLOCKEVENTS
 	help
@@ -1437,6 +1438,14 @@ source "drivers/cpuidle/Kconfig"
 
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
