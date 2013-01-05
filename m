From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Sat,  5 Jan 2013 10:38:41 +0800
Subject: [v3 PATCH 1/9] watchdog: add the function watchdog_is_open
In-Reply-To: <1357353529-20901-1-git-send-email-wenyou.yang@atmel.com>
References: <1357353529-20901-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <1357353529-20901-2-git-send-email-wenyou.yang@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the function watchdog_is_open to check whether or not
the /dev/watchdog? is opened

Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
---
 include/linux/watchdog.h |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/watchdog.h b/include/linux/watchdog.h
index e40cc2b..7ea4465 100644
--- a/include/linux/watchdog.h
+++ b/include/linux/watchdog.h
@@ -111,6 +111,14 @@ static inline bool watchdog_active(struct watchdog_device *wdd)
 	return test_bit(WDOG_ACTIVE, &wdd->status);
 }
 
+/* Use the following function to check whether or not
+ * the /dev/watchdog? is opened
+ */
+static inline bool watchdog_is_open(struct watchdog_device *wddev)
+{
+	return test_bit(WDOG_DEV_OPEN, &wddev->status);
+}
+
 /* Use the following function to set the nowayout feature */
 static inline void watchdog_set_nowayout(struct watchdog_device *wdd, bool nowayout)
 {
-- 
1.7.9.5
