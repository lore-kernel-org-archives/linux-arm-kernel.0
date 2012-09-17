From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Mon, 17 Sep 2012 17:27:03 +0200
Subject: [PATCH 06/16] ARM: at91: add dummies pinctrl for non dt platform
In-Reply-To: <1347895633-1763-1-git-send-email-plagnioj@jcrosoft.com>
References: <20120917140423.GA17667@game.jcrosoft.org>
 <1347895633-1763-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <1347895633-1763-6-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
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
