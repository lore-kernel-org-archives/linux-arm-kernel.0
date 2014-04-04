From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 4 Apr 2014 12:16:47 +0100
Subject: The Alphabet (or, the sorting of Kconfig symbols)
Message-ID: <20140404111647.GZ7528@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For those who don't know it, the order of letters in the alphabet is:

A B C D E F G H I J K L M N O P Q R S T U V W X Y Z

and we use this order to determine the position of "select" entries in
Kconfig files.  We do that so that we can reduce conflicts.  Conflicts
such as these kinds of rubbish:

diff --cc arch/arm/mach-shmobile/Kconfig
index 3b8c87461d67,5249ff0511a8..000000000000
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@@ -133,7 -116,7 +126,11 @@@ config ARCH_R8A779
        select MIGHT_HAVE_PCI
        select SH_CLK_CPG
        select RENESAS_IRQC
++<<<<<<< HEAD
 +      select SYS_SUPPORTS_SH_CMT
++=======
+       select ARCH_DMA_ADDR_T_64BIT if ARM_LPAE
++>>>>>>> arm-soc/for-next
...
diff --cc arch/arm/mach-zynq/Kconfig
index f03e75bd0b2b,cd2d55ab834a..000000000000
--- a/arch/arm/mach-zynq/Kconfig
+++ b/arch/arm/mach-zynq/Kconfig
@@@ -2,19 -2,11 +2,23 @@@ config ARCH_ZYN
        select ARM_AMBA
        select ARM_GIC
++<<<<<<< HEAD
 +      select ARCH_HAS_CPUFREQ
 +      select ARCH_HAS_OPP
 +      select COMMON_CLK
 +      select CPU_V7
 +      select GENERIC_CLOCKEVENTS
++=======
++>>>>>>> arm-soc/for-next
        select HAVE_ARM_SCU if SMP
        select HAVE_ARM_TWD if SMP
        select ICST
-       select MIGHT_HAVE_CACHE_L2X0
-       select USE_OF
-       select HAVE_SMP
-       select SPARSE_IRQ
        select CADENCE_TTC_TIMER
++<<<<<<< HEAD
 +      select ARM_GLOBAL_TIMER if !CPU_FREQ
++=======
+       select ARM_GLOBAL_TIMER
+       select MFD_SYSCON
++>>>>>>> arm-soc/for-next

Please note down the above sequence of letters for future reference. :)

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
