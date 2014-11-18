From: punit.agrawal@arm.com (Punit Agrawal)
Date: Tue, 18 Nov 2014 11:41:23 +0000
Subject: [PATCH v5 2/6] arm64: Add AArch32 instruction set condition code
 checks
In-Reply-To: <1416310887-14649-1-git-send-email-punit.agrawal@arm.com>
References: <1416310887-14649-1-git-send-email-punit.agrawal@arm.com>
Message-ID: <1416310887-14649-3-git-send-email-punit.agrawal@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Port support for AArch32 instruction condition code checking from arm
to arm64.

Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/include/asm/opcodes.h | 1 +
 arch/arm64/kernel/Makefile       | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/include/asm/opcodes.h

diff --git a/arch/arm64/include/asm/opcodes.h b/arch/arm64/include/asm/opcodes.h
new file mode 100644
index 0000000..4e603ea
--- /dev/null
+++ b/arch/arm64/include/asm/opcodes.h
@@ -0,0 +1 @@
+#include <../../arm/include/asm/opcodes.h>
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index 5bd029b..a4d8671 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -18,7 +18,8 @@ arm64-obj-y		:= cputable.o debug-monitors.o entry.o irq.o fpsimd.o	\
 			   cpuinfo.o
 
 arm64-obj-$(CONFIG_COMPAT)		+= sys32.o kuser32.o signal32.o 	\
-					   sys_compat.o
+					   sys_compat.o 			\
+					   ../../arm/kernel/opcodes.o
 arm64-obj-$(CONFIG_FUNCTION_TRACER)	+= ftrace.o entry-ftrace.o
 arm64-obj-$(CONFIG_MODULES)		+= arm64ksyms.o module.o
 arm64-obj-$(CONFIG_SMP)			+= smp.o smp_spin_table.o topology.o
-- 
2.1.1
