From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 19 Apr 2016 10:31:19 +0100
Subject: [PATCH] arm64: asm: remove unused push/pop macros
Message-ID: <1461058279-19227-1-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We haven't used the push/pop macros for a while now, as it's typically
better to use immediate offsets for batches of accesses to the stack, as
we now do in the entry assembly for the kernel and hyp code.

Remove the unused macros.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: James Morse <james.morse@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/assembler.h | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index 70f7b9e..972fb55 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -27,18 +27,6 @@
 #include <asm/thread_info.h>
 
 /*
- * Stack pushing/popping (register pairs only). Equivalent to store decrement
- * before, load increment after.
- */
-	.macro	push, xreg1, xreg2
-	stp	\xreg1, \xreg2, [sp, #-16]!
-	.endm
-
-	.macro	pop, xreg1, xreg2
-	ldp	\xreg1, \xreg2, [sp], #16
-	.endm
-
-/*
  * Enable and disable interrupts.
  */
 	.macro	disable_irq
-- 
1.9.1
