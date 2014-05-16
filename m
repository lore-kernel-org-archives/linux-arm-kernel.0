From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 16 May 2014 14:10:13 +0200
Subject: [PATCH 2/5] ARM: shmobile: genmai-reference: Remove legacy clock
 support
In-Reply-To: <1400242216-20848-1-git-send-email-wsa@the-dreams.de>
References: <1400242216-20848-1-git-send-email-wsa@the-dreams.de>
Message-ID: <1400242216-20848-3-git-send-email-wsa@the-dreams.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

genmai-reference is now only built for multiplatform which means that
CCF comes with the package. Remove unused legacy code ifdefs to clean up
the code.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 arch/arm/mach-shmobile/board-genmai-reference.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-genmai-reference.c b/arch/arm/mach-shmobile/board-genmai-reference.c
index 33015e5ed52a..968bbba20d08 100644
--- a/arch/arm/mach-shmobile/board-genmai-reference.c
+++ b/arch/arm/mach-shmobile/board-genmai-reference.c
@@ -26,7 +26,6 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
-#ifdef CONFIG_COMMON_CLK
 /*
  * This is a really crude hack to provide clkdev support to platform
  * devices until they get moved to DT.
@@ -34,15 +33,10 @@
 static const struct clk_name clk_names[] = {
 	{ "mtu2", "fck", "sh-mtu2" },
 };
-#endif
 
 static void __init genmai_add_standard_devices(void)
 {
-#ifdef CONFIG_COMMON_CLK
 	shmobile_clk_workaround(clk_names, ARRAY_SIZE(clk_names), true);
-#else
-	r7s72100_clock_init();
-#endif
 	r7s72100_add_dt_devices();
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }
-- 
1.9.2
