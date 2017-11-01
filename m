From: xieyisheng1@huawei.com (Yisheng Xie)
Date: Wed, 1 Nov 2017 17:46:19 +0800
Subject: [PATCH] arm64: suspend: remove useless included file
Message-ID: <1509529579-3467-1-git-send-email-xieyisheng1@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After commit 9e8e865bbe29 ("arm64: unify idmap removal"), we no need to
flush tlb in suspend.c, so the included file tlbflush.h can be removed.

Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
---
 arch/arm64/kernel/suspend.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/kernel/suspend.c b/arch/arm64/kernel/suspend.c
index 1e3be90..5794326 100644
--- a/arch/arm64/kernel/suspend.c
+++ b/arch/arm64/kernel/suspend.c
@@ -11,7 +11,6 @@
 #include <asm/mmu_context.h>
 #include <asm/smp_plat.h>
 #include <asm/suspend.h>
-#include <asm/tlbflush.h>
 
 /*
  * This is allocated by cpu_suspend_init(), and used to store a pointer to
-- 
1.7.12.4
