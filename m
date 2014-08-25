From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 25 Aug 2014 10:10:14 +0900
Subject: [PATCH 09/10] ARM: shmobile: bockw: Use shmobile_init_delay()
In-Reply-To: <cover.1408927601.git.horms+renesas@verge.net.au>
References: <cover.1408927601.git.horms+renesas@verge.net.au>
Message-ID: <ca609e666c47cceb64610ad703dda1bebafef605.1408927601.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm+renesas@opensource.se>

Adjust the BockW board support code to use shmobile_init_delay()
together with CPU Frequency settings from the DTS.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-bockw-reference.c | 2 +-
 arch/arm/mach-shmobile/board-bockw.c           | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-bockw-reference.c b/arch/arm/mach-shmobile/board-bockw-reference.c
index 9202f16..79c4784 100644
--- a/arch/arm/mach-shmobile/board-bockw-reference.c
+++ b/arch/arm/mach-shmobile/board-bockw-reference.c
@@ -80,7 +80,7 @@ static const char *bockw_boards_compat_dt[] __initdata = {
 };
 
 DT_MACHINE_START(BOCKW_DT, "bockw")
-	.init_early	= r8a7778_init_delay,
+	.init_early	= shmobile_init_delay,
 	.init_irq	= r8a7778_init_irq_dt,
 	.init_machine	= bockw_init,
 	.init_late	= shmobile_init_late,
diff --git a/arch/arm/mach-shmobile/board-bockw.c b/arch/arm/mach-shmobile/board-bockw.c
index 8a83eb3..1cf2c75 100644
--- a/arch/arm/mach-shmobile/board-bockw.c
+++ b/arch/arm/mach-shmobile/board-bockw.c
@@ -733,7 +733,7 @@ static const char *bockw_boards_compat_dt[] __initdata = {
 };
 
 DT_MACHINE_START(BOCKW_DT, "bockw")
-	.init_early	= r8a7778_init_delay,
+	.init_early	= shmobile_init_delay,
 	.init_irq	= r8a7778_init_irq_dt,
 	.init_machine	= bockw_init,
 	.dt_compat	= bockw_boards_compat_dt,
-- 
2.0.1
