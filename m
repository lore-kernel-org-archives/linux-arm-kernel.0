From: soren.brinkmann@xilinx.com (Soren Brinkmann)
Date: Wed, 19 Feb 2014 15:14:43 -0800
Subject: [PATCH v4 3/4] arm: zynq: Don't use arm_global_timer with cpufreq
In-Reply-To: <1392851684-29950-1-git-send-email-soren.brinkmann@xilinx.com>
References: <1392851684-29950-1-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <1392851684-29950-4-git-send-email-soren.brinkmann@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The timer frequency of the arm_global_timer depends on the CPU
frequency. With cpufreq altering that frequency the arm_global_timer
does not maintain a stable time base. Therefore don't enable that timer
in case cpufreq is enabled.

Cc: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
---
v4:
 - no change

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
1.9.0.1.g4196000
