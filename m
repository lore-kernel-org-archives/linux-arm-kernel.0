From: linux@roeck-us.net (Guenter Roeck)
Date: Tue, 30 Sep 2014 11:00:51 -0700
Subject: [RFC PATCH 11/16] sh: support poweroff through poweroff handler call
 chain
In-Reply-To: <1412100056-15517-1-git-send-email-linux@roeck-us.net>
References: <1412100056-15517-1-git-send-email-linux@roeck-us.net>
Message-ID: <1412100056-15517-12-git-send-email-linux@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The kernel core now supports a poweroff handler call chain
to remove power from the system. Call it if pm_power_off
is set to NULL.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 arch/sh/kernel/reboot.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/sh/kernel/reboot.c b/arch/sh/kernel/reboot.c
index 04afe5b..8e68926 100644
--- a/arch/sh/kernel/reboot.c
+++ b/arch/sh/kernel/reboot.c
@@ -53,6 +53,8 @@ static void native_machine_power_off(void)
 {
 	if (pm_power_off)
 		pm_power_off();
+	else
+		do_kernel_poweroff();
 }
 
 static void native_machine_halt(void)
-- 
1.9.1
