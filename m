From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 20 Feb 2015 13:53:13 +0000
Subject: [PATCH] arm64: Guard asm/assembler.h against multiple inclusions
Message-ID: <1424440393-28458-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

asm/assembler.h lacks the usual guard against multiple inclusion,
leading to a compilation failure if it is accidentally included
twice.

Using the classic #ifndef/#define/#endif construct solves the issue.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/include/asm/assembler.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index 5901480..750bac4 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -20,6 +20,9 @@
 #error "Only include this from assembly code"
 #endif
 
+#ifndef __ASM_ASSEMBLER_H
+#define __ASM_ASSEMBLER_H
+
 #include <asm/ptrace.h>
 #include <asm/thread_info.h>
 
@@ -155,3 +158,5 @@ lr	.req	x30		// link register
 #endif
 	orr	\rd, \lbits, \hbits, lsl #32
 	.endm
+
+#endif	/* __ASM_ASSEMBLER_H */
-- 
2.1.4
