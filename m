From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Mon, 28 Apr 2014 20:30:58 +0100
Subject: [PATCH 56/97] ARM: l2c: ux500: don't try to change the L2 cache
 auxiliary control register
In-Reply-To: <20140428192419.GV26756@n2100.arm.linux.org.uk>
References: <20140428192419.GV26756@n2100.arm.linux.org.uk>
Message-ID: <E1WerGU-0001XY-3t@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ux500 can't change the auxiliary control register, so there's no point
passing values to try and modify it to the l2x0 init functions.

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-ux500/cache-l2x0.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-ux500/cache-l2x0.c b/arch/arm/mach-ux500/cache-l2x0.c
index 5b891d051054..842ebedbdd1c 100644
--- a/arch/arm/mach-ux500/cache-l2x0.c
+++ b/arch/arm/mach-ux500/cache-l2x0.c
@@ -57,9 +57,9 @@ static int __init ux500_l2x0_init(void)
 	outer_cache.write_sec = ux500_l2c310_write_sec;
 
 	if (of_have_populated_dt())
-		l2x0_of_init(0x3e000000, 0xc00f0fff);
+		l2x0_of_init(0, ~0);
 	else
-		l2x0_init(l2x0_base, 0x3e000000, 0xc00f0fff);
+		l2x0_init(l2x0_base, 0, ~0);
 
 	return 0;
 }
-- 
1.8.3.1
