From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 1 Aug 2013 18:08:12 +0100
Subject: select statement sort order in arch/arm/Kconfig -- again
Message-ID: <20130801170812.GA23006@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

So, we go one kernel release since I fixed the ordering in this file
after Andrew Morton's complaint about conflicts, and people manage to
mess up the ordering.  Sorting the stuff in this file is clearly a
waste of time.

Not impressed.

On the plus side, I have a script which sorts these, so it's not
difficult to put them back into the correct order - that's not the
point - I _shouldn't_ have to do this.  It's just that it's _EXTRA_
_UNNECESSARY_ _CHURN_ each time I have to clean up after the fact.

--- a/arch/arm/Kconfig	2013-08-01 15:43:46.335784638 +0100
+++ b/arch/arm/Kconfig	2013-08-01 18:01:52.161928393 +0100
@@ -3,20 +3,21 @@
 	default y
 	select ARCH_BINFMT_ELF_RANDOMIZE_PIE
 	select ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
-	select ARCH_HAVE_CUSTOM_GPIO_H
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
+	select ARCH_HAVE_CUSTOM_GPIO_H
 	select ARCH_WANT_IPC_PARSE_VERSION
 	select BUILDTIME_EXTABLE_SORT if MMU
+	select CLONE_BACKWARDS
 	select CPU_PM if (SUSPEND || CPU_IDLE)
 	select DCACHE_WORD_ACCESS if (CPU_V6 || CPU_V6K || CPU_V7) && !CPU_BIG_ENDIAN && MMU
 	select GENERIC_ATOMIC64 if (CPU_V7M || CPU_V6 || !CPU_32v6K || !AEABI)
 	select GENERIC_CLOCKEVENTS_BROADCAST if SMP
+	select GENERIC_IDLE_POLL_SETUP
 	select GENERIC_IRQ_PROBE
 	select GENERIC_IRQ_SHOW
 	select GENERIC_PCI_IOMAP
 	select GENERIC_SCHED_CLOCK
 	select GENERIC_SMP_IDLE_THREAD
-	select GENERIC_IDLE_POLL_SETUP
 	select GENERIC_STRNCPY_FROM_USER
 	select GENERIC_STRNLEN_USER
 	select HARDIRQS_SW_RESEND
@@ -25,6 +26,7 @@
 	select HAVE_ARCH_SECCOMP_FILTER
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_BPF_JIT
+	select HAVE_CONTEXT_TRACKING
 	select HAVE_C_RECORDMCOUNT
 	select HAVE_DEBUG_KMEMLEAK
 	select HAVE_DMA_API_DEBUG
@@ -47,21 +49,19 @@
 	select HAVE_KPROBES if !XIP_KERNEL
 	select HAVE_KRETPROBES if (HAVE_KPROBES)
 	select HAVE_MEMBLOCK
+	select HAVE_MOD_ARCH_SPECIFIC if ARM_UNWIND
 	select HAVE_OPROFILE if (HAVE_PERF_EVENTS)
 	select HAVE_PERF_EVENTS
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_UID16
 	select KTIME_SCALAR
+	select MODULES_USE_ELF_REL
+	select OLD_SIGACTION
+	select OLD_SIGSUSPEND3
 	select PERF_USE_VMALLOC
 	select RTC_LIB
 	select SYS_SUPPORTS_APM_EMULATION
-	select HAVE_MOD_ARCH_SPECIFIC if ARM_UNWIND
-	select MODULES_USE_ELF_REL
-	select CLONE_BACKWARDS
-	select OLD_SIGSUSPEND3
-	select OLD_SIGACTION
-	select HAVE_CONTEXT_TRACKING
 	help
 	  The ARM series is a line of low-power-consumption RISC chip designs
 	  licensed by ARM Ltd and targeted at embedded applications and
@@ -385,8 +385,8 @@
 	bool "Cortina Systems Gemini"
 	select ARCH_REQUIRE_GPIOLIB
 	select ARCH_USES_GETTIMEOFFSET
-	select NEED_MACH_GPIO_H
 	select CPU_FA526
+	select NEED_MACH_GPIO_H
 	help
 	  Support for the Cortina Systems Gemini family SoCs
 
@@ -487,8 +487,8 @@
 	select GENERIC_CLOCKEVENTS
 	select MIGHT_HAVE_PCI
 	select NEED_MACH_IO_H
-	select USB_EHCI_BIG_ENDIAN_MMIO
 	select USB_EHCI_BIG_ENDIAN_DESC
+	select USB_EHCI_BIG_ENDIAN_MMIO
 	help
 	  Support for Intel's IXP4XX (XScale) family of processors.
 
@@ -498,11 +498,11 @@
 	select CPU_PJ4
 	select GENERIC_CLOCKEVENTS
 	select MIGHT_HAVE_PCI
+	select MVEBU_MBUS
 	select PINCTRL
 	select PINCTRL_DOVE
 	select PLAT_ORION_LEGACY
 	select USB_ARCH_HAS_EHCI
-	select MVEBU_MBUS
 	help
 	  Support for the Marvell Dove SoC 88AP510
 
@@ -512,12 +512,12 @@
 	select ARCH_REQUIRE_GPIOLIB
 	select CPU_FEROCEON
 	select GENERIC_CLOCKEVENTS
+	select MVEBU_MBUS
 	select PCI
 	select PCI_QUIRKS
 	select PINCTRL
 	select PINCTRL_KIRKWOOD
 	select PLAT_ORION_LEGACY
-	select MVEBU_MBUS
 	help
 	  Support for the following Marvell Kirkwood series SoCs:
 	  88F6180, 88F6192 and 88F6281.
@@ -527,9 +527,9 @@
 	select ARCH_REQUIRE_GPIOLIB
 	select CPU_FEROCEON
 	select GENERIC_CLOCKEVENTS
+	select MVEBU_MBUS
 	select PCI
 	select PLAT_ORION_LEGACY
-	select MVEBU_MBUS
 	help
 	  Support for the following Marvell MV78xx0 series SoCs:
 	  MV781x0, MV782x0.
@@ -540,9 +540,9 @@
 	select ARCH_REQUIRE_GPIOLIB
 	select CPU_FEROCEON
 	select GENERIC_CLOCKEVENTS
+	select MVEBU_MBUS
 	select PCI
 	select PLAT_ORION_LEGACY
-	select MVEBU_MBUS
 	help
 	  Support for the following Marvell Orion 5x series SoCs:
 	  Orion-1 (5181), Orion-VoIP (5181L), Orion-NAS (5182),
@@ -757,8 +757,8 @@
 	select HAVE_S3C2410_WATCHDOG if WATCHDOG
 	select HAVE_S3C_RTC if RTC_CLASS
 	select NEED_MACH_GPIO_H
-	select SAMSUNG_WDT_RESET
 	select SAMSUNG_ATAGS
+	select SAMSUNG_WDT_RESET
 	help
 	  Samsung S5P64X0 CPU based systems, such as the Samsung SMDK6440,
 	  SMDK6450.
@@ -776,8 +776,8 @@
 	select HAVE_S3C2410_WATCHDOG if WATCHDOG
 	select HAVE_S3C_RTC if RTC_CLASS
 	select NEED_MACH_GPIO_H
-	select SAMSUNG_WDT_RESET
 	select SAMSUNG_ATAGS
+	select SAMSUNG_WDT_RESET
 	help
 	  Samsung S5PC100 series based systems
 
