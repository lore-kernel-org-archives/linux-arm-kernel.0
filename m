From: shc_work@mail.ru (Alexander Shiyan)
Date: Sat, 26 Apr 2014 09:32:16 +0400
Subject: [PATCH RESEND] clocksource: nspire: Fix compiler warning
Message-ID: <1398490336-19943-1-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CC      drivers/clocksource/zevio-timer.o
drivers/clocksource/zevio-timer.c:215:1: warning: comparison of distinct pointer types lacks a cast [enabled by default]

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 drivers/clocksource/zevio-timer.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/zevio-timer.c b/drivers/clocksource/zevio-timer.c
index ca81809..7ce4421 100644
--- a/drivers/clocksource/zevio-timer.c
+++ b/drivers/clocksource/zevio-timer.c
@@ -212,4 +212,9 @@ error_free:
 	return ret;
 }
 
-CLOCKSOURCE_OF_DECLARE(zevio_timer, "lsi,zevio-timer", zevio_timer_add);
+static void __init zevio_timer_init(struct device_node *node)
+{
+	BUG_ON(zevio_timer_add(node));
+}
+
+CLOCKSOURCE_OF_DECLARE(zevio_timer, "lsi,zevio-timer", zevio_timer_init);
-- 
1.8.3.2
