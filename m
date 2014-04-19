From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Sat, 19 Apr 2014 18:32:49 +0200
Subject: [PATCH 1/2] ARM: mvebu: remove unnecessary ifdef around l2x0_of_init
In-Reply-To: <1397925170-8202-1-git-send-email-gregory.clement@free-electrons.com>
References: <1397925170-8202-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1397925170-8202-2-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

l2x0_of_init function is always defined
arch/arm/include/asm/hardware/cache-l2x0.h: in case of
CONFIG_CACHE_L2X0 is not selected then a placeholder is defined.
Then there is no need to have ifdef around  l2x0_of_init.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/mach-mvebu/board-v7.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/mach-mvebu/board-v7.c b/arch/arm/mach-mvebu/board-v7.c
index 333fca8fdc41..1b6e26cc7cd1 100644
--- a/arch/arm/mach-mvebu/board-v7.c
+++ b/arch/arm/mach-mvebu/board-v7.c
@@ -59,9 +59,7 @@ static void __init mvebu_timer_and_clk_init(void)
 	clocksource_of_init();
 	coherency_init();
 	BUG_ON(mvebu_mbus_dt_init());
-#ifdef CONFIG_CACHE_L2X0
 	l2x0_of_init(0, ~0UL);
-#endif
 
 	if (of_machine_is_compatible("marvell,armada375"))
 		hook_fault_code(16 + 6, armada_375_external_abort_wa, SIGBUS, 0,
-- 
1.8.1.2
