From: horms+renesas@verge.net.au (Simon Horman)
Date: Sat, 23 Aug 2014 10:43:34 +0900
Subject: [PATCH 5/8] ARM: shmobile: ape6evm: Use shmobile_init_delay()
In-Reply-To: <cover.1408671094.git.horms+renesas@verge.net.au>
References: <cover.1408671094.git.horms+renesas@verge.net.au>
Message-ID: <911f7cec78af1445d4b0f5f79907cb5bd4522ce5.1408671094.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm+renesas@opensource.se>

The r8a73a4 DTS includes CPU Frequency information so
adjust the APE6EVM board code to use shmobile_init_delay()
instead of relying on CPU Frequency information included
in r8a73a4_init_delay() that is specified in C.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-ape6evm-reference.c | 2 +-
 arch/arm/mach-shmobile/board-ape6evm.c           | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ape6evm-reference.c b/arch/arm/mach-shmobile/board-ape6evm-reference.c
index 1ecda4b..9e99b15 100644
--- a/arch/arm/mach-shmobile/board-ape6evm-reference.c
+++ b/arch/arm/mach-shmobile/board-ape6evm-reference.c
@@ -59,7 +59,7 @@ static const char *ape6evm_boards_compat_dt[] __initdata = {
 };
 
 DT_MACHINE_START(APE6EVM_DT, "ape6evm")
-	.init_early	= r8a73a4_init_early,
+	.init_early	= shmobile_init_delay,
 	.init_machine	= ape6evm_add_standard_devices,
 	.init_late	= shmobile_init_late,
 	.dt_compat	= ape6evm_boards_compat_dt,
diff --git a/arch/arm/mach-shmobile/board-ape6evm.c b/arch/arm/mach-shmobile/board-ape6evm.c
index befbae03..b222f68 100644
--- a/arch/arm/mach-shmobile/board-ape6evm.c
+++ b/arch/arm/mach-shmobile/board-ape6evm.c
@@ -283,7 +283,7 @@ static const char *ape6evm_boards_compat_dt[] __initdata = {
 };
 
 DT_MACHINE_START(APE6EVM_DT, "ape6evm")
-	.init_early	= r8a73a4_init_early,
+	.init_early	= shmobile_init_delay,
 	.init_machine	= ape6evm_add_standard_devices,
 	.init_late	= shmobile_init_late,
 	.dt_compat	= ape6evm_boards_compat_dt,
-- 
2.0.1
