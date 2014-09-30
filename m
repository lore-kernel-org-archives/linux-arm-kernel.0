From: linux@roeck-us.net (Guenter Roeck)
Date: Tue, 30 Sep 2014 11:00:44 -0700
Subject: [RFC PATCH 04/16] arm: support poweroff through poweroff handler call
 chain
In-Reply-To: <1412100056-15517-1-git-send-email-linux@roeck-us.net>
References: <1412100056-15517-1-git-send-email-linux@roeck-us.net>
Message-ID: <1412100056-15517-5-git-send-email-linux@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The kernel core now supports a poweroff handler call chain
to remove power from the system. Call it if pm_power_off
is set to NULL.

Cc: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 arch/arm/kernel/process.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index 250b6f6..848c578 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -207,6 +207,8 @@ void machine_power_off(void)
 
 	if (pm_power_off)
 		pm_power_off();
+	else
+		do_kernel_poweroff();
 }
 
 /*
-- 
1.9.1
