From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Thu, 21 Jul 2011 14:57:51 +0200
Subject: [PATCH 4/5] ARM: s3c64xx: Save/restore S3C64XX_MODEM_MIFPCON on
 suspend/resume to preserve LCD bypass state.
Message-ID: <mailman.46.1311955629.20020.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch makes sure that the LCD bypass state is preserved during sleep mode.
It achieves this by saving the S3C64XX_MODEM_MIFPCON register, which is not
handled by any other code currently.

---
 arch/arm/mach-s3c64xx/pm.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/pm.c b/arch/arm/mach-s3c64xx/pm.c
index 9756321..58899b0 100644
--- a/arch/arm/mach-s3c64xx/pm.c
+++ b/arch/arm/mach-s3c64xx/pm.c
@@ -30,6 +30,7 @@
 #include <mach/regs-clock.h>
 #include <mach/regs-syscon-power.h>
 #include <mach/regs-gpio-memport.h>
+#include <mach/regs-modem.h>
 
 #ifdef CONFIG_S3C_PM_DEBUG_LED_SMDK
 void s3c_pm_debug_smdkled(u32 set, u32 clear)
@@ -88,6 +89,7 @@ static struct sleep_save misc_save[] = {
 	SAVE_ITEM(S3C64XX_MEM1CONSLP),
 
 	SAVE_ITEM(S3C64XX_SDMA_SEL),
+	SAVE_ITEM(S3C64XX_MODEM_MIFPCON),
 };
 
 void s3c_pm_configure_extint(void)
-- 
1.7.6
