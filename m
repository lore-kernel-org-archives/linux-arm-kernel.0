From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 05 Jul 2011 22:47:26 -0400
Subject: [PATCH 41/52] ARM: mach-sa1100: convert boot_params to atag_offset
In-Reply-To: <1309920457-21913-1-git-send-email-nicolas.pitre@linaro.org>
References: <1309920457-21913-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1309920457-21913-41-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/mach-sa1100/assabet.c    |    2 +-
 arch/arm/mach-sa1100/badge4.c     |    2 +-
 arch/arm/mach-sa1100/h3100.c      |    2 +-
 arch/arm/mach-sa1100/h3600.c      |    2 +-
 arch/arm/mach-sa1100/hackkit.c    |    2 +-
 arch/arm/mach-sa1100/jornada720.c |    2 +-
 arch/arm/mach-sa1100/lart.c       |    2 +-
 arch/arm/mach-sa1100/nanoengine.c |    2 +-
 arch/arm/mach-sa1100/shannon.c    |    2 +-
 arch/arm/mach-sa1100/simpad.c     |    2 +-
 10 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-sa1100/assabet.c b/arch/arm/mach-sa1100/assabet.c
index 26257df..d40da5f 100644
--- a/arch/arm/mach-sa1100/assabet.c
+++ b/arch/arm/mach-sa1100/assabet.c
@@ -447,7 +447,7 @@ static void __init assabet_map_io(void)
 
 
 MACHINE_START(ASSABET, "Intel-Assabet")
-	.boot_params	= 0xc0000100,
+	.atag_offset	= 0x100,
 	.fixup		= fixup_assabet,
 	.map_io		= assabet_map_io,
 	.init_irq	= sa1100_init_irq,
diff --git a/arch/arm/mach-sa1100/badge4.c b/arch/arm/mach-sa1100/badge4.c
index b4311b0..bda83e1 100644
--- a/arch/arm/mach-sa1100/badge4.c
+++ b/arch/arm/mach-sa1100/badge4.c
@@ -302,7 +302,7 @@ static void __init badge4_map_io(void)
 }
 
 MACHINE_START(BADGE4, "Hewlett-Packard Laboratories BadgePAD 4")
-	.boot_params	= 0xc0000100,
+	.atag_offset	= 0x100,
 	.map_io		= badge4_map_io,
 	.init_irq	= sa1100_init_irq,
 	.timer		= &sa1100_timer,
diff --git a/arch/arm/mach-sa1100/h3100.c b/arch/arm/mach-sa1100/h3100.c
index 03d7376..b30733a 100644
--- a/arch/arm/mach-sa1100/h3100.c
+++ b/arch/arm/mach-sa1100/h3100.c
@@ -84,7 +84,7 @@ static void __init h3100_mach_init(void)
 }
 
 MACHINE_START(H3100, "Compaq iPAQ H3100")
-	.boot_params	= 0xc0000100,
+	.atag_offset	= 0x100,
 	.map_io		= h3100_map_io,
 	.init_irq	= sa1100_init_irq,
 	.timer		= &sa1100_timer,
diff --git a/arch/arm/mach-sa1100/h3600.c b/arch/arm/mach-sa1100/h3600.c
index 965f64a..6fd324d 100644
--- a/arch/arm/mach-sa1100/h3600.c
+++ b/arch/arm/mach-sa1100/h3600.c
@@ -125,7 +125,7 @@ static void __init h3600_mach_init(void)
 }
 
 MACHINE_START(H3600, "Compaq iPAQ H3600")
-	.boot_params	= 0xc0000100,
+	.atag_offset	= 0x100,
 	.map_io		= h3600_map_io,
 	.init_irq	= sa1100_init_irq,
 	.timer		= &sa1100_timer,
diff --git a/arch/arm/mach-sa1100/hackkit.c b/arch/arm/mach-sa1100/hackkit.c
index db5e434..30f4a55 100644
--- a/arch/arm/mach-sa1100/hackkit.c
+++ b/arch/arm/mach-sa1100/hackkit.c
@@ -195,7 +195,7 @@ static void __init hackkit_init(void)
  */
 
 MACHINE_START(HACKKIT, "HackKit Cpu Board")
-	.boot_params	= 0xc0000100,
+	.atag_offset	= 0x100,
 	.map_io		= hackkit_map_io,
 	.init_irq	= sa1100_init_irq,
 	.timer		= &sa1100_timer,
diff --git a/arch/arm/mach-sa1100/jornada720.c b/arch/arm/mach-sa1100/jornada720.c
index 176c066..0bb520d 100644
--- a/arch/arm/mach-sa1100/jornada720.c
+++ b/arch/arm/mach-sa1100/jornada720.c
@@ -364,7 +364,7 @@ static void __init jornada720_mach_init(void)
 
 MACHINE_START(JORNADA720, "HP Jornada 720")
 	/* Maintainer: Kristoffer Ericson <Kristoffer.Ericson@gmail.com> */
-	.boot_params	= 0xc0000100,
+	.atag_offset	= 0x100,
 	.map_io		= jornada720_map_io,
 	.init_irq	= sa1100_init_irq,
 	.timer		= &sa1100_timer,
diff --git a/arch/arm/mach-sa1100/lart.c b/arch/arm/mach-sa1100/lart.c
index 7b9556b..5bc59d0 100644
--- a/arch/arm/mach-sa1100/lart.c
+++ b/arch/arm/mach-sa1100/lart.c
@@ -61,7 +61,7 @@ static void __init lart_map_io(void)
 }
 
 MACHINE_START(LART, "LART")
-	.boot_params	= 0xc0000100,
+	.atag_offset	= 0x100,
 	.map_io		= lart_map_io,
 	.init_irq	= sa1100_init_irq,
 	.init_machine	= lart_init,
diff --git a/arch/arm/mach-sa1100/nanoengine.c b/arch/arm/mach-sa1100/nanoengine.c
index 72087f0..032f388 100644
--- a/arch/arm/mach-sa1100/nanoengine.c
+++ b/arch/arm/mach-sa1100/nanoengine.c
@@ -111,7 +111,7 @@ static void __init nanoengine_init(void)
 }
 
 MACHINE_START(NANOENGINE, "BSE nanoEngine")
-	.boot_params	= 0xc0000000,
+	.atag_offset	= 0x100,
 	.map_io		= nanoengine_map_io,
 	.init_irq	= sa1100_init_irq,
 	.timer		= &sa1100_timer,
diff --git a/arch/arm/mach-sa1100/shannon.c b/arch/arm/mach-sa1100/shannon.c
index 7917b24..1cccbf5 100644
--- a/arch/arm/mach-sa1100/shannon.c
+++ b/arch/arm/mach-sa1100/shannon.c
@@ -82,7 +82,7 @@ static void __init shannon_map_io(void)
 }
 
 MACHINE_START(SHANNON, "Shannon (AKA: Tuxscreen)")
-	.boot_params	= 0xc0000100,
+	.atag_offset	= 0x100,
 	.map_io		= shannon_map_io,
 	.init_irq	= sa1100_init_irq,
 	.timer		= &sa1100_timer,
diff --git a/arch/arm/mach-sa1100/simpad.c b/arch/arm/mach-sa1100/simpad.c
index cfb7607..a1c2427 100644
--- a/arch/arm/mach-sa1100/simpad.c
+++ b/arch/arm/mach-sa1100/simpad.c
@@ -229,7 +229,7 @@ arch_initcall(simpad_init);
 
 MACHINE_START(SIMPAD, "Simpad")
 	/* Maintainer: Holger Freyther */
-	.boot_params	= 0xc0000100,
+	.atag_offset	= 0x100,
 	.map_io		= simpad_map_io,
 	.init_irq	= sa1100_init_irq,
 	.timer		= &sa1100_timer,
-- 
1.7.4
