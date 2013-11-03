From: b.brezillon@overkiz.com (Boris BREZILLON)
Date: Sun,  3 Nov 2013 18:52:42 +0100
Subject: [PATCH 1/3] watchdog: at91sam9_wdt: fix secs_to_ticks
In-Reply-To: <1383501164-8111-1-git-send-email-b.brezillon@overkiz.com>
References: <1383501164-8111-1-git-send-email-b.brezillon@overkiz.com>
Message-ID: <1383501164-8111-2-git-send-email-b.brezillon@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the secs_to_ticks macro in case 0 is passed as an argument.

Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>
---
 drivers/watchdog/at91sam9_wdt.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/at91sam9_wdt.c b/drivers/watchdog/at91sam9_wdt.c
index 9bd089e..65f4691 100644
--- a/drivers/watchdog/at91sam9_wdt.c
+++ b/drivers/watchdog/at91sam9_wdt.c
@@ -51,7 +51,7 @@
 #define ticks_to_hz_rounddown(t)	((((t) + 1) * HZ) >> 8)
 #define ticks_to_hz_roundup(t)		(((((t) + 1) * HZ) + 255) >> 8)
 #define ticks_to_secs(t)		(((t) + 1) >> 8)
-#define secs_to_ticks(s)		(((s) << 8) - 1)
+#define secs_to_ticks(s)		((s) ? (((s) << 8) - 1) : 0)
 
 #define WDT_MR_RESET	0x3FFF2FFF
 
-- 
1.7.9.5
