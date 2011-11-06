From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 06 Nov 2011 17:32:34 +0000
Subject: [PATCH 3/7] ARM: restart: add default restart modes for PXA mioa701,
 spitz and tosa
In-Reply-To: <20111106173113.GI12913@n2100.arm.linux.org.uk>
References: <20111106173113.GI12913@n2100.arm.linux.org.uk>
Message-ID: <E1RN6aA-0001N3-8T@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a default restart mode to reflect the hard-coded restart mode
found in these files.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-pxa/mioa701.c |    1 +
 arch/arm/mach-pxa/spitz.c   |    3 +++
 arch/arm/mach-pxa/tosa.c    |    1 +
 3 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-pxa/mioa701.c b/arch/arm/mach-pxa/mioa701.c
index b938fc2..4f47a76 100644
--- a/arch/arm/mach-pxa/mioa701.c
+++ b/arch/arm/mach-pxa/mioa701.c
@@ -752,6 +752,7 @@ static void mioa701_machine_exit(void)
 
 MACHINE_START(MIOA701, "MIO A701")
 	.atag_offset	= 0x100,
+	.restart_mode	= 's',
 	.map_io		= &pxa27x_map_io,
 	.init_irq	= &pxa27x_init_irq,
 	.handle_irq	= &pxa27x_handle_irq,
diff --git a/arch/arm/mach-pxa/spitz.c b/arch/arm/mach-pxa/spitz.c
index d8dec91..f5bafcc 100644
--- a/arch/arm/mach-pxa/spitz.c
+++ b/arch/arm/mach-pxa/spitz.c
@@ -981,6 +981,7 @@ static void __init spitz_fixup(struct tag *tags, char **cmdline,
 
 #ifdef CONFIG_MACH_SPITZ
 MACHINE_START(SPITZ, "SHARP Spitz")
+	.restart_mode	= 'g',
 	.fixup		= spitz_fixup,
 	.map_io		= pxa27x_map_io,
 	.init_irq	= pxa27x_init_irq,
@@ -992,6 +993,7 @@ MACHINE_END
 
 #ifdef CONFIG_MACH_BORZOI
 MACHINE_START(BORZOI, "SHARP Borzoi")
+	.restart_mode	= 'g',
 	.fixup		= spitz_fixup,
 	.map_io		= pxa27x_map_io,
 	.init_irq	= pxa27x_init_irq,
@@ -1003,6 +1005,7 @@ MACHINE_END
 
 #ifdef CONFIG_MACH_AKITA
 MACHINE_START(AKITA, "SHARP Akita")
+	.restart_mode	= 'g',
 	.fixup		= spitz_fixup,
 	.map_io		= pxa27x_map_io,
 	.init_irq	= pxa27x_init_irq,
diff --git a/arch/arm/mach-pxa/tosa.c b/arch/arm/mach-pxa/tosa.c
index 402b0c9..ef64530 100644
--- a/arch/arm/mach-pxa/tosa.c
+++ b/arch/arm/mach-pxa/tosa.c
@@ -970,6 +970,7 @@ static void __init fixup_tosa(struct tag *tags, char **cmdline,
 }
 
 MACHINE_START(TOSA, "SHARP Tosa")
+	.restart_mode	= 'g',
 	.fixup          = fixup_tosa,
 	.map_io         = pxa25x_map_io,
 	.nr_irqs	= TOSA_NR_IRQS,
-- 
1.7.4.4
