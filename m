From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 05 Jul 2011 22:47:25 -0400
Subject: [PATCH 40/52] ARM: mach-s5pc100,
	mach-s5pv210: convert boot_params to atag_offset
In-Reply-To: <1309920457-21913-1-git-send-email-nicolas.pitre@linaro.org>
References: <1309920457-21913-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1309920457-21913-40-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/mach-s5pc100/mach-smdkc100.c |    2 +-
 arch/arm/mach-s5pv210/mach-aquila.c   |    2 +-
 arch/arm/mach-s5pv210/mach-goni.c     |    2 +-
 arch/arm/mach-s5pv210/mach-smdkc110.c |    2 +-
 arch/arm/mach-s5pv210/mach-smdkv210.c |    2 +-
 arch/arm/mach-s5pv210/mach-torbreck.c |    2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-s5pc100/mach-smdkc100.c b/arch/arm/mach-s5pc100/mach-smdkc100.c
index 0525cb3..4328a02 100644
--- a/arch/arm/mach-s5pc100/mach-smdkc100.c
+++ b/arch/arm/mach-s5pc100/mach-smdkc100.c
@@ -281,7 +281,7 @@ static void __init smdkc100_machine_init(void)
 
 MACHINE_START(SMDKC100, "SMDKC100")
 	/* Maintainer: Byungho Min <bhmin@samsung.com> */
-	.boot_params	= S5P_PA_SDRAM + 0x100,
+	.atag_offset	= 0x100,
 	.init_irq	= s5pc100_init_irq,
 	.map_io		= smdkc100_map_io,
 	.init_machine	= smdkc100_machine_init,
diff --git a/arch/arm/mach-s5pv210/mach-aquila.c b/arch/arm/mach-s5pv210/mach-aquila.c
index 4e1d8ff..95d3c8e 100644
--- a/arch/arm/mach-s5pv210/mach-aquila.c
+++ b/arch/arm/mach-s5pv210/mach-aquila.c
@@ -678,7 +678,7 @@ MACHINE_START(AQUILA, "Aquila")
 	/* Maintainers:
 	   Marek Szyprowski <m.szyprowski@samsung.com>
 	   Kyungmin Park <kyungmin.park@samsung.com> */
-	.boot_params	= S5P_PA_SDRAM + 0x100,
+	.atag_offset	= 0x100,
 	.init_irq	= s5pv210_init_irq,
 	.map_io		= aquila_map_io,
 	.init_machine	= aquila_machine_init,
diff --git a/arch/arm/mach-s5pv210/mach-goni.c b/arch/arm/mach-s5pv210/mach-goni.c
index 31d5aa7..cfa18ac 100644
--- a/arch/arm/mach-s5pv210/mach-goni.c
+++ b/arch/arm/mach-s5pv210/mach-goni.c
@@ -888,7 +888,7 @@ static void __init goni_machine_init(void)
 
 MACHINE_START(GONI, "GONI")
 	/* Maintainers: Kyungmin Park <kyungmin.park@samsung.com> */
-	.boot_params	= S5P_PA_SDRAM + 0x100,
+	.atag_offset	= 0x100,
 	.init_irq	= s5pv210_init_irq,
 	.map_io		= goni_map_io,
 	.init_machine	= goni_machine_init,
diff --git a/arch/arm/mach-s5pv210/mach-smdkc110.c b/arch/arm/mach-s5pv210/mach-smdkc110.c
index 6c412c8..f7266bb 100644
--- a/arch/arm/mach-s5pv210/mach-smdkc110.c
+++ b/arch/arm/mach-s5pv210/mach-smdkc110.c
@@ -136,7 +136,7 @@ static void __init smdkc110_machine_init(void)
 
 MACHINE_START(SMDKC110, "SMDKC110")
 	/* Maintainer: Kukjin Kim <kgene.kim@samsung.com> */
-	.boot_params	= S5P_PA_SDRAM + 0x100,
+	.atag_offset	= 0x100,
 	.init_irq	= s5pv210_init_irq,
 	.map_io		= smdkc110_map_io,
 	.init_machine	= smdkc110_machine_init,
diff --git a/arch/arm/mach-s5pv210/mach-smdkv210.c b/arch/arm/mach-s5pv210/mach-smdkv210.c
index c6a9e86..535de9f 100644
--- a/arch/arm/mach-s5pv210/mach-smdkv210.c
+++ b/arch/arm/mach-s5pv210/mach-smdkv210.c
@@ -346,7 +346,7 @@ static void __init smdkv210_machine_init(void)
 
 MACHINE_START(SMDKV210, "SMDKV210")
 	/* Maintainer: Kukjin Kim <kgene.kim@samsung.com> */
-	.boot_params	= S5P_PA_SDRAM + 0x100,
+	.atag_offset	= 0x100,
 	.init_irq	= s5pv210_init_irq,
 	.map_io		= smdkv210_map_io,
 	.init_machine	= smdkv210_machine_init,
diff --git a/arch/arm/mach-s5pv210/mach-torbreck.c b/arch/arm/mach-s5pv210/mach-torbreck.c
index 925fc0d..97cc066 100644
--- a/arch/arm/mach-s5pv210/mach-torbreck.c
+++ b/arch/arm/mach-s5pv210/mach-torbreck.c
@@ -125,7 +125,7 @@ static void __init torbreck_machine_init(void)
 
 MACHINE_START(TORBRECK, "TORBRECK")
 	/* Maintainer: Hyunchul Ko <ghcstop@gmail.com> */
-	.boot_params	= S5P_PA_SDRAM + 0x100,
+	.atag_offset	= 0x100,
 	.init_irq	= s5pv210_init_irq,
 	.map_io		= torbreck_map_io,
 	.init_machine	= torbreck_machine_init,
-- 
1.7.4
