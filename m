From: punit.agrawal@arm.com (Punit Agrawal)
Date: Tue, 26 Aug 2014 11:28:48 +0100
Subject: [PATCH 4/6] arm64: Add AArch32 instruction set condition code checks
In-Reply-To: <1409048930-21598-1-git-send-email-punit.agrawal@arm.com>
References: <1409048930-21598-1-git-send-email-punit.agrawal@arm.com>
Message-ID: <1409048930-21598-5-git-send-email-punit.agrawal@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Port support for AArch32 instruction condition code checking from arm
to arm64.

Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
---
 arch/arm64/include/asm/opcodes.h |    1 +
 arch/arm64/kernel/Makefile       |    5 ++++-
 2 files changed, 5 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/include/asm/opcodes.h

diff --git a/arch/arm64/include/asm/opcodes.h b/arch/arm64/include/asm/opcodes.h
new file mode 100644
index 0000000..4e603ea
--- /dev/null
+++ b/arch/arm64/include/asm/opcodes.h
@@ -0,0 +1 @@
+#include <../../arm/include/asm/opcodes.h>
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index 1f4d891..eee33a0 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -16,7 +16,10 @@ arm64-obj-y		:= cputable.o debug-monitors.o entry.o irq.o fpsimd.o	\
 			   hyp-stub.o psci.o cpu_ops.o insn.o return_address.o
 
 arm64-obj-$(CONFIG_COMPAT)		+= sys32.o kuser32.o signal32.o 	\
-					   sys_compat.o
+					   sys_compat.o 			\
+					   $(addprefix ../../arm/kernel/,	\
+						opcodes.o)
+
 arm64-obj-$(CONFIG_FUNCTION_TRACER)	+= ftrace.o entry-ftrace.o
 arm64-obj-$(CONFIG_MODULES)		+= arm64ksyms.o module.o
 arm64-obj-$(CONFIG_SMP)			+= smp.o smp_spin_table.o topology.o
-- 
1.7.10.4
