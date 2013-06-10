From: magnus.damm@gmail.com (Magnus Damm)
Date: Mon, 10 Jun 2013 18:46:57 +0900
Subject: [PATCH 02/03] ARM: shmobile: Remove MEMORY_START/SIZE
In-Reply-To: <20130610094638.20803.18484.sendpatchset@w520>
References: <20130610094638.20803.18484.sendpatchset@w520>
Message-ID: <20130610094657.20803.96780.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Remove CONFIG_MEMORY_START and CONFIG_MEMORY_SIZE from mach-shmobile.

Boards should use DT to specify their memory setup. Boards that still
not support DT may pass ATAGS with memory information from the boot
loader. If those ATAGS turn out to be incorrect then appended DTB with
memory information should be used as a workaround.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/Kconfig |   31 -------------------------------
 1 file changed, 31 deletions(-)

--- 0007/arch/arm/mach-shmobile/Kconfig
+++ work/arch/arm/mach-shmobile/Kconfig	2013-06-05 12:06:25.000000000 +0900
@@ -199,37 +199,6 @@ config CPU_HAS_INTEVT
         bool
 	default y
 
-menu "Memory configuration"
-
-config MEMORY_START
-	hex "Physical memory start address"
-	default "0x40000000" if MACH_AP4EVB || MACH_AG5EVM || \
-				MACH_MACKEREL || MACH_BONITO || \
-				MACH_ARMADILLO800EVA || MACH_APE6EVM || \
-				MACH_LAGER
-	default "0x41000000" if MACH_KOTA2
-	default "0x00000000"
-	---help---
-	  Tweak this only when porting to a new machine which does not
-	  already have a defconfig. Changing it from the known correct
-	  value on any of the known systems will only lead to disaster.
-
-config MEMORY_SIZE
-	hex "Physical memory size"
-	default "0x80000000" if MACH_LAGER
-	default "0x40000000" if MACH_APE6EVM
-	default "0x20000000" if MACH_AG5EVM || MACH_BONITO || \
-				MACH_ARMADILLO800EVA
-	default "0x1e000000" if MACH_KOTA2
-	default "0x10000000" if MACH_AP4EVB || MACH_MACKEREL
-	default "0x04000000"
-	help
-	  This sets the default memory size assumed by your kernel. It can
-	  be overridden as normal by the 'mem=' argument on the kernel command
-	  line.
-
-endmenu
-
 menu "Timer and clock configuration"
 
 config SHMOBILE_TIMER_HZ
