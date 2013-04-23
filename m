From: vkale@apm.com (Vinayak Kale)
Date: Tue, 23 Apr 2013 15:55:56 +0530
Subject: [PATCH V2 1/4] arm64: Add Kconfig option for APM X-Gene SOC family
In-Reply-To: <1366712759-3431-1-git-send-email-vkale@apm.com>
References: <1366712759-3431-1-git-send-email-vkale@apm.com>
Message-ID: <1366712759-3431-2-git-send-email-vkale@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds arm64/Kconfig option for APM X-Gene SOC family.

Signed-off-by: Kumar Sankaran <ksankaran@apm.com>
Signed-off-by: Loc Ho <lho@apm.com>
Signed-off-by: Feng Kan <fkan@apm.com>
---
 arch/arm64/Kconfig |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 43b0e9f..16d0198 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -114,6 +114,11 @@ config ARCH_VEXPRESS
 	  This enables support for the ARMv8 software model (Versatile
 	  Express).
 
+config ARCH_XGENE
+	bool "AppliedMicro X-Gene SOC Family"
+	help
+	  This enables support for AppliedMicro X-Gene SOC Family
+
 endmenu
 
 menu "Bus support"
@@ -153,6 +158,8 @@ config NR_CPUS
 	int "Maximum number of CPUs (2-32)"
 	range 2 32
 	depends on SMP
+	# These have to remain sorted largest to smallest
+	default "8" if ARCH_XGENE
 	default "4"
 
 source kernel/Kconfig.preempt
-- 
1.7.4.1
