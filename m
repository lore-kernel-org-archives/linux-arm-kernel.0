From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 05 Jul 2011 22:47:30 -0400
Subject: [PATCH 45/52] ARM: mach-tegra: convert boot_params to atag_offset
In-Reply-To: <1309920457-21913-1-git-send-email-nicolas.pitre@linaro.org>
References: <1309920457-21913-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1309920457-21913-45-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/mach-tegra/board-harmony.c   |    2 +-
 arch/arm/mach-tegra/board-paz00.c     |    2 +-
 arch/arm/mach-tegra/board-seaboard.c  |    6 +++---
 arch/arm/mach-tegra/board-trimslice.c |    2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-tegra/board-harmony.c b/arch/arm/mach-tegra/board-harmony.c
index 30e18bc..99c6be7 100644
--- a/arch/arm/mach-tegra/board-harmony.c
+++ b/arch/arm/mach-tegra/board-harmony.c
@@ -201,7 +201,7 @@ static void __init tegra_harmony_init(void)
 }
 
 MACHINE_START(HARMONY, "harmony")
-	.boot_params  = 0x00000100,
+	.atag_offset	= 0x100,
 	.fixup		= tegra_harmony_fixup,
 	.map_io         = tegra_map_common_io,
 	.init_early	= tegra_init_early,
diff --git a/arch/arm/mach-tegra/board-paz00.c b/arch/arm/mach-tegra/board-paz00.c
index 57e50a8..afb735d 100644
--- a/arch/arm/mach-tegra/board-paz00.c
+++ b/arch/arm/mach-tegra/board-paz00.c
@@ -118,7 +118,7 @@ static void __init tegra_paz00_init(void)
 }
 
 MACHINE_START(PAZ00, "paz00")
-	.boot_params	= 0x00000100,
+	.atag_offset	= 0x100,
 	.fixup		= tegra_paz00_fixup,
 	.map_io         = tegra_map_common_io,
 	.init_early	= tegra_init_early,
diff --git a/arch/arm/mach-tegra/board-seaboard.c b/arch/arm/mach-tegra/board-seaboard.c
index a8d7ace..647b15e 100644
--- a/arch/arm/mach-tegra/board-seaboard.c
+++ b/arch/arm/mach-tegra/board-seaboard.c
@@ -223,7 +223,7 @@ static void __init tegra_wario_init(void)
 
 
 MACHINE_START(SEABOARD, "seaboard")
-	.boot_params    = 0x00000100,
+	.atag_offset    = 0x100,
 	.map_io         = tegra_map_common_io,
 	.init_early     = tegra_init_early,
 	.init_irq       = tegra_init_irq,
@@ -232,7 +232,7 @@ MACHINE_START(SEABOARD, "seaboard")
 MACHINE_END
 
 MACHINE_START(KAEN, "kaen")
-	.boot_params    = 0x00000100,
+	.atag_offset    = 0x100,
 	.map_io         = tegra_map_common_io,
 	.init_early     = tegra_init_early,
 	.init_irq       = tegra_init_irq,
@@ -241,7 +241,7 @@ MACHINE_START(KAEN, "kaen")
 MACHINE_END
 
 MACHINE_START(WARIO, "wario")
-	.boot_params    = 0x00000100,
+	.atag_offset    = 0x100,
 	.map_io         = tegra_map_common_io,
 	.init_early     = tegra_init_early,
 	.init_irq       = tegra_init_irq,
diff --git a/arch/arm/mach-tegra/board-trimslice.c b/arch/arm/mach-tegra/board-trimslice.c
index cda4cfd..ed3505d 100644
--- a/arch/arm/mach-tegra/board-trimslice.c
+++ b/arch/arm/mach-tegra/board-trimslice.c
@@ -115,7 +115,7 @@ static void __init tegra_trimslice_init(void)
 }
 
 MACHINE_START(TRIMSLICE, "trimslice")
-	.boot_params	= 0x00000100,
+	.atag_offset	= 0x100,
 	.fixup		= tegra_trimslice_fixup,
 	.map_io         = tegra_map_common_io,
 	.init_early	= tegra_init_early,
-- 
1.7.4
