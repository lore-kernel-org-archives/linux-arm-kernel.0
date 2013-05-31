From: arnd@arndb.de (Arnd Bergmann)
Date: Sat,  1 Jun 2013 00:22:43 +0200
Subject: [PATCH 06/15] cpuidle: calxeda: select ARM_CPU_SUSPEND
In-Reply-To: <1370038972-2318779-1-git-send-email-arnd@arndb.de>
References: <1370038972-2318779-1-git-send-email-arnd@arndb.de>
Message-ID: <1370038972-2318779-7-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Like other ARM specific drivers, this one requires ARM_CPU_SUSPEND,
as shown by this linker error:

drivers/built-in.o: In function `calxeda_pwrdown_idle':
drivers/cpuidle/cpuidle-calxeda.c:84: undefined reference to `cpu_suspend'
drivers/cpuidle/cpuidle-calxeda.c:86: undefined reference to `cpu_resume'

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Rafael J. Wysocki <rjw@sisk.pl>
Acked-by: Rob Herring <rob.herring@calxeda.com>
Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-pm at vger.kernel.org
---
 drivers/cpuidle/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpuidle/Kconfig b/drivers/cpuidle/Kconfig
index c4cc27e..e21cdfa 100644
--- a/drivers/cpuidle/Kconfig
+++ b/drivers/cpuidle/Kconfig
@@ -36,6 +36,7 @@ if CPU_IDLE
 config CPU_IDLE_CALXEDA
 	bool "CPU Idle Driver for Calxeda processors"
 	depends on ARCH_HIGHBANK
+	select ARM_CPU_SUSPEND
 	help
 	  Select this to enable cpuidle on Calxeda processors.
 
-- 
1.8.1.2
