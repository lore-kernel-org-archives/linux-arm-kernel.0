From: jg1.han@samsung.com (Jingoo Han)
Date: Wed, 05 Mar 2014 14:34:32 +0900
Subject: [PATCH 1/2] arm64: debug: make local symbols static
Message-ID: <000001cf3834$9667e5c0$c337b140$%han@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make local symbols static, because these are used only in this
file.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 arch/arm64/kernel/debug-monitors.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/debug-monitors.c b/arch/arm64/kernel/debug-monitors.c
index 13f87de..14ba23c 100644
--- a/arch/arm64/kernel/debug-monitors.c
+++ b/arch/arm64/kernel/debug-monitors.c
@@ -189,7 +189,7 @@ static void clear_regs_spsr_ss(struct pt_regs *regs)
 
 /* EL1 Single Step Handler hooks */
 static LIST_HEAD(step_hook);
-DEFINE_RWLOCK(step_hook_lock);
+static DEFINE_RWLOCK(step_hook_lock);
 
 void register_step_hook(struct step_hook *hook)
 {
@@ -276,7 +276,7 @@ static int single_step_handler(unsigned long addr, unsigned int esr,
  * Use reader/writer locks instead of plain spinlock.
  */
 static LIST_HEAD(break_hook);
-DEFINE_RWLOCK(break_hook_lock);
+static DEFINE_RWLOCK(break_hook_lock);
 
 void register_break_hook(struct break_hook *hook)
 {
-- 
1.7.10.4
