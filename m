From: linux@roeck-us.net (Guenter Roeck)
Date: Sun, 13 Jul 2014 08:30:28 -0700
Subject: [PATCH v4 4/7] power/restart: Call machine_restart instead of
 arm_pm_restart
In-Reply-To: <1405265431-4561-1-git-send-email-linux@roeck-us.net>
References: <1405265431-4561-1-git-send-email-linux@roeck-us.net>
Message-ID: <1405265431-4561-5-git-send-email-linux@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

machine_restart is supported on non-ARM platforms, and and ultimately calls
arm_pm_restart, so dont call arm_pm_restart directly but use the more
generic function.

Cc: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v4: No change.
v3: No change.
v2: Added patch.

 drivers/power/reset/restart-poweroff.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/power/reset/restart-poweroff.c b/drivers/power/reset/restart-poweroff.c
index 5758033..47f10eb 100644
--- a/drivers/power/reset/restart-poweroff.c
+++ b/drivers/power/reset/restart-poweroff.c
@@ -20,7 +20,8 @@
 
 static void restart_poweroff_do_poweroff(void)
 {
-	arm_pm_restart(REBOOT_HARD, NULL);
+	reboot_mode = REBOOT_HARD;
+	machine_restart(NULL);
 }
 
 static int restart_poweroff_probe(struct platform_device *pdev)
-- 
1.9.1
