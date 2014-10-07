From: linux@roeck-us.net (Guenter Roeck)
Date: Mon,  6 Oct 2014 22:28:34 -0700
Subject: [PATCH 32/44] arm64: psci: Register with kernel poweroff handler
In-Reply-To: <1412659726-29957-1-git-send-email-linux@roeck-us.net>
References: <1412659726-29957-1-git-send-email-linux@roeck-us.net>
Message-ID: <1412659726-29957-33-git-send-email-linux@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Register with kernel poweroff handler instead of setting pm_power_off
directly.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 arch/arm64/kernel/psci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/psci.c b/arch/arm64/kernel/psci.c
index 5539547..c1f3d09 100644
--- a/arch/arm64/kernel/psci.c
+++ b/arch/arm64/kernel/psci.c
@@ -286,7 +286,7 @@ static int __init psci_0_2_init(struct device_node *np)
 
 	arm_pm_restart = psci_sys_reset;
 
-	pm_power_off = psci_sys_poweroff;
+	register_poweroff_handler_simple(psci_sys_poweroff, 128);
 
 out_put_node:
 	of_node_put(np);
-- 
1.9.1
