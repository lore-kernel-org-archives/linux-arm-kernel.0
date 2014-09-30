From: linux@roeck-us.net (Guenter Roeck)
Date: Tue, 30 Sep 2014 11:00:50 -0700
Subject: [RFC PATCH 10/16] mips: support poweroff through poweroff handler
 call chain
In-Reply-To: <1412100056-15517-1-git-send-email-linux@roeck-us.net>
References: <1412100056-15517-1-git-send-email-linux@roeck-us.net>
Message-ID: <1412100056-15517-11-git-send-email-linux@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The kernel core now supports a poweroff handler call chain
to remove power from the system. Call it if pm_power_off
is set to NULL.

Cc: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 arch/mips/kernel/reset.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/kernel/reset.c b/arch/mips/kernel/reset.c
index 07fc524..c3391d7 100644
--- a/arch/mips/kernel/reset.c
+++ b/arch/mips/kernel/reset.c
@@ -41,4 +41,6 @@ void machine_power_off(void)
 {
 	if (pm_power_off)
 		pm_power_off();
+	else
+		do_kernel_poweroff();
 }
-- 
1.9.1
