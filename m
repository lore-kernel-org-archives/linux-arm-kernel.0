From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Tue,  8 Dec 2009 10:55:38 +0100
Subject: [PATCH] ARM: Convert BUG() to use unreachable()
Message-ID: <1260266138-17684-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the new unreachable() macro instead of for(;;);

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
Cc: David Daney <ddaney@caviumnetworks.com>
---
 arch/arm/kernel/traps.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index 3f361a7..25b50c4 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -681,7 +681,7 @@ void __attribute__((noreturn)) __bug(const char *file, int line)
 	*(int *)0 = 0;
 
 	/* Avoid "noreturn function does return" */
-	for (;;);
+	unreachable();
 }
 EXPORT_SYMBOL(__bug);
 
-- 
1.6.5.2
