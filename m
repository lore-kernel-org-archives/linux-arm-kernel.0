From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 05 Jul 2011 22:47:09 -0400
Subject: [PATCH 24/52] ARM: mach-msm: convert boot_params to atag_offset
In-Reply-To: <1309920457-21913-1-git-send-email-nicolas.pitre@linaro.org>
References: <1309920457-21913-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1309920457-21913-24-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/mach-msm/board-halibut.c  |    2 +-
 arch/arm/mach-msm/board-mahimahi.c |    2 +-
 arch/arm/mach-msm/board-msm7x27.c  |    8 ++++----
 arch/arm/mach-msm/board-msm7x30.c  |    6 +++---
 arch/arm/mach-msm/board-qsd8x50.c  |    4 ++--
 arch/arm/mach-msm/board-sapphire.c |    2 +-
 arch/arm/mach-msm/board-trout.c    |    2 +-
 7 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-msm/board-halibut.c b/arch/arm/mach-msm/board-halibut.c
index 18a3c97..16c86f8 100644
--- a/arch/arm/mach-msm/board-halibut.c
+++ b/arch/arm/mach-msm/board-halibut.c
@@ -93,7 +93,7 @@ static void __init halibut_map_io(void)
 }
 
 MACHINE_START(HALIBUT, "Halibut Board (QCT SURF7200A)")
-	.boot_params	= 0x10000100,
+	.atag_offset	= 0x100,
 	.fixup		= halibut_fixup,
 	.map_io		= halibut_map_io,
 	.init_irq	= halibut_init_irq,
diff --git a/arch/arm/mach-msm/board-mahimahi.c b/arch/arm/mach-msm/board-mahimahi.c
index 7a9a03e..8a1672e 100644
--- a/arch/arm/mach-msm/board-mahimahi.c
+++ b/arch/arm/mach-msm/board-mahimahi.c
@@ -74,7 +74,7 @@ static void __init mahimahi_map_io(void)
 extern struct sys_timer msm_timer;
 
 MACHINE_START(MAHIMAHI, "mahimahi")
-	.boot_params	= 0x20000100,
+	.atag_offset	= 0x100,
 	.fixup		= mahimahi_fixup,
 	.map_io		= mahimahi_map_io,
 	.init_irq	= msm_init_irq,
diff --git a/arch/arm/mach-msm/board-msm7x27.c b/arch/arm/mach-msm/board-msm7x27.c
index c03f269..a807655 100644
--- a/arch/arm/mach-msm/board-msm7x27.c
+++ b/arch/arm/mach-msm/board-msm7x27.c
@@ -130,7 +130,7 @@ static void __init msm7x2x_map_io(void)
 }
 
 MACHINE_START(MSM7X27_SURF, "QCT MSM7x27 SURF")
-	.boot_params	= PLAT_PHYS_OFFSET + 0x100,
+	.atag_offset	= 0x100,
 	.map_io		= msm7x2x_map_io,
 	.init_irq	= msm7x2x_init_irq,
 	.init_machine	= msm7x2x_init,
@@ -138,7 +138,7 @@ MACHINE_START(MSM7X27_SURF, "QCT MSM7x27 SURF")
 MACHINE_END
 
 MACHINE_START(MSM7X27_FFA, "QCT MSM7x27 FFA")
-	.boot_params	= PLAT_PHYS_OFFSET + 0x100,
+	.atag_offset	= 0x100,
 	.map_io		= msm7x2x_map_io,
 	.init_irq	= msm7x2x_init_irq,
 	.init_machine	= msm7x2x_init,
@@ -146,7 +146,7 @@ MACHINE_START(MSM7X27_FFA, "QCT MSM7x27 FFA")
 MACHINE_END
 
 MACHINE_START(MSM7X25_SURF, "QCT MSM7x25 SURF")
-	.boot_params	= PLAT_PHYS_OFFSET + 0x100,
+	.atag_offset	= 0x100,
 	.map_io		= msm7x2x_map_io,
 	.init_irq	= msm7x2x_init_irq,
 	.init_machine	= msm7x2x_init,
@@ -154,7 +154,7 @@ MACHINE_START(MSM7X25_SURF, "QCT MSM7x25 SURF")
 MACHINE_END
 
 MACHINE_START(MSM7X25_FFA, "QCT MSM7x25 FFA")
-	.boot_params	= PLAT_PHYS_OFFSET + 0x100,
+	.atag_offset	= 0x100,
 	.map_io		= msm7x2x_map_io,
 	.init_irq	= msm7x2x_init_irq,
 	.init_machine	= msm7x2x_init,
diff --git a/arch/arm/mach-msm/board-msm7x30.c b/arch/arm/mach-msm/board-msm7x30.c
index b7a8496..5a2ab68 100644
--- a/arch/arm/mach-msm/board-msm7x30.c
+++ b/arch/arm/mach-msm/board-msm7x30.c
@@ -106,7 +106,7 @@ static void __init msm7x30_map_io(void)
 }
 
 MACHINE_START(MSM7X30_SURF, "QCT MSM7X30 SURF")
-	.boot_params = PLAT_PHYS_OFFSET + 0x100,
+	.atag_offset = 0x100,
 	.map_io = msm7x30_map_io,
 	.init_irq = msm7x30_init_irq,
 	.init_machine = msm7x30_init,
@@ -114,7 +114,7 @@ MACHINE_START(MSM7X30_SURF, "QCT MSM7X30 SURF")
 MACHINE_END
 
 MACHINE_START(MSM7X30_FFA, "QCT MSM7X30 FFA")
-	.boot_params = PLAT_PHYS_OFFSET + 0x100,
+	.atag_offset = 0x100,
 	.map_io = msm7x30_map_io,
 	.init_irq = msm7x30_init_irq,
 	.init_machine = msm7x30_init,
@@ -122,7 +122,7 @@ MACHINE_START(MSM7X30_FFA, "QCT MSM7X30 FFA")
 MACHINE_END
 
 MACHINE_START(MSM7X30_FLUID, "QCT MSM7X30 FLUID")
-	.boot_params = PLAT_PHYS_OFFSET + 0x100,
+	.atag_offset = 0x100,
 	.map_io = msm7x30_map_io,
 	.init_irq = msm7x30_init_irq,
 	.init_machine = msm7x30_init,
diff --git a/arch/arm/mach-msm/board-qsd8x50.c b/arch/arm/mach-msm/board-qsd8x50.c
index 6a96911..51109b1 100644
--- a/arch/arm/mach-msm/board-qsd8x50.c
+++ b/arch/arm/mach-msm/board-qsd8x50.c
@@ -193,7 +193,7 @@ static void __init qsd8x50_init(void)
 }
 
 MACHINE_START(QSD8X50_SURF, "QCT QSD8X50 SURF")
-	.boot_params = PLAT_PHYS_OFFSET + 0x100,
+	.atag_offset = 0x100,
 	.map_io = qsd8x50_map_io,
 	.init_irq = qsd8x50_init_irq,
 	.init_machine = qsd8x50_init,
@@ -201,7 +201,7 @@ MACHINE_START(QSD8X50_SURF, "QCT QSD8X50 SURF")
 MACHINE_END
 
 MACHINE_START(QSD8X50A_ST1_5, "QCT QSD8X50A ST1.5")
-	.boot_params = PLAT_PHYS_OFFSET + 0x100,
+	.atag_offset = 0x100,
 	.map_io = qsd8x50_map_io,
 	.init_irq = qsd8x50_init_irq,
 	.init_machine = qsd8x50_init,
diff --git a/arch/arm/mach-msm/board-sapphire.c b/arch/arm/mach-msm/board-sapphire.c
index 68f930f..dc0bcb5 100644
--- a/arch/arm/mach-msm/board-sapphire.c
+++ b/arch/arm/mach-msm/board-sapphire.c
@@ -105,7 +105,7 @@ static void __init sapphire_map_io(void)
 
 MACHINE_START(SAPPHIRE, "sapphire")
 /* Maintainer: Brian Swetland <swetland@google.com> */
-	.boot_params    = PLAT_PHYS_OFFSET + 0x100,
+	.atag_offset    = 0x100,
 	.fixup          = sapphire_fixup,
 	.map_io         = sapphire_map_io,
 	.init_irq       = sapphire_init_irq,
diff --git a/arch/arm/mach-msm/board-trout.c b/arch/arm/mach-msm/board-trout.c
index 8143867..22d5694 100644
--- a/arch/arm/mach-msm/board-trout.c
+++ b/arch/arm/mach-msm/board-trout.c
@@ -93,7 +93,7 @@ static void __init trout_map_io(void)
 }
 
 MACHINE_START(TROUT, "HTC Dream")
-	.boot_params	= 0x10000100,
+	.atag_offset	= 0x100,
 	.fixup		= trout_fixup,
 	.map_io		= trout_map_io,
 	.init_irq	= trout_init_irq,
-- 
1.7.4
