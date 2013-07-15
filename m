From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Mon, 15 Jul 2013 20:32:34 -0300
Subject: [PATCH 01/10] clocksource: orion: Add thread-safe API header
In-Reply-To: <1373931163-12670-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1373931163-12670-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1373931163-12670-2-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a header declaration to allow drivers (such as watchdog)
to access this exported API.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 include/linux/time-orion.h | 7 +++++++
 1 file changed, 7 insertions(+)
 create mode 100644 include/linux/time-orion.h

diff --git a/include/linux/time-orion.h b/include/linux/time-orion.h
new file mode 100644
index 0000000..c7e6458
--- /dev/null
+++ b/include/linux/time-orion.h
@@ -0,0 +1,7 @@
+
+#ifndef __TIME_ORION_H
+#define __TIME_ORION_H
+
+void orion_timer_ctrl_clrset(u32 clr, u32 set);
+
+#endif
-- 
1.8.1.5
