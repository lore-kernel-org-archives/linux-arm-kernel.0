From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed,  2 Mar 2011 16:53:11 +0000
Subject: [RFC PATCH 05/20] ARM: tegra: remove stubbed twd_timer_setup call
In-Reply-To: <1299084806-16546-1-git-send-email-marc.zyngier@arm.com>
References: <1299084806-16546-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1299084806-16546-6-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc: Colin Cross <ccross@android.com>
Cc: Erik Gilling <konkers@android.com>
Cc: Olof Johansson <olof@lixom.net>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/mach-tegra/localtimer.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-tegra/localtimer.c b/arch/arm/mach-tegra/localtimer.c
index e91d681..aaabad8 100644
--- a/arch/arm/mach-tegra/localtimer.c
+++ b/arch/arm/mach-tegra/localtimer.c
@@ -9,10 +9,9 @@
  * published by the Free Software Foundation.
  */
 #include <linux/init.h>
-#include <linux/smp.h>
 #include <linux/clockchips.h>
+
 #include <asm/irq.h>
-#include <asm/smp_twd.h>
 #include <asm/localtimer.h>
 
 /*
@@ -21,6 +20,5 @@
 int __cpuinit local_timer_setup(struct clock_event_device *evt)
 {
 	evt->irq = IRQ_LOCALTIMER;
-	twd_timer_setup(evt);
 	return 0;
 }
-- 
1.7.0.4
