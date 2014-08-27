From: behanw@converseincode.com (behanw at converseincode.com)
Date: Tue, 26 Aug 2014 21:29:29 -0700
Subject: [PATCH V2 1/6] arm64: LLVMLinux: Add current_stack_pointer() for arm64
In-Reply-To: <1409113774-3172-1-git-send-email-behanw@converseincode.com>
References: <20140826141608.GT23445@arm.com>
 <1409113774-3172-1-git-send-email-behanw@converseincode.com>
Message-ID: <1409113774-3172-2-git-send-email-behanw@converseincode.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Behan Webster <behanw@converseincode.com>

Define a global named register for current_stack_pointer. The use of this new
variable guarantees that both gcc and clang can access this register in C code.

Signed-off-by: Behan Webster <behanw@converseincode.com>
Reviewed-by: Jan-Simon M?ller <dl9pf@gmx.de>
Reviewed-by: Mark Charlebois <charlebm@gmail.com>
Reviewed-by: Olof Johansson <olof@lixom.net>
Acked-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/thread_info.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
index 45108d8..356e037 100644
--- a/arch/arm64/include/asm/thread_info.h
+++ b/arch/arm64/include/asm/thread_info.h
@@ -69,6 +69,11 @@ struct thread_info {
 #define init_stack		(init_thread_union.stack)
 
 /*
+ * how to get the current stack pointer from C
+ */
+register unsigned long current_stack_pointer asm ("sp");
+
+/*
  * how to get the thread information struct from C
  */
 static inline struct thread_info *current_thread_info(void) __attribute_const__;
-- 
1.9.1
