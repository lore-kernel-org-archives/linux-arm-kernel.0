From: jonas.rabenstein@studium.uni-erlangen.de (Jonas Rabenstein)
Date: Wed, 29 Jul 2015 13:13:20 +0200
Subject: [PATCH] arm64: remove redundant object file list
Message-ID: <1438168400-20082-1-git-send-email-jonas.rabenstein@studium.uni-erlangen.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 4b3dc9679cf7 ("arm64: force CONFIG_SMP=y and remove redundant
#ifdefs") forces SMP on arm64. To build the necessary objects for SMP,
they were added to the arm64-obj-y rule in arch/arm64/kernel/Makefile,
without removing the arm64-obj-$(CONFIG_SMP) rule.

Remove redundant object file list depending on always-yes CONFIG_SMP in
arch/arm64/kernel/Makefile.

Signed-off-by: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
---
I found this inconsistency using the undertaker and
undertaker-checkpatch tools (https://undertaker.cs.fau.de/).

 arch/arm64/kernel/Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index f126cfe..c662197 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -25,7 +25,6 @@ arm64-obj-$(CONFIG_COMPAT)		+= sys32.o kuser32.o signal32.o 	\
 					   ../../arm/kernel/opcodes.o
 arm64-obj-$(CONFIG_FUNCTION_TRACER)	+= ftrace.o entry-ftrace.o
 arm64-obj-$(CONFIG_MODULES)		+= arm64ksyms.o module.o
-arm64-obj-$(CONFIG_SMP)			+= smp.o smp_spin_table.o topology.o
 arm64-obj-$(CONFIG_PERF_EVENTS)		+= perf_regs.o
 arm64-obj-$(CONFIG_HW_PERF_EVENTS)	+= perf_event.o perf_callchain.o
 arm64-obj-$(CONFIG_HAVE_HW_BREAKPOINT)	+= hw_breakpoint.o
-- 
2.1.4
