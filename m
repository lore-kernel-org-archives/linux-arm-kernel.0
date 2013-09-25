From: liuj97@gmail.com (Jiang Liu)
Date: Wed, 25 Sep 2013 18:44:27 +0800
Subject: [PATCH v1 7/7] jump_label: use defined macros instead of hard-coding
 for better readability
In-Reply-To: <1380105868-31985-1-git-send-email-liuj97@gmail.com>
References: <1380105868-31985-1-git-send-email-liuj97@gmail.com>
Message-ID: <1380105868-31985-8-git-send-email-liuj97@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jiang Liu <jiang.liu@huawei.com>

Use macro JUMP_LABEL_TRUE_BRANCH instead of hard-coding for better
readability.

Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
Cc: Jiang Liu <liuj97@gmail.com>
---
 include/linux/jump_label.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/jump_label.h b/include/linux/jump_label.h
index a507907..b697fbd 100644
--- a/include/linux/jump_label.h
+++ b/include/linux/jump_label.h
@@ -116,7 +116,8 @@ extern void static_key_slow_dec(struct static_key *key);
 extern void jump_label_apply_nops(struct module *mod);
 
 #define STATIC_KEY_INIT_TRUE ((struct static_key) \
-	{ .enabled = ATOMIC_INIT(1), .entries = (void *)1 })
+	{ .enabled = ATOMIC_INIT(1), \
+	  .entries = (void *)JUMP_LABEL_TRUE_BRANCH })
 #define STATIC_KEY_INIT_FALSE ((struct static_key) \
 	{ .enabled = ATOMIC_INIT(0), .entries = (void *)0 })
 
-- 
1.8.1.2
