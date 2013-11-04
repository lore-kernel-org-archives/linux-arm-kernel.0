From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon,  4 Nov 2013 12:00:52 +0100
Subject: [PATCH v4 3/4] ARM: v7-M: drop using mach/entry-macro.S
In-Reply-To: <20131104105836.GI14892@pengutronix.de>
References: <20131104105836.GI14892@pengutronix.de>
Message-ID: <1383562853-17202-3-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The only v7-M platform only has some unused stubs in its
mach/entry-macro.S file. So don't include it which allows efm32 to drop
the file.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/kernel/entry-v7m.S | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/kernel/entry-v7m.S b/arch/arm/kernel/entry-v7m.S
index 52b2643..2260f18 100644
--- a/arch/arm/kernel/entry-v7m.S
+++ b/arch/arm/kernel/entry-v7m.S
@@ -14,8 +14,6 @@
 #include <asm/thread_notify.h>
 #include <asm/v7m.h>
 
-#include <mach/entry-macro.S>
-
 #include "entry-header.S"
 
 #ifdef CONFIG_TRACE_IRQFLAGS
-- 
1.8.4.rc3
