From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 28 Aug 2013 10:39:30 +0900
Subject: [PATCH 1/3] ARM: shmobile: Rename to r8a73a4_init_early()
In-Reply-To: <cover.1377651687.git.horms+renesas@verge.net.au>
References: <cover.1377651687.git.horms+renesas@verge.net.au>
Message-ID: <c8da0f79f931d1f94618fa42797281e6bc1d19d8.1377651687.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Rename r8a73a4_init_delay() into r8a73a4_init_early()
to make the function name show that more than just
delay setup may happen in the future.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-ape6evm-reference.c | 2 +-
 arch/arm/mach-shmobile/board-ape6evm.c           | 2 +-
 arch/arm/mach-shmobile/include/mach/r8a73a4.h    | 2 +-
 arch/arm/mach-shmobile/setup-r8a73a4.c           | 4 ++--
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ape6evm-reference.c b/arch/arm/mach-shmobile/board-ape6evm-reference.c
index a23fa71..3276afc 100644
--- a/arch/arm/mach-shmobile/board-ape6evm-reference.c
+++ b/arch/arm/mach-shmobile/board-ape6evm-reference.c
@@ -57,7 +57,7 @@ static const char *ape6evm_boards_compat_dt[] __initdata = {
 };
 
 DT_MACHINE_START(APE6EVM_DT, "ape6evm")
-	.init_early	= r8a73a4_init_delay,
+	.init_early	= r8a73a4_init_early,
 	.init_machine	= ape6evm_add_standard_devices,
 	.dt_compat	= ape6evm_boards_compat_dt,
 MACHINE_END
diff --git a/arch/arm/mach-shmobile/board-ape6evm.c b/arch/arm/mach-shmobile/board-ape6evm.c
index 57e66eb..9f1aeb3 100644
--- a/arch/arm/mach-shmobile/board-ape6evm.c
+++ b/arch/arm/mach-shmobile/board-ape6evm.c
@@ -101,7 +101,7 @@ static const char *ape6evm_boards_compat_dt[] __initdata = {
 };
 
 DT_MACHINE_START(APE6EVM_DT, "ape6evm")
-	.init_early	= r8a73a4_init_delay,
+	.init_early	= r8a73a4_init_early,
 	.init_machine	= ape6evm_add_standard_devices,
 	.dt_compat	= ape6evm_boards_compat_dt,
 MACHINE_END
diff --git a/arch/arm/mach-shmobile/include/mach/r8a73a4.h b/arch/arm/mach-shmobile/include/mach/r8a73a4.h
index f3a9b70..5214338 100644
--- a/arch/arm/mach-shmobile/include/mach/r8a73a4.h
+++ b/arch/arm/mach-shmobile/include/mach/r8a73a4.h
@@ -5,6 +5,6 @@ void r8a73a4_add_standard_devices(void);
 void r8a73a4_add_dt_devices(void);
 void r8a73a4_clock_init(void);
 void r8a73a4_pinmux_init(void);
-void r8a73a4_init_delay(void);
+void r8a73a4_init_early(void);
 
 #endif /* __ASM_R8A73A4_H__ */
diff --git a/arch/arm/mach-shmobile/setup-r8a73a4.c b/arch/arm/mach-shmobile/setup-r8a73a4.c
index 8949170..53a8962 100644
--- a/arch/arm/mach-shmobile/setup-r8a73a4.c
+++ b/arch/arm/mach-shmobile/setup-r8a73a4.c
@@ -207,7 +207,7 @@ void __init r8a73a4_add_standard_devices(void)
 	r8a73a4_register_thermal();
 }
 
-void __init r8a73a4_init_delay(void)
+void __init r8a73a4_init_early(void)
 {
 #ifndef CONFIG_ARM_ARCH_TIMER
 	shmobile_setup_delay(1500, 2, 4); /* Cortex-A15 @ 1500MHz */
@@ -222,7 +222,7 @@ static const char *r8a73a4_boards_compat_dt[] __initdata = {
 };
 
 DT_MACHINE_START(R8A73A4_DT, "Generic R8A73A4 (Flattened Device Tree)")
-	.init_early	= r8a73a4_init_delay,
+	.init_early	= r8a73a4_init_early,
 	.dt_compat	= r8a73a4_boards_compat_dt,
 MACHINE_END
 #endif /* CONFIG_USE_OF */
-- 
1.8.3.2
