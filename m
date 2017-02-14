From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 14 Feb 2017 22:32:58 +0100
Subject: [PATCH] arm64: include asm/assembler.h in entry-ftrace.S
Message-ID: <20170214213314.2910910-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In a randconfig build I ran into this build error:

arch/arm64/kernel/entry-ftrace.S: Assembler messages:
arch/arm64/kernel/entry-ftrace.S:101: Error: unknown mnemonic `ldr_l' -- `ldr_l x2,ftrace_trace_function'

The macro is defined in asm/assembler.h, so we should include that file.

Fixes: 829d2bd13392 ("arm64: entry-ftrace.S: avoid open-coded {adr,ldr}_l")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm64/kernel/entry-ftrace.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/kernel/entry-ftrace.S b/arch/arm64/kernel/entry-ftrace.S
index 8f1905b795f3..e1be42e11ff5 100644
--- a/arch/arm64/kernel/entry-ftrace.S
+++ b/arch/arm64/kernel/entry-ftrace.S
@@ -10,6 +10,7 @@
  */
 
 #include <linux/linkage.h>
+#include <asm/assembler.h>
 #include <asm/ftrace.h>
 #include <asm/insn.h>
 
-- 
2.9.0
