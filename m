From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri, 10 Aug 2012 15:02:01 +0200
Subject: [PATCH 04/14] ARM: at91: add dummies pinctrl for non dt platform
In-Reply-To: <1344603731-32667-1-git-send-email-plagnioj@jcrosoft.com>
References: <20120810124820.GA20557@game.jcrosoft.org>
 <1344603731-32667-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <1344603731-32667-4-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
---
 arch/arm/mach-at91/setup.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-at91/setup.c b/arch/arm/mach-at91/setup.c
index 944bffb..50c69b5 100644
--- a/arch/arm/mach-at91/setup.c
+++ b/arch/arm/mach-at91/setup.c
@@ -10,6 +10,7 @@
 #include <linux/mm.h>
 #include <linux/pm.h>
 #include <linux/of_address.h>
+#include <linux/pinctrl/machine.h>
 
 #include <asm/system_misc.h>
 #include <asm/mach/map.h>
@@ -463,4 +464,6 @@ void __init at91_initialize(unsigned long main_clock)
 	at91_boot_soc.register_clocks();
 
 	at91_boot_soc.init();
+
+	pinctrl_provide_dummies();
 }
-- 
1.7.10.4
