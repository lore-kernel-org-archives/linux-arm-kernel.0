From: axel.lin@gmail.com (Axel Lin)
Date: Wed, 15 Feb 2012 13:36:28 +0800
Subject: [PATCH] ARM: ptrace: Include linux/audit.h to fix build errors
Message-ID: <1329284188.12708.1.camel@phoenix>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Include linux/audit.h to fix below build errors:

  CC      arch/arm/kernel/ptrace.o
arch/arm/kernel/ptrace.c: In function 'syscall_trace':
arch/arm/kernel/ptrace.c:919: error: implicit declaration of function 'audit_syscall_exit'
arch/arm/kernel/ptrace.c:921: error: implicit declaration of function 'audit_syscall_entry'
arch/arm/kernel/ptrace.c:921: error: 'AUDIT_ARCH_ARMEB' undeclared (first use in this function)
arch/arm/kernel/ptrace.c:921: error: (Each undeclared identifier is reported only once
arch/arm/kernel/ptrace.c:921: error: for each function it appears in.)
make[1]: *** [arch/arm/kernel/ptrace.o] Error 1
make: *** [arch/arm/kernel] Error 2

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
This patch is against linux-next 20120215.

 arch/arm/kernel/ptrace.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/kernel/ptrace.c b/arch/arm/kernel/ptrace.c
index e33870f..48970ad 100644
--- a/arch/arm/kernel/ptrace.c
+++ b/arch/arm/kernel/ptrace.c
@@ -23,6 +23,7 @@
 #include <linux/perf_event.h>
 #include <linux/hw_breakpoint.h>
 #include <linux/regset.h>
+#include <linux/audit.h>
 
 #include <asm/pgtable.h>
 #include <asm/system.h>
-- 
1.7.5.4
