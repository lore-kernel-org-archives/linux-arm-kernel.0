From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Tue, 06 Nov 2018 12:49:34 +0000
Subject: [PATCH 1/2] ARM: Kconfig: remove useless parenthesis
Message-ID: <E1gK0nW-0007ff-84@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove useless parenthesis from the Kconfig - Kconfig is not C, and
can cope without parenthesising e.g. single symbols to 'if'.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/Kconfig | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 668f9a8c73bb..78a8e96f5376 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -28,14 +28,14 @@ config ARM
 	select ARCH_WANT_IPC_PARSE_VERSION
 	select BUILDTIME_EXTABLE_SORT if MMU
 	select CLONE_BACKWARDS
-	select CPU_PM if (SUSPEND || CPU_IDLE)
+	select CPU_PM if SUSPEND || CPU_IDLE
 	select DCACHE_WORD_ACCESS if HAVE_EFFICIENT_UNALIGNED_ACCESS
 	select DMA_DIRECT_OPS if !MMU
 	select EDAC_SUPPORT
 	select EDAC_ATOMIC_SCRUB
 	select GENERIC_ALLOCATOR
 	select GENERIC_ARCH_TOPOLOGY if ARM_CPU_TOPOLOGY
-	select GENERIC_ATOMIC64 if (CPU_V7M || CPU_V6 || !CPU_32v6K || !AEABI)
+	select GENERIC_ATOMIC64 if CPU_V7M || CPU_V6 || !CPU_32v6K || !AEABI
 	select GENERIC_CLOCKEVENTS_BROADCAST if SMP
 	select GENERIC_CPU_AUTOPROBE
 	select GENERIC_EARLY_IOREMAP
@@ -50,12 +50,12 @@ config ARM
 	select GENERIC_STRNLEN_USER
 	select HANDLE_DOMAIN_IRQ
 	select HARDIRQS_SW_RESEND
-	select HAVE_ARCH_AUDITSYSCALL if (AEABI && !OABI_COMPAT)
+	select HAVE_ARCH_AUDITSYSCALL if AEABI && !OABI_COMPAT
 	select HAVE_ARCH_BITREVERSE if (CPU_32v7M || CPU_32v7) && !CPU_32v6
 	select HAVE_ARCH_JUMP_LABEL if !XIP_KERNEL && !CPU_ENDIAN_BE32 && MMU
 	select HAVE_ARCH_KGDB if !CPU_ENDIAN_BE32 && MMU
 	select HAVE_ARCH_MMAP_RND_BITS if MMU
-	select HAVE_ARCH_SECCOMP_FILTER if (AEABI && !OABI_COMPAT)
+	select HAVE_ARCH_SECCOMP_FILTER if AEABI && !OABI_COMPAT
 	select HAVE_ARCH_THREAD_STRUCT_WHITELIST
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_ARM_SMCCC if CPU_V7
@@ -64,16 +64,16 @@ config ARM
 	select HAVE_C_RECORDMCOUNT
 	select HAVE_DEBUG_KMEMLEAK
 	select HAVE_DMA_CONTIGUOUS if MMU
-	select HAVE_DYNAMIC_FTRACE if (!XIP_KERNEL) && !CPU_ENDIAN_BE32 && MMU
+	select HAVE_DYNAMIC_FTRACE if !XIP_KERNEL && !CPU_ENDIAN_BE32 && MMU
 	select HAVE_DYNAMIC_FTRACE_WITH_REGS if HAVE_DYNAMIC_FTRACE
 	select HAVE_EFFICIENT_UNALIGNED_ACCESS if (CPU_V6 || CPU_V6K || CPU_V7) && MMU
 	select HAVE_EXIT_THREAD
-	select HAVE_FTRACE_MCOUNT_RECORD if (!XIP_KERNEL)
-	select HAVE_FUNCTION_GRAPH_TRACER if (!THUMB2_KERNEL)
-	select HAVE_FUNCTION_TRACER if (!XIP_KERNEL)
+	select HAVE_FTRACE_MCOUNT_RECORD if !XIP_KERNEL
+	select HAVE_FUNCTION_GRAPH_TRACER if !THUMB2_KERNEL
+	select HAVE_FUNCTION_TRACER if !XIP_KERNEL
 	select HAVE_GCC_PLUGINS
 	select HAVE_GENERIC_DMA_COHERENT
-	select HAVE_HW_BREAKPOINT if (PERF_EVENTS && (CPU_V6 || CPU_V6K || CPU_V7))
+	select HAVE_HW_BREAKPOINT if PERF_EVENTS && (CPU_V6 || CPU_V6K || CPU_V7)
 	select HAVE_IDE if PCI || ISA || PCMCIA
 	select HAVE_IRQ_TIME_ACCOUNTING
 	select HAVE_KERNEL_GZIP
@@ -82,17 +82,17 @@ config ARM
 	select HAVE_KERNEL_LZO
 	select HAVE_KERNEL_XZ
 	select HAVE_KPROBES if !XIP_KERNEL && !CPU_ENDIAN_BE32 && !CPU_V7M
-	select HAVE_KRETPROBES if (HAVE_KPROBES)
+	select HAVE_KRETPROBES if HAVE_KPROBES
 	select HAVE_LD_DEAD_CODE_DATA_ELIMINATION if !FUNCTION_TRACER
 	select HAVE_MEMBLOCK
 	select HAVE_MOD_ARCH_SPECIFIC
 	select HAVE_NMI
-	select HAVE_OPROFILE if (HAVE_PERF_EVENTS)
+	select HAVE_OPROFILE if HAVE_PERF_EVENTS
 	select HAVE_OPTPROBES if !THUMB2_KERNEL
 	select HAVE_PERF_EVENTS
 	select HAVE_PERF_REGS
 	select HAVE_PERF_USER_STACK_DUMP
-	select HAVE_RCU_TABLE_FREE if (SMP && ARM_LPAE)
+	select HAVE_RCU_TABLE_FREE if SMP && ARM_LPAE
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_RSEQ
 	select HAVE_STACKPROTECTOR
-- 
2.7.4
