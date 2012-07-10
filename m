From: dinguyen@altera.com (dinguyen at altera.com)
Date: Tue, 10 Jul 2012 16:39:41 -0500
Subject: [PATCH v2 2/2] arm: picoxcell: Make use of dw_apb_timer_of
In-Reply-To: <1341956381-496-1-git-send-email-dinguyen@altera.com>
References: <1341956381-496-1-git-send-email-dinguyen@altera.com>
Message-ID: <1341956381-496-2-git-send-email-dinguyen@altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <dinguyen@altera.com>

Make use of the move dw_apb_timer_of device tree implementation in
clocksource.

Signed-off-by: Pavel Machek <pavel@denx.de>
Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
---
 arch/arm/mach-picoxcell/Makefile |    1 -
 arch/arm/mach-picoxcell/common.c |    3 ++-
 arch/arm/mach-picoxcell/common.h |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-picoxcell/Makefile b/arch/arm/mach-picoxcell/Makefile
index e5ec4a8..8e39f80 100644
--- a/arch/arm/mach-picoxcell/Makefile
+++ b/arch/arm/mach-picoxcell/Makefile
@@ -1,2 +1 @@
 obj-y	:= common.o
-obj-y	+= time.o
diff --git a/arch/arm/mach-picoxcell/common.c b/arch/arm/mach-picoxcell/common.c
index a2e8ae8..8f9a0b4 100644
--- a/arch/arm/mach-picoxcell/common.c
+++ b/arch/arm/mach-picoxcell/common.c
@@ -14,6 +14,7 @@
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
+#include <linux/dw_apb_timer.h>
 
 #include <asm/mach/arch.h>
 #include <asm/hardware/vic.h>
@@ -97,7 +98,7 @@ DT_MACHINE_START(PICOXCELL, "Picochip picoXcell")
 	.nr_irqs	= NR_IRQS_LEGACY,
 	.init_irq	= picoxcell_init_irq,
 	.handle_irq	= vic_handle_irq,
-	.timer		= &picoxcell_timer,
+	.timer		= &dw_apb_timer,
 	.init_machine	= picoxcell_init_machine,
 	.dt_compat	= picoxcell_dt_match,
 	.restart	= picoxcell_wdt_restart,
diff --git a/arch/arm/mach-picoxcell/common.h b/arch/arm/mach-picoxcell/common.h
index 83d55ab..a65cb02 100644
--- a/arch/arm/mach-picoxcell/common.h
+++ b/arch/arm/mach-picoxcell/common.h
@@ -12,6 +12,6 @@
 
 #include <asm/mach/time.h>
 
-extern struct sys_timer picoxcell_timer;
+extern struct sys_timer dw_apb_timer;
 
 #endif /* __PICOXCELL_COMMON_H__ */
-- 
1.7.9.5
