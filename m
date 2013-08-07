From: magnus.damm@gmail.com (Magnus Damm)
Date: Thu, 08 Aug 2013 07:26:48 +0900
Subject: [PATCH 01/02] ARM: shmobile: Rename to r8a73a4_init_early()
In-Reply-To: <20130807222638.22283.78607.sendpatchset@w520>
References: <20130807222638.22283.78607.sendpatchset@w520>
Message-ID: <20130807222648.22283.98436.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Rename r8a73a4_init_delay() into r8a73a4_init_early()
to make the function name show that more than just
delay setup may happen in the future.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/board-ape6evm-reference.c |    2 +-
 arch/arm/mach-shmobile/board-ape6evm.c           |    2 +-
 arch/arm/mach-shmobile/include/mach/r8a73a4.h    |    2 +-
 arch/arm/mach-shmobile/setup-r8a73a4.c           |    4 ++--
 4 files changed, 5 insertions(+), 5 deletions(-)

--- 0001/arch/arm/mach-shmobile/board-ape6evm-reference.c
+++ work/arch/arm/mach-shmobile/board-ape6evm-reference.c	2013-08-07 14:31:50.000000000 +0900
@@ -57,7 +57,7 @@ static const char *ape6evm_boards_compat
 };
 
 DT_MACHINE_START(APE6EVM_DT, "ape6evm")
-	.init_early	= r8a73a4_init_delay,
+	.init_early	= r8a73a4_init_early,
 	.init_machine	= ape6evm_add_standard_devices,
 	.dt_compat	= ape6evm_boards_compat_dt,
 MACHINE_END
--- 0001/arch/arm/mach-shmobile/board-ape6evm.c
+++ work/arch/arm/mach-shmobile/board-ape6evm.c	2013-08-07 14:31:50.000000000 +0900
@@ -240,7 +240,7 @@ static const char *ape6evm_boards_compat
 };
 
 DT_MACHINE_START(APE6EVM_DT, "ape6evm")
-	.init_early	= r8a73a4_init_delay,
+	.init_early	= r8a73a4_init_early,
 	.init_machine	= ape6evm_add_standard_devices,
 	.dt_compat	= ape6evm_boards_compat_dt,
 MACHINE_END
--- 0001/arch/arm/mach-shmobile/include/mach/r8a73a4.h
+++ work/arch/arm/mach-shmobile/include/mach/r8a73a4.h	2013-08-07 14:31:50.000000000 +0900
@@ -5,6 +5,6 @@ void r8a73a4_add_standard_devices(void);
 void r8a73a4_add_dt_devices(void);
 void r8a73a4_clock_init(void);
 void r8a73a4_pinmux_init(void);
-void r8a73a4_init_delay(void);
+void r8a73a4_init_early(void);
 
 #endif /* __ASM_R8A73A4_H__ */
--- 0001/arch/arm/mach-shmobile/setup-r8a73a4.c
+++ work/arch/arm/mach-shmobile/setup-r8a73a4.c	2013-08-07 14:32:08.000000000 +0900
@@ -207,7 +207,7 @@ void __init r8a73a4_add_standard_devices
 	r8a73a4_register_thermal();
 }
 
-void __init r8a73a4_init_delay(void)
+void __init r8a73a4_init_early(void)
 {
 #ifndef CONFIG_ARM_ARCH_TIMER
 	shmobile_setup_delay(1500, 2, 4); /* Cortex-A15 @ 1500MHz */
@@ -222,7 +222,7 @@ static const char *r8a73a4_boards_compat
 };
 
 DT_MACHINE_START(R8A73A4_DT, "Generic R8A73A4 (Flattened Device Tree)")
-	.init_early	= r8a73a4_init_delay,
+	.init_early	= r8a73a4_init_early,
 	.dt_compat	= r8a73a4_boards_compat_dt,
 MACHINE_END
 #endif /* CONFIG_USE_OF */
