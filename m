From: tklauser@distanz.ch (Tobias Klauser)
Date: Mon,  5 Jan 2015 15:23:48 +0100
Subject: [PATCH] arm64: Remove unused prepare_to_copy()
Message-ID: <1420467828-16882-1-git-send-email-tklauser@distanz.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

prepare_to_copy() was removed from all architectures supported at that
time in commit 55ccf3fe3f9a ("fork: move the real prepare_to_copy()
users to arch_dup_task_struct()"). Remove it from arm64 as well.

Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
 arch/arm64/include/asm/processor.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index 286b1be..f131a98 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -123,9 +123,6 @@ struct task_struct;
 /* Free all resources held by a thread. */
 extern void release_thread(struct task_struct *);
 
-/* Prepare to copy thread state - unlazy all lazy status */
-#define prepare_to_copy(tsk)	do { } while (0)
-
 unsigned long get_wchan(struct task_struct *p);
 
 #define cpu_relax()			barrier()
-- 
2.2.1
