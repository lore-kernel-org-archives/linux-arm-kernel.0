From: jszhang@marvell.com (Jisheng Zhang)
Date: Thu, 12 Nov 2015 20:04:44 +0800
Subject: [PATCH 3/3] arm64: suspend: make hw_breakpoint_restore static
In-Reply-To: <1447329884-1644-1-git-send-email-jszhang@marvell.com>
References: <1447329884-1644-1-git-send-email-jszhang@marvell.com>
Message-ID: <1447329884-1644-4-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hw_breakpoint_restore is only used within suspend.c, so it can be
declared static.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 arch/arm64/kernel/suspend.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/suspend.c b/arch/arm64/kernel/suspend.c
index 40f7b33..fce95e1 100644
--- a/arch/arm64/kernel/suspend.c
+++ b/arch/arm64/kernel/suspend.c
@@ -41,7 +41,7 @@ void notrace __cpu_suspend_save(struct cpu_suspend_ctx *ptr,
  * time the notifier runs debug exceptions might have been enabled already,
  * with HW breakpoints registers content still in an unknown state.
  */
-void (*hw_breakpoint_restore)(void *);
+static void (*hw_breakpoint_restore)(void *);
 void __init cpu_suspend_set_dbg_restorer(void (*hw_bp_restore)(void *))
 {
 	/* Prevent multiple restore hook initializations */
-- 
2.6.2
