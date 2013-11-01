From: dmitry_eremin@mentor.com (Dmitry Eremin-Solenikov)
Date: Fri,  1 Nov 2013 14:52:09 +0400
Subject: [PATCH 2/4] ARM: sa1100: enable MULTI_IRQ_HANDLER for all boards
In-Reply-To: <1383303131-29550-1-git-send-email-dmitry_eremin@mentor.com>
References: <1383303131-29550-1-git-send-email-dmitry_eremin@mentor.com>
Message-ID: <1383303131-29550-2-git-send-email-dmitry_eremin@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use sa1100_handle_irq to handle irqs on all sa1100 boards.

Signed-off-by: Dmitry Eremin-Solenikov <dmitry_eremin@mentor.com>
---
 arch/arm/Kconfig                  | 1 +
 arch/arm/mach-sa1100/assabet.c    | 1 +
 arch/arm/mach-sa1100/badge4.c     | 1 +
 arch/arm/mach-sa1100/cerf.c       | 1 +
 arch/arm/mach-sa1100/collie.c     | 1 +
 arch/arm/mach-sa1100/h3100.c      | 1 +
 arch/arm/mach-sa1100/h3600.c      | 1 +
 arch/arm/mach-sa1100/hackkit.c    | 1 +
 arch/arm/mach-sa1100/jornada720.c | 1 +
 arch/arm/mach-sa1100/lart.c       | 1 +
 arch/arm/mach-sa1100/nanoengine.c | 1 +
 arch/arm/mach-sa1100/pleb.c       | 1 +
 arch/arm/mach-sa1100/shannon.c    | 1 +
 arch/arm/mach-sa1100/simpad.c     | 1 +
 14 files changed, 14 insertions(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 799ef94..5c86d8a 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -693,6 +693,7 @@ config ARCH_SA1100
 	select GENERIC_CLOCKEVENTS
 	select HAVE_IDE
 	select ISA
+	select MULTI_IRQ_HANDLER
 	select NEED_MACH_MEMORY_H
 	select SPARSE_IRQ
 	help
diff --git a/arch/arm/mach-sa1100/assabet.c b/arch/arm/mach-sa1100/assabet.c
index c9808c6..d745297 100644
--- a/arch/arm/mach-sa1100/assabet.c
+++ b/arch/arm/mach-sa1100/assabet.c
@@ -625,6 +625,7 @@ MACHINE_START(ASSABET, "Intel-Assabet")
 	.map_io		= assabet_map_io,
 	.nr_irqs	= SA1100_NR_IRQS,
 	.init_irq	= sa1100_init_irq,
+	.handle_irq	= sa1100_handle_irq,
 	.init_time	= sa1100_timer_init,
 	.init_machine	= assabet_init,
 	.init_late	= sa11x0_init_late,
diff --git a/arch/arm/mach-sa1100/badge4.c b/arch/arm/mach-sa1100/badge4.c
index 63361b6..acbaae4 100644
--- a/arch/arm/mach-sa1100/badge4.c
+++ b/arch/arm/mach-sa1100/badge4.c
@@ -335,6 +335,7 @@ MACHINE_START(BADGE4, "Hewlett-Packard Laboratories BadgePAD 4")
 	.map_io		= badge4_map_io,
 	.nr_irqs	= SA1100_NR_IRQS,
 	.init_irq	= sa1100_init_irq,
+	.handle_irq	= sa1100_handle_irq,
 	.init_late	= sa11x0_init_late,
 	.init_time	= sa1100_timer_init,
 #ifdef CONFIG_SA1111
diff --git a/arch/arm/mach-sa1100/cerf.c b/arch/arm/mach-sa1100/cerf.c
index 2d25ece..cad0ada 100644
--- a/arch/arm/mach-sa1100/cerf.c
+++ b/arch/arm/mach-sa1100/cerf.c
@@ -174,6 +174,7 @@ MACHINE_START(CERF, "Intrinsyc CerfBoard/CerfCube")
 	.map_io		= cerf_map_io,
 	.nr_irqs	= SA1100_NR_IRQS,
 	.init_irq	= cerf_init_irq,
+	.handle_irq	= sa1100_handle_irq,
 	.init_time	= sa1100_timer_init,
 	.init_machine	= cerf_init,
 	.init_late	= sa11x0_init_late,
diff --git a/arch/arm/mach-sa1100/collie.c b/arch/arm/mach-sa1100/collie.c
index 7fb96eb..3e26ddc 100644
--- a/arch/arm/mach-sa1100/collie.c
+++ b/arch/arm/mach-sa1100/collie.c
@@ -399,6 +399,7 @@ MACHINE_START(COLLIE, "Sharp-Collie")
 	.map_io		= collie_map_io,
 	.nr_irqs	= SA1100_NR_IRQS,
 	.init_irq	= sa1100_init_irq,
+	.handle_irq	= sa1100_handle_irq,
 	.init_time	= sa1100_timer_init,
 	.init_machine	= collie_init,
 	.init_late	= sa11x0_init_late,
diff --git a/arch/arm/mach-sa1100/h3100.c b/arch/arm/mach-sa1100/h3100.c
index b8f2b15..5ab169d 100644
--- a/arch/arm/mach-sa1100/h3100.c
+++ b/arch/arm/mach-sa1100/h3100.c
@@ -108,6 +108,7 @@ MACHINE_START(H3100, "Compaq iPAQ H3100")
 	.map_io		= h3100_map_io,
 	.nr_irqs	= SA1100_NR_IRQS,
 	.init_irq	= sa1100_init_irq,
+	.handle_irq	= sa1100_handle_irq,
 	.init_time	= sa1100_timer_init,
 	.init_machine	= h3100_mach_init,
 	.init_late	= sa11x0_init_late,
diff --git a/arch/arm/mach-sa1100/h3600.c b/arch/arm/mach-sa1100/h3600.c
index b8dc5bd..7209c0e 100644
--- a/arch/arm/mach-sa1100/h3600.c
+++ b/arch/arm/mach-sa1100/h3600.c
@@ -158,6 +158,7 @@ MACHINE_START(H3600, "Compaq iPAQ H3600")
 	.map_io		= h3600_map_io,
 	.nr_irqs	= SA1100_NR_IRQS,
 	.init_irq	= sa1100_init_irq,
+	.handle_irq	= sa1100_handle_irq,
 	.init_time	= sa1100_timer_init,
 	.init_machine	= h3600_mach_init,
 	.init_late	= sa11x0_init_late,
diff --git a/arch/arm/mach-sa1100/hackkit.c b/arch/arm/mach-sa1100/hackkit.c
index 643d5f2..1998805 100644
--- a/arch/arm/mach-sa1100/hackkit.c
+++ b/arch/arm/mach-sa1100/hackkit.c
@@ -229,6 +229,7 @@ MACHINE_START(HACKKIT, "HackKit Cpu Board")
 	.map_io		= hackkit_map_io,
 	.nr_irqs	= SA1100_NR_IRQS,
 	.init_irq	= sa1100_init_irq,
+	.handle_irq	= sa1100_handle_irq,
 	.init_time	= sa1100_timer_init,
 	.init_machine	= hackkit_init,
 	.init_late	= sa11x0_init_late,
diff --git a/arch/arm/mach-sa1100/jornada720.c b/arch/arm/mach-sa1100/jornada720.c
index c0b1f5b..74d5894 100644
--- a/arch/arm/mach-sa1100/jornada720.c
+++ b/arch/arm/mach-sa1100/jornada720.c
@@ -346,6 +346,7 @@ MACHINE_START(JORNADA720, "HP Jornada 720")
 	.map_io		= jornada720_map_io,
 	.nr_irqs	= SA1100_NR_IRQS,
 	.init_irq	= sa1100_init_irq,
+	.handle_irq	= sa1100_handle_irq,
 	.init_time	= sa1100_timer_init,
 	.init_machine	= jornada720_mach_init,
 	.init_late	= sa11x0_init_late,
diff --git a/arch/arm/mach-sa1100/lart.c b/arch/arm/mach-sa1100/lart.c
index 51b0eb5..2f3c8a1 100644
--- a/arch/arm/mach-sa1100/lart.c
+++ b/arch/arm/mach-sa1100/lart.c
@@ -169,6 +169,7 @@ MACHINE_START(LART, "LART")
 	.map_io		= lart_map_io,
 	.nr_irqs	= SA1100_NR_IRQS,
 	.init_irq	= sa1100_init_irq,
+	.handle_irq	= sa1100_handle_irq,
 	.init_machine	= lart_init,
 	.init_late	= sa11x0_init_late,
 	.init_time	= sa1100_timer_init,
diff --git a/arch/arm/mach-sa1100/nanoengine.c b/arch/arm/mach-sa1100/nanoengine.c
index f1cb378..b35b1ca 100644
--- a/arch/arm/mach-sa1100/nanoengine.c
+++ b/arch/arm/mach-sa1100/nanoengine.c
@@ -110,6 +110,7 @@ MACHINE_START(NANOENGINE, "BSE nanoEngine")
 	.map_io		= nanoengine_map_io,
 	.nr_irqs	= SA1100_NR_IRQS,
 	.init_irq	= sa1100_init_irq,
+	.handle_irq	= sa1100_handle_irq,
 	.init_time	= sa1100_timer_init,
 	.init_machine	= nanoengine_init,
 	.init_late	= sa11x0_init_late,
diff --git a/arch/arm/mach-sa1100/pleb.c b/arch/arm/mach-sa1100/pleb.c
index 0912618..f35c4d9 100644
--- a/arch/arm/mach-sa1100/pleb.c
+++ b/arch/arm/mach-sa1100/pleb.c
@@ -133,6 +133,7 @@ MACHINE_START(PLEB, "PLEB")
 	.map_io		= pleb_map_io,
 	.nr_irqs	= SA1100_NR_IRQS,
 	.init_irq	= sa1100_init_irq,
+	.handle_irq	= sa1100_handle_irq,
 	.init_time	= sa1100_timer_init,
 	.init_machine   = pleb_init,
 	.init_late	= sa11x0_init_late,
diff --git a/arch/arm/mach-sa1100/shannon.c b/arch/arm/mach-sa1100/shannon.c
index c8866bc..975dc95 100644
--- a/arch/arm/mach-sa1100/shannon.c
+++ b/arch/arm/mach-sa1100/shannon.c
@@ -102,6 +102,7 @@ MACHINE_START(SHANNON, "Shannon (AKA: Tuxscreen)")
 	.map_io		= shannon_map_io,
 	.nr_irqs	= SA1100_NR_IRQS,
 	.init_irq	= sa1100_init_irq,
+	.handle_irq	= sa1100_handle_irq,
 	.init_time	= sa1100_timer_init,
 	.init_machine	= shannon_init,
 	.init_late	= sa11x0_init_late,
diff --git a/arch/arm/mach-sa1100/simpad.c b/arch/arm/mach-sa1100/simpad.c
index 41e476e..f40b07e 100644
--- a/arch/arm/mach-sa1100/simpad.c
+++ b/arch/arm/mach-sa1100/simpad.c
@@ -396,6 +396,7 @@ MACHINE_START(SIMPAD, "Simpad")
 	.map_io		= simpad_map_io,
 	.nr_irqs	= SA1100_NR_IRQS,
 	.init_irq	= sa1100_init_irq,
+	.handle_irq	= sa1100_handle_irq,
 	.init_late	= sa11x0_init_late,
 	.init_time	= sa1100_timer_init,
 	.restart	= sa11x0_restart,
-- 
1.8.4.rc3
