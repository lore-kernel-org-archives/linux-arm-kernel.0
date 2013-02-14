From: fabio.porcedda@gmail.com (Fabio Porcedda)
Date: Thu, 14 Feb 2013 09:14:23 +0100
Subject: [PATCH v9 1/8] watchdog: core: add static to
 watchdog_check_min_max_timeout()
In-Reply-To: <1360829670-10418-1-git-send-email-fabio.porcedda@gmail.com>
References: <1360829670-10418-1-git-send-email-fabio.porcedda@gmail.com>
Message-ID: <1360829670-10418-2-git-send-email-fabio.porcedda@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Because is an internal function is better to use static to help
the compiler.

Signed-off-by: Fabio Porcedda <fabio.porcedda@gmail.com>
Cc: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog at vger.kernel.org
---
 drivers/watchdog/watchdog_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/watchdog_core.c b/drivers/watchdog/watchdog_core.c
index a74a3ef..94590f6 100644
--- a/drivers/watchdog/watchdog_core.c
+++ b/drivers/watchdog/watchdog_core.c
@@ -43,7 +43,7 @@
 static DEFINE_IDA(watchdog_ida);
 static struct class *watchdog_class;
 
-void watchdog_check_min_max_timeout(struct watchdog_device *wdd)
+static void watchdog_check_min_max_timeout(struct watchdog_device *wdd)
 {
 	/*
 	 * Check that we have valid min and max timeout values, if
-- 
1.8.1.1
