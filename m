From: vincenzo.frascino@arm.com (Vincenzo Frascino)
Date: Fri, 13 Apr 2018 15:44:35 +0100
Subject: [PATCH v2] arm64: Remove duplicate include
Message-ID: <1523630675-30687-1-git-send-email-vincenzo.frascino@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"make includecheck" detected few duplicated includes in arch/arm64.

This patch removes the double inclusions.

Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 arch/arm64/include/asm/kvm_mmu.h     | 1 -
 arch/arm64/kernel/armv8_deprecated.c | 3 +--
 arch/arm64/kernel/fpsimd.c           | 1 -
 arch/arm64/kernel/ptrace.c           | 2 --
 4 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
index 0821109..f74987b 100644
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@ -72,7 +72,6 @@
 #ifdef __ASSEMBLY__
 
 #include <asm/alternative.h>
-#include <asm/cpufeature.h>
 
 /*
  * Convert a kernel VA into a HYP VA.
diff --git a/arch/arm64/kernel/armv8_deprecated.c b/arch/arm64/kernel/armv8_deprecated.c
index 6e47fc3..97d45d5 100644
--- a/arch/arm64/kernel/armv8_deprecated.c
+++ b/arch/arm64/kernel/armv8_deprecated.c
@@ -13,6 +13,7 @@
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/sysctl.h>
+#include <linux/uaccess.h>
 
 #include <asm/cpufeature.h>
 #include <asm/insn.h>
@@ -20,8 +21,6 @@
 #include <asm/system_misc.h>
 #include <asm/traps.h>
 #include <asm/kprobes.h>
-#include <linux/uaccess.h>
-#include <asm/cpufeature.h>
 
 #define CREATE_TRACE_POINTS
 #include "trace-events-emulation.h"
diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 87a3536..3db8ed5 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -31,7 +31,6 @@
 #include <linux/percpu.h>
 #include <linux/prctl.h>
 #include <linux/preempt.h>
-#include <linux/prctl.h>
 #include <linux/ptrace.h>
 #include <linux/sched/signal.h>
 #include <linux/sched/task_stack.h>
diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 71d99af..8fb5d14 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -1040,8 +1040,6 @@ static const struct user_regset_view user_aarch64_view = {
 };
 
 #ifdef CONFIG_COMPAT
-#include <linux/compat.h>
-
 enum compat_regset {
 	REGSET_COMPAT_GPR,
 	REGSET_COMPAT_VFP,
-- 
2.7.4
