From: magnus.damm@gmail.com (Magnus Damm)
Date: Tue, 20 May 2014 08:37:24 +0900
Subject: [PATCH 01/03] ARM: shmobile: Use r8a7790 DT CPU Frequency in common
 case
In-Reply-To: <20140519233714.10496.31390.sendpatchset@w520>
References: <20140519233714.10496.31390.sendpatchset@w520>
Message-ID: <20140519233724.10496.86754.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm+renesas@opensource.se>

Convert the common C-code-less r8a7790 DT board support
to use shmobile_init_delay() to be able to migrate away
from per-SoC delay setup functions.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 arch/arm/mach-shmobile/setup-r8a7790.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- 0001/arch/arm/mach-shmobile/setup-r8a7790.c
+++ work/arch/arm/mach-shmobile/setup-r8a7790.c	2014-05-19 22:24:38.000000000 +0900
@@ -323,7 +323,7 @@ static const char * const r8a7790_boards
 
 DT_MACHINE_START(R8A7790_DT, "Generic R8A7790 (Flattened Device Tree)")
 	.smp		= smp_ops(r8a7790_smp_ops),
-	.init_early	= r8a7790_init_early,
+	.init_early	= shmobile_init_delay,
 	.init_time	= rcar_gen2_timer_init,
 	.dt_compat	= r8a7790_boards_compat_dt,
 MACHINE_END
