From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon, 16 Jul 2012 22:07:06 +0200
Subject: [PATCH] ARM: imx: add missing item to the list of clock event modes
Message-ID: <1342469226-12293-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This prevents an out-of-bounds access to the clock_event_mode_label when
debugging.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
Hello,

I consider this to be an uncritical fix as it's only relevant with DEBUG
#defined.

Best regards
Uwe
 arch/arm/plat-mxc/time.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/plat-mxc/time.c b/arch/arm/plat-mxc/time.c
index 00e8e65..a17abcf 100644
--- a/arch/arm/plat-mxc/time.c
+++ b/arch/arm/plat-mxc/time.c
@@ -160,7 +160,8 @@ static const char *clock_event_mode_label[] = {
 	[CLOCK_EVT_MODE_PERIODIC] = "CLOCK_EVT_MODE_PERIODIC",
 	[CLOCK_EVT_MODE_ONESHOT]  = "CLOCK_EVT_MODE_ONESHOT",
 	[CLOCK_EVT_MODE_SHUTDOWN] = "CLOCK_EVT_MODE_SHUTDOWN",
-	[CLOCK_EVT_MODE_UNUSED]   = "CLOCK_EVT_MODE_UNUSED"
+	[CLOCK_EVT_MODE_UNUSED]   = "CLOCK_EVT_MODE_UNUSED",
+	[CLOCK_EVT_MODE_RESUME]   = "CLOCK_EVT_MODE_RESUME",
 };
 #endif /* DEBUG */
 
-- 
1.7.10.4
