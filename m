From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 24 Feb 2014 19:09:24 +0100
Subject: [PATCH] ARM: Kirkwood: Remove redundant kexec code
Message-ID: <1393265364-29241-1-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PCIe driver has been fully clock aware for quite a while.  Remove
the kexec code to enable the PCIe clock, since the PCIe driver will do
the right thing.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/mach-kirkwood/board-dt.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm/mach-kirkwood/board-dt.c b/arch/arm/mach-kirkwood/board-dt.c
index ec0702c02d6c..2801da49e2a3 100644
--- a/arch/arm/mach-kirkwood/board-dt.c
+++ b/arch/arm/mach-kirkwood/board-dt.c
@@ -19,7 +19,6 @@
 #include <linux/of_platform.h>
 #include <linux/dma-mapping.h>
 #include <linux/irqchip.h>
-#include <linux/kexec.h>
 #include <asm/hardware/cache-feroceon-l2.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
@@ -207,10 +206,6 @@ static void __init kirkwood_dt_init(void)
 	kirkwood_pm_init();
 	kirkwood_dt_eth_fixup();
 
-#ifdef CONFIG_KEXEC
-	kexec_reinit = kirkwood_enable_pcie;
-#endif
-
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }
 
-- 
1.8.5.3
