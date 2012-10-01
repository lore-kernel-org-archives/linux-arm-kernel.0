From: wade_farnsworth@mentor.com (Wade Farnsworth)
Date: Mon, 1 Oct 2012 13:10:08 -0700
Subject: [PATCH] arm: include linux/sched.h in syscall.h
Message-ID: <5069F8A0.5020801@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

task_thread_info() is defined in linux/sched.h.  Explicitly include this
file in arch/arm/include/asm/syscall.h.  This fixes an lttng-modules compile error.

Signed-off-by: Wade Farnsworth <wade_farnsworth@mentor.com>
---
 arch/arm/include/asm/syscall.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/syscall.h b/arch/arm/include/asm/syscall.h
index c334a23..fce38a6 100644
--- a/arch/arm/include/asm/syscall.h
+++ b/arch/arm/include/asm/syscall.h
@@ -8,6 +8,7 @@
 #define _ASM_ARM_SYSCALL_H
 
 #include <linux/err.h>
+#include <linux/sched.h>
 
 extern const unsigned long sys_call_table[];
 
-- 
1.7.0.4
