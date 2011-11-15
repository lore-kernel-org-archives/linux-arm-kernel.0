From: akpm@linux-foundation.org (akpm at linux-foundation.org)
Date: Tue, 15 Nov 2011 14:51:55 -0800
Subject: [patch 2/2] arm, exec: remove redundant set_fs(USER_DS)
Message-ID: <201111152251.pAFMpt5F031939@wpaz1.hot.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mathias Krause <minipli@googlemail.com>
Subject: arm, exec: remove redundant set_fs(USER_DS)

The address limit is already set in flush_old_exec() so this
set_fs(USER_DS) is redundant.

Signed-off-by: Mathias Krause <minipli@googlemail.com>
Cc: Russell King <rmk@arm.linux.org.uk>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 arch/arm/include/asm/processor.h |    1 -
 1 file changed, 1 deletion(-)

diff -puN arch/arm/include/asm/processor.h~arm-exec-remove-redundant-set_fsuser_ds arch/arm/include/asm/processor.h
--- a/arch/arm/include/asm/processor.h~arm-exec-remove-redundant-set_fsuser_ds
+++ a/arch/arm/include/asm/processor.h
@@ -55,7 +55,6 @@ struct thread_struct {
 #define start_thread(regs,pc,sp)					\
 ({									\
 	unsigned long *stack = (unsigned long *)sp;			\
-	set_fs(USER_DS);						\
 	memset(regs->uregs, 0, sizeof(regs->uregs));			\
 	if (current->personality & ADDR_LIMIT_32BIT)			\
 		regs->ARM_cpsr = USR_MODE;				\
_
