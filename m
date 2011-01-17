From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 17 Jan 2011 19:22:41 +0000
Subject: [PATCH 05/14] ARM: v6k: Realview EB 11MPCore and PB11MPCore use V6K
	architecture CPUs
In-Reply-To: <20110117192050.GE23331@n2100.arm.linux.org.uk>
References: <20110117192050.GE23331@n2100.arm.linux.org.uk>
Message-ID: <E1Peuf3-0003SZ-Hf@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make Realview EB ARM11MPCore and PB11MPCore select the new V6K CPU
option.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-realview/Kconfig |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-realview/Kconfig b/arch/arm/mach-realview/Kconfig
index b4575ae..e219459 100644
--- a/arch/arm/mach-realview/Kconfig
+++ b/arch/arm/mach-realview/Kconfig
@@ -17,7 +17,7 @@ config REALVIEW_EB_A9MP
 config REALVIEW_EB_ARM11MP
 	bool "Support ARM11MPCore tile"
 	depends on MACH_REALVIEW_EB
-	select CPU_V6
+	select CPU_V6K
 	select ARCH_HAS_BARRIERS if SMP
 	help
 	  Enable support for the ARM11MPCore tile on the Realview platform.
@@ -33,7 +33,7 @@ config REALVIEW_EB_ARM11MP_REVB
 
 config MACH_REALVIEW_PB11MP
 	bool "Support RealView/PB11MPCore platform"
-	select CPU_V6
+	select CPU_V6K
 	select ARM_GIC
 	select HAVE_PATA_PLATFORM
 	select ARCH_HAS_BARRIERS if SMP
@@ -42,6 +42,7 @@ config MACH_REALVIEW_PB11MP
 	  PB11MPCore is a platform with an on-board ARM11MPCore and has
 	  support for PCI-E and Compact Flash.
 
+# ARMv6 CPU without K extensions, but does have the new exclusive ops
 config MACH_REALVIEW_PB1176
 	bool "Support RealView/PB1176 platform"
 	select CPU_V6
-- 
1.6.2.5
