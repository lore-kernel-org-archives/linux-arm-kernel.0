From: soren.brinkmann@xilinx.com (Soren Brinkmann)
Date: Mon,  3 Feb 2014 14:34:36 -0800
Subject: [PATCH v3 6/7] arm: zynq: Don't use arm_global_timer with cpufreq
In-Reply-To: <1391466877-28908-1-git-send-email-soren.brinkmann@xilinx.com>
References: <1391466877-28908-1-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <1391466877-28908-7-git-send-email-soren.brinkmann@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The timer frequency of the arm_global_timer depends on the CPU
frequency. With cpufreq altering that frequency the arm_global_timer
does not maintain a stable time base. Therefore don't enable that timer
in case cpufreq is enabled.

Cc: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
---
 arch/arm/mach-zynq/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-zynq/Kconfig b/arch/arm/mach-zynq/Kconfig
index 6b04260aa142..f84fab14f0b7 100644
--- a/arch/arm/mach-zynq/Kconfig
+++ b/arch/arm/mach-zynq/Kconfig
@@ -13,6 +13,6 @@ config ARCH_ZYNQ
 	select HAVE_SMP
 	select SPARSE_IRQ
 	select CADENCE_TTC_TIMER
-	select ARM_GLOBAL_TIMER
+	select ARM_GLOBAL_TIMER if !CPU_FREQ
 	help
 	  Support for Xilinx Zynq ARM Cortex A9 Platform
-- 
1.8.5.3
