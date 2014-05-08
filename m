From: michal.simek@xilinx.com (Michal Simek)
Date: Thu,  8 May 2014 17:13:37 +0200
Subject: [PATCH 1/3] ARM: zynq: Sort Kconfig options
Message-ID: <5e4fb08db4f6a436fc4593b22c3ae611ba545967.1399562009.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Keep options sorted.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 arch/arm/mach-zynq/Kconfig | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-zynq/Kconfig b/arch/arm/mach-zynq/Kconfig
index 58c2b844e0a3..1daa5c220d1d 100644
--- a/arch/arm/mach-zynq/Kconfig
+++ b/arch/arm/mach-zynq/Kconfig
@@ -1,14 +1,15 @@
 config ARCH_ZYNQ
 	bool "Xilinx Zynq ARM Cortex A9 Platform" if ARCH_MULTI_V7
-	select ARM_AMBA
-	select ARM_GIC
 	select ARCH_HAS_CPUFREQ
 	select ARCH_HAS_OPP
+	select ARM_AMBA
+	select ARM_GIC
+	select ARM_GLOBAL_TIMER if !CPU_FREQ
+	select CADENCE_TTC_TIMER
+	select GENERIC_ALLOCATOR
 	select HAVE_ARM_SCU if SMP
 	select HAVE_ARM_TWD if SMP
 	select ICST
-	select CADENCE_TTC_TIMER
-	select ARM_GLOBAL_TIMER if !CPU_FREQ
 	select MFD_SYSCON
 	help
 	  Support for Xilinx Zynq ARM Cortex A9 Platform
--
1.8.2.3

-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140508/4e70a55c/attachment.sig>
