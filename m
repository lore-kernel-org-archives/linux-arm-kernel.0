From: linux@roeck-us.net (Guenter Roeck)
Date: Mon,  4 Aug 2014 18:48:55 -0700
Subject: [PATCH v6 4/7] power/restart: Call machine_restart instead of
 arm_pm_restart
In-Reply-To: <1407203338-12915-1-git-send-email-linux@roeck-us.net>
References: <1407203338-12915-1-git-send-email-linux@roeck-us.net>
Message-ID: <1407203338-12915-5-git-send-email-linux@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

machine_restart is supported on non-ARM platforms, and and ultimately calls
arm_pm_restart, so dont call arm_pm_restart directly but use the more
generic function.

Cc: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Acked-by: Heiko Stuebner <heiko@sntech.de>
---
v6: No change.
v5: No change.
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
