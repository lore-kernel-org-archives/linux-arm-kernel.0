From: linux@roeck-us.net (Guenter Roeck)
Date: Mon,  4 Aug 2014 18:48:58 -0700
Subject: [PATCH v6 7/7] arm/arm64: Unexport restart handlers
In-Reply-To: <1407203338-12915-1-git-send-email-linux@roeck-us.net>
References: <1407203338-12915-1-git-send-email-linux@roeck-us.net>
Message-ID: <1407203338-12915-8-git-send-email-linux@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Implementing a restart handler in a module don't make sense
as there would be no guarantee that the module is loaded when
a restart is needed. Unexport arm_pm_restart to ensure that
no one gets the idea to do it anyway.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Acked-by: Heiko Stuebner <heiko@sntech.de>
---
v6: No change
v5: No change
v4: No change
v3: No change
v2: No change

 arch/arm/kernel/process.c   | 1 -
 arch/arm64/kernel/process.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index 84ca0d5..27bdf11 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -125,7 +125,6 @@ void (*pm_power_off)(void);
 EXPORT_SYMBOL(pm_power_off);
 
 void (*arm_pm_restart)(enum reboot_mode reboot_mode, const char *cmd) = null_restart;
-EXPORT_SYMBOL_GPL(arm_pm_restart);
 
 /*
  * This is our default idle handler.
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 9591e60..f5fddff 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -92,7 +92,6 @@ void (*pm_power_off)(void);
 EXPORT_SYMBOL_GPL(pm_power_off);
 
 void (*arm_pm_restart)(enum reboot_mode reboot_mode, const char *cmd);
-EXPORT_SYMBOL_GPL(arm_pm_restart);
 
 /*
  * This is our default idle handler.
-- 
1.9.1
