From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 05 Jul 2011 22:46:47 -0400
Subject: [PATCH 02/52] ARM: mach-clps711x: convert boot_params to atag_offset
In-Reply-To: <1309920457-21913-1-git-send-email-nicolas.pitre@linaro.org>
References: <1309920457-21913-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1309920457-21913-2-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/mach-clps711x/autcpu12.c     |    2 +-
 arch/arm/mach-clps711x/cdb89712.c     |    2 +-
 arch/arm/mach-clps711x/ceiva.c        |    2 +-
 arch/arm/mach-clps711x/clep7312.c     |    2 +-
 arch/arm/mach-clps711x/edb7211-arch.c |    2 +-
 arch/arm/mach-clps711x/fortunet.c     |    1 -
 arch/arm/mach-clps711x/p720t.c        |    2 +-
 7 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-clps711x/autcpu12.c b/arch/arm/mach-clps711x/autcpu12.c
index 4a74b2c..0276091 100644
--- a/arch/arm/mach-clps711x/autcpu12.c
+++ b/arch/arm/mach-clps711x/autcpu12.c
@@ -64,7 +64,7 @@ void __init autcpu12_map_io(void)
 
 MACHINE_START(AUTCPU12, "autronix autcpu12")
 	/* Maintainer: Thomas Gleixner */
-	.boot_params	= 0xc0020000,
+	.atag_offset	= 0x20000,
 	.map_io		= autcpu12_map_io,
 	.init_irq	= clps711x_init_irq,
 	.timer		= &clps711x_timer,
diff --git a/arch/arm/mach-clps711x/cdb89712.c b/arch/arm/mach-clps711x/cdb89712.c
index 5a1689d..25b3bfd 100644
--- a/arch/arm/mach-clps711x/cdb89712.c
+++ b/arch/arm/mach-clps711x/cdb89712.c
@@ -55,7 +55,7 @@ static void __init cdb89712_map_io(void)
 
 MACHINE_START(CDB89712, "Cirrus-CDB89712")
 	/* Maintainer: Ray Lehtiniemi */
-	.boot_params	= 0xc0000100,
+	.atag_offset	= 0x100,
 	.map_io		= cdb89712_map_io,
 	.init_irq	= clps711x_init_irq,
 	.timer		= &clps711x_timer,
diff --git a/arch/arm/mach-clps711x/ceiva.c b/arch/arm/mach-clps711x/ceiva.c
index 16481cf..1df9ec6 100644
--- a/arch/arm/mach-clps711x/ceiva.c
+++ b/arch/arm/mach-clps711x/ceiva.c
@@ -56,7 +56,7 @@ static void __init ceiva_map_io(void)
 
 MACHINE_START(CEIVA, "CEIVA/Polaroid Photo MAX Digital Picture Frame")
 	/* Maintainer: Rob Scott */
-	.boot_params	= 0xc0000100,
+	.atag_offset	= 0x100,
 	.map_io		= ceiva_map_io,
 	.init_irq	= clps711x_init_irq,
 	.timer		= &clps711x_timer,
diff --git a/arch/arm/mach-clps711x/clep7312.c b/arch/arm/mach-clps711x/clep7312.c
index 67b5abb4..06c8abd 100644
--- a/arch/arm/mach-clps711x/clep7312.c
+++ b/arch/arm/mach-clps711x/clep7312.c
@@ -37,7 +37,7 @@ fixup_clep7312(struct machine_desc *desc, struct tag *tags,
 
 MACHINE_START(CLEP7212, "Cirrus Logic 7212/7312")
 	/* Maintainer: Nobody */
-	.boot_params	= 0xc0000100,
+	.atag_offset	= 0x0100,
 	.fixup		= fixup_clep7312,
 	.map_io		= clps711x_map_io,
 	.init_irq	= clps711x_init_irq,
diff --git a/arch/arm/mach-clps711x/edb7211-arch.c b/arch/arm/mach-clps711x/edb7211-arch.c
index 98ca5b2..abf522d 100644
--- a/arch/arm/mach-clps711x/edb7211-arch.c
+++ b/arch/arm/mach-clps711x/edb7211-arch.c
@@ -57,7 +57,7 @@ fixup_edb7211(struct machine_desc *desc, struct tag *tags,
 
 MACHINE_START(EDB7211, "CL-EDB7211 (EP7211 eval board)")
 	/* Maintainer: Jon McClintock */
-	.boot_params	= 0xc0020100,	/* 0xc0000000 - 0xc001ffff can be video RAM */
+	.atag_offset	= 0x20100,	/* 0xc0000000 - 0xc001ffff can be video RAM */
 	.fixup		= fixup_edb7211,
 	.map_io		= edb7211_map_io,
 	.reserve	= edb7211_reserve,
diff --git a/arch/arm/mach-clps711x/fortunet.c b/arch/arm/mach-clps711x/fortunet.c
index b1cb479..b6f7d86 100644
--- a/arch/arm/mach-clps711x/fortunet.c
+++ b/arch/arm/mach-clps711x/fortunet.c
@@ -75,7 +75,6 @@ fortunet_fixup(struct machine_desc *desc, struct tag *tags,
 
 MACHINE_START(FORTUNET, "ARM-FortuNet")
 	/* Maintainer: FortuNet Inc. */
-	.boot_params	= 0x00000000,
 	.fixup		= fortunet_fixup,
 	.map_io		= clps711x_map_io,
 	.init_irq	= clps711x_init_irq,
diff --git a/arch/arm/mach-clps711x/p720t.c b/arch/arm/mach-clps711x/p720t.c
index cefbce0..e7f75ae 100644
--- a/arch/arm/mach-clps711x/p720t.c
+++ b/arch/arm/mach-clps711x/p720t.c
@@ -89,7 +89,7 @@ static void __init p720t_map_io(void)
 
 MACHINE_START(P720T, "ARM-Prospector720T")
 	/* Maintainer: ARM Ltd/Deep Blue Solutions Ltd */
-	.boot_params	= 0xc0000100,
+	.atag_offset	= 0x100,
 	.fixup		= fixup_p720t,
 	.map_io		= p720t_map_io,
 	.init_irq	= clps711x_init_irq,
-- 
1.7.4
