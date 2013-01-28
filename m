From: linus.walleij@stericsson.com (Linus Walleij)
Date: Mon, 28 Jan 2013 14:52:31 +0100
Subject: [PATCH 5/5] ARM: ux500: select the DB8540 pin controller
Message-ID: <1359381151-28127-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

The pin controller is an inherent part of the SoC, without
it the system will not boot, thus it needs to be selected
from Kconfig.

Cc: arm at kernel.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Requesting ACK from ARM SoC on this patch.
---
 arch/arm/mach-ux500/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-ux500/Kconfig b/arch/arm/mach-ux500/Kconfig
index 5a12a7a..3e5bbd0 100644
--- a/arch/arm/mach-ux500/Kconfig
+++ b/arch/arm/mach-ux500/Kconfig
@@ -19,6 +19,7 @@ config UX500_SOC_DB8500
 	select CPU_FREQ_TABLE if CPU_FREQ
 	select MFD_DB8500_PRCMU
 	select PINCTRL_DB8500
+	select PINCTRL_DB8540
 	select PINCTRL_AB8500
 	select PINCTRL_AB8505
 	select PINCTRL_AB9540
-- 
1.7.11.3
