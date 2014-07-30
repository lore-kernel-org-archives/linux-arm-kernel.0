From: behanw@converseincode.com (behanw at converseincode.com)
Date: Wed, 30 Jul 2014 16:57:26 -0700
Subject: [PATCH 1/4] arm64: LLVMLinux: Add current_stack_pointer() for arm64
In-Reply-To: <1406764649-20326-1-git-send-email-behanw@converseincode.com>
References: <1406764649-20326-1-git-send-email-behanw@converseincode.com>
Message-ID: <1406764649-20326-2-git-send-email-behanw@converseincode.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Behan Webster <behanw@converseincode.com>

Define a global named register for current_stack_pointer. The use of this new
variable guarantees that both gcc and clang can access this register in C code.

Signed-off-by: Behan Webster <behanw@converseincode.com>
Reviewed-by: Jan-Simon M?ller <dl9pf@gmx.de>
Reviewed-by: Mark Charlebois <charlebm@gmail.com>
---
 arch/arm64/include/asm/thread_info.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
index e40b6d0..e6b6094 100644
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
