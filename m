From: miles.chen@mediatek.com (miles.chen at mediatek.com)
Date: Thu, 25 Feb 2016 11:44:34 +0800
Subject: [PATCH] arm64/mm: remove unnecessary boundary check
Message-ID: <1456371874-19826-1-git-send-email-miles.chen@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Miles Chen <miles.chen@mediatek.com>

Remove the unnecessary boundary check since there is a huge
gap between user and kernel address that they would never overlap.
(arm64 does not have enough levels of page tables to cover 64-bit
virtual address)

See Documentation/arm64/memory.txt

Signed-off-by: Miles Chen <miles.chen@mediatek.com>
---
 arch/arm64/mm/init.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index f3b061e..4579604 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -343,8 +343,6 @@ void __init mem_init(void)
 #ifdef CONFIG_COMPAT
 	BUILD_BUG_ON(TASK_SIZE_32			> TASK_SIZE_64);
 #endif
-	BUILD_BUG_ON(TASK_SIZE_64			> MODULES_VADDR);
-	BUG_ON(TASK_SIZE_64				> MODULES_VADDR);
 
 	if (PAGE_SIZE >= 16384 && get_num_physpages() <= 128) {
 		extern int sysctl_overcommit_memory;
-- 
1.9.1
