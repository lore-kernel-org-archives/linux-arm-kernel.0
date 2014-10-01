From: punit.agrawal@arm.com (Punit Agrawal)
Date: Wed,  1 Oct 2014 14:37:07 +0100
Subject: [PATCHv2 2/5] arm64: Add AArch32 instruction set condition code checks
In-Reply-To: <1412170630-18408-1-git-send-email-punit.agrawal@arm.com>
References: <1412165279-8709-1-git-send-email-punit.agrawal@arm.com>
 <1412170630-18408-1-git-send-email-punit.agrawal@arm.com>
Message-ID: <1412170630-18408-3-git-send-email-punit.agrawal@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Port support for AArch32 instruction condition code checking from arm
to arm64.

Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
---
 arch/arm64/include/asm/opcodes.h |    1 +
 arch/arm64/kernel/Makefile       |    4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/include/asm/opcodes.h

diff --git a/arch/arm64/include/asm/opcodes.h b/arch/arm64/include/asm/opcodes.h
new file mode 100644
index 0000000..4e603ea
--- /dev/null
+++ b/arch/arm64/include/asm/opcodes.h
@@ -0,0 +1 @@
+#include <../../arm/include/asm/opcodes.h>
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index df7ef87..e77dd61 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -18,7 +18,9 @@ arm64-obj-y		:= cputable.o debug-monitors.o entry.o irq.o fpsimd.o	\
 			   cpuinfo.o
 
 arm64-obj-$(CONFIG_COMPAT)		+= sys32.o kuser32.o signal32.o 	\
-					   sys_compat.o
+					   sys_compat.o 			\
+					   $(addprefix ../../arm/kernel/,	\
+						opcodes.o)
 arm64-obj-$(CONFIG_FUNCTION_TRACER)	+= ftrace.o entry-ftrace.o
 arm64-obj-$(CONFIG_MODULES)		+= arm64ksyms.o module.o
 arm64-obj-$(CONFIG_SMP)			+= smp.o smp_spin_table.o topology.o
-- 
1.7.10.4
