From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed, 18 Feb 2015 10:02:55 +0100
Subject: [PATCH] ARM: remove empty preprocessor #else branch
Message-ID: <1424250175-1674-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When the patch for e16343c47e42 (ARM: 8160/1: drop warning about
return_address not using unwind tables) was created there was still more
code in said branch. Probably this simplification was just missed during
conflict resolution when the patch was applied.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/kernel/return_address.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm/kernel/return_address.c b/arch/arm/kernel/return_address.c
index 24b4a04846eb..36ed35073289 100644
--- a/arch/arm/kernel/return_address.c
+++ b/arch/arm/kernel/return_address.c
@@ -56,8 +56,6 @@ void *return_address(unsigned int level)
 		return NULL;
 }
 
-#else /* if defined(CONFIG_FRAME_POINTER) && !defined(CONFIG_ARM_UNWIND) */
-
-#endif /* if defined(CONFIG_FRAME_POINTER) && !defined(CONFIG_ARM_UNWIND) / else */
+#endif /* if defined(CONFIG_FRAME_POINTER) && !defined(CONFIG_ARM_UNWIND) */
 
 EXPORT_SYMBOL_GPL(return_address);
-- 
2.1.4
