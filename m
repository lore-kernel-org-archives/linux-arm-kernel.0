From: linux@roeck-us.net (Guenter Roeck)
Date: Thu,  1 May 2014 08:41:30 -0700
Subject: [RFC PATCH 2/5] arm64: Support reboot through watchdog subsystem
In-Reply-To: <1398958893-30049-1-git-send-email-linux@roeck-us.net>
References: <1398958893-30049-1-git-send-email-linux@roeck-us.net>
Message-ID: <1398958893-30049-3-git-send-email-linux@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The watchdog subsystem provides an API to perform a system reboot.
Use it.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 arch/arm64/kernel/process.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 6391485..29c2bc0 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -42,6 +42,7 @@
 #include <linux/hw_breakpoint.h>
 #include <linux/personality.h>
 #include <linux/notifier.h>
+#include <linux/watchdog.h>
 
 #include <asm/compat.h>
 #include <asm/cacheflush.h>
@@ -144,6 +145,8 @@ void machine_restart(char *cmd)
 	if (arm_pm_restart)
 		arm_pm_restart(reboot_mode, cmd);
 
+	watchdog_do_reboot(reboot_mode, cmd);
+
 	/*
 	 * Whoops - the architecture was unable to reboot.
 	 */
-- 
1.7.9.7
