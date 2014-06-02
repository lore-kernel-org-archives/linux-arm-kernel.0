From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon,  2 Jun 2014 11:54:12 +0200
Subject: [PATCH] ARM: drop warning about return_address not using unwind tables
Message-ID: <1401702852-30664-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The warning was introduced in 2009 (commit 4bf1fa5a34aa ([ARM] 5613/1:
implement CALLER_ADDRESSx)). The only result is that CALLER_ADDRESSx for
x > 1 returns NULL which doesn't do much harm.

The drawback of implementing the use of unwind tables for the kernel
tracers is that much of the unwinder code would need to be marked as not
traceable.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/kernel/return_address.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/kernel/return_address.c b/arch/arm/kernel/return_address.c
index fafedd86885d..827d946d2be4 100644
--- a/arch/arm/kernel/return_address.c
+++ b/arch/arm/kernel/return_address.c
@@ -59,10 +59,6 @@ void *return_address(unsigned int level)
 
 #else /* if defined(CONFIG_FRAME_POINTER) && !defined(CONFIG_ARM_UNWIND) */
 
-#if defined(CONFIG_ARM_UNWIND)
-#warning "TODO: return_address should use unwind tables"
-#endif
-
 void *return_address(unsigned int level)
 {
 	return NULL;
-- 
2.0.0.rc2
