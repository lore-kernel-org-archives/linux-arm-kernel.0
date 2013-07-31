From: magnus.damm@gmail.com (Magnus Damm)
Date: Thu, 01 Aug 2013 04:02:24 +0900
Subject: [PATCH 08/13] ARM: shmobile: Use default ->init_time() on APE6EVM
In-Reply-To: <20130731190110.31796.96552.sendpatchset@w520>
References: <20130731190110.31796.96552.sendpatchset@w520>
Message-ID: <20130731190224.31796.18362.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Leave ->init_time() set to NULL to use the default ARM behaviour.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/board-ape6evm.c |    1 -
 1 file changed, 1 deletion(-)

--- 0001/arch/arm/mach-shmobile/board-ape6evm.c
+++ work/arch/arm/mach-shmobile/board-ape6evm.c	2013-08-01 03:11:13.000000000 +0900
@@ -181,7 +181,6 @@ static const char *ape6evm_boards_compat
 
 DT_MACHINE_START(APE6EVM_DT, "ape6evm")
 	.init_early	= r8a73a4_init_delay,
-	.init_time	= shmobile_timer_init,
 	.init_machine	= ape6evm_add_standard_devices,
 	.dt_compat	= ape6evm_boards_compat_dt,
 MACHINE_END
