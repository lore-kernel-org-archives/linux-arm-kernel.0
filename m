From: magnus.damm@gmail.com (Magnus Damm)
Date: Mon, 12 May 2014 08:25:18 +0900
Subject: [PATCH 01/03] ARM: shmobile: Use r8a7791 DT CPU Frequency in common
 case
In-Reply-To: <20140511232508.20177.11556.sendpatchset@w520>
References: <20140511232508.20177.11556.sendpatchset@w520>
Message-ID: <20140511232518.20177.19630.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm+renesas@opensource.se>

Convert the common C-code-less r8a7791 DT board support
to use shmobile_init_delay() to be able to migrate away
from per-SoC delay setup functions.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 arch/arm/mach-shmobile/setup-r8a7791.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- 0001/arch/arm/mach-shmobile/setup-r8a7791.c
+++ work/arch/arm/mach-shmobile/setup-r8a7791.c	2014-05-12 08:02:27.000000000 +0900
@@ -222,7 +222,7 @@ static const char *r8a7791_boards_compat
 
 DT_MACHINE_START(R8A7791_DT, "Generic R8A7791 (Flattened Device Tree)")
 	.smp		= smp_ops(r8a7791_smp_ops),
-	.init_early	= r8a7791_init_early,
+	.init_early	= shmobile_init_delay,
 	.init_time	= rcar_gen2_timer_init,
 	.dt_compat	= r8a7791_boards_compat_dt,
 MACHINE_END
