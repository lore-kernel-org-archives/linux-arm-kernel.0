From: gang.chen@asianux.com (Chen Gang)
Date: Mon, 20 May 2013 14:48:05 +0800
Subject: [PATCH] arm64: kernel: compiling issue,
 need 'EXPORT_SYMBOL_GPL(read_current_timer)'
Message-ID: <5199C725.8050102@asianux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Need 'EXPORT_SYMBOL_GPL(read_current_timer)' if build with allmodconfig.

The related error:
  ERROR: "read_current_timer" [lib/rbtree_test.ko] undefined!
  ERROR: "read_current_timer" [lib/interval_tree_test.ko] undefined!
  ERROR: "read_current_timer" [fs/ext4/ext4.ko] undefined!
  ERROR: "read_current_timer" [crypto/tcrypt.ko] undefined!


Signed-off-by: Chen Gang <gang.chen@asianux.com>
---
 arch/arm64/kernel/time.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm64/kernel/time.c b/arch/arm64/kernel/time.c
index a551f88..7fcba80 100644
--- a/arch/arm64/kernel/time.c
+++ b/arch/arm64/kernel/time.c
@@ -73,6 +73,7 @@ int read_current_timer(unsigned long *timer_value)
 	*timer_value = arch_timer_read_counter();
 	return 0;
 }
+EXPORT_SYMBOL_GPL(read_current_timer);
 
 void __init time_init(void)
 {
-- 
1.7.7.6
