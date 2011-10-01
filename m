From: arnd@arndb.de (Arnd Bergmann)
Date: Sat,  1 Oct 2011 22:03:40 +0200
Subject: [PATCH 08/26] ARM: pxa: move z2 to generic cpu_suspend
In-Reply-To: <1317499438-14058-1-git-send-email-arnd@arndb.de>
References: <1317499438-14058-1-git-send-email-arnd@arndb.de>
Message-ID: <1317499438-14058-9-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The cpu_suspend code on pxa has recently changed, and the
z2 board did not get updated yet. This makes it do the
same as the other boards.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-pxa/z2.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-pxa/z2.c b/arch/arm/mach-pxa/z2.c
index 6c9275a..109447b 100644
--- a/arch/arm/mach-pxa/z2.c
+++ b/arch/arm/mach-pxa/z2.c
@@ -31,6 +31,7 @@
 #include <linux/regulator/machine.h>
 #include <linux/i2c/pxa-i2c.h>
 
+#include <asm/suspend.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
@@ -686,7 +687,7 @@ static void z2_power_off(void)
 	 */
 	PSPR = 0x0;
 	local_irq_disable();
-	pxa27x_cpu_suspend(PWRMODE_DEEPSLEEP, PLAT_PHYS_OFFSET - PAGE_OFFSET);
+	cpu_suspend(PWRMODE_DEEPSLEEP, pxa27x_finish_suspend);
 }
 #else
 #define z2_power_off   NULL
-- 
1.7.5.4
