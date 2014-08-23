From: horms+renesas@verge.net.au (Simon Horman)
Date: Sat, 23 Aug 2014 10:43:33 +0900
Subject: [PATCH 4/8] ARM: shmobile: ape6evm: Add shmobile_init_late()
In-Reply-To: <cover.1408671094.git.horms+renesas@verge.net.au>
References: <cover.1408671094.git.horms+renesas@verge.net.au>
Message-ID: <509c42a5fce00f8769f68847580ba3c4dc884218.1408671094.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm+renesas@opensource.se>

Extend board specific APE6EVM reference machine vectors to include
shmobile_init_late() so Suspend-to-RAM and CPUIdle are setup as expected.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-ape6evm-reference.c | 1 +
 arch/arm/mach-shmobile/board-ape6evm.c           | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm/mach-shmobile/board-ape6evm-reference.c b/arch/arm/mach-shmobile/board-ape6evm-reference.c
index 2f7723e..1ecda4b 100644
--- a/arch/arm/mach-shmobile/board-ape6evm-reference.c
+++ b/arch/arm/mach-shmobile/board-ape6evm-reference.c
@@ -61,5 +61,6 @@ static const char *ape6evm_boards_compat_dt[] __initdata = {
 DT_MACHINE_START(APE6EVM_DT, "ape6evm")
 	.init_early	= r8a73a4_init_early,
 	.init_machine	= ape6evm_add_standard_devices,
+	.init_late	= shmobile_init_late,
 	.dt_compat	= ape6evm_boards_compat_dt,
 MACHINE_END
diff --git a/arch/arm/mach-shmobile/board-ape6evm.c b/arch/arm/mach-shmobile/board-ape6evm.c
index 1585b88..befbae03 100644
--- a/arch/arm/mach-shmobile/board-ape6evm.c
+++ b/arch/arm/mach-shmobile/board-ape6evm.c
@@ -285,5 +285,6 @@ static const char *ape6evm_boards_compat_dt[] __initdata = {
 DT_MACHINE_START(APE6EVM_DT, "ape6evm")
 	.init_early	= r8a73a4_init_early,
 	.init_machine	= ape6evm_add_standard_devices,
+	.init_late	= shmobile_init_late,
 	.dt_compat	= ape6evm_boards_compat_dt,
 MACHINE_END
-- 
2.0.1
