From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 05 Jul 2011 22:30:40 -0400
Subject: [PATCH 08/10] ARM: mach-sa1100: move ARM_DMA_ZONE_SIZE to
	mdesc->dma_zone_size
In-Reply-To: <1309919442-20451-1-git-send-email-nicolas.pitre@linaro.org>
References: <1309919442-20451-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1309919442-20451-8-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/mach-sa1100/assabet.c             |    3 +++
 arch/arm/mach-sa1100/badge4.c              |    3 +++
 arch/arm/mach-sa1100/include/mach/memory.h |    4 ----
 arch/arm/mach-sa1100/jornada720.c          |    3 +++
 4 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-sa1100/assabet.c b/arch/arm/mach-sa1100/assabet.c
index 5778274..26257df 100644
--- a/arch/arm/mach-sa1100/assabet.c
+++ b/arch/arm/mach-sa1100/assabet.c
@@ -453,4 +453,7 @@ MACHINE_START(ASSABET, "Intel-Assabet")
 	.init_irq	= sa1100_init_irq,
 	.timer		= &sa1100_timer,
 	.init_machine	= assabet_init,
+#ifdef CONFIG_SA1111
+	.dma_zone_size	= SZ_1M,
+#endif
 MACHINE_END
diff --git a/arch/arm/mach-sa1100/badge4.c b/arch/arm/mach-sa1100/badge4.c
index 4f19ff8..b4311b0 100644
--- a/arch/arm/mach-sa1100/badge4.c
+++ b/arch/arm/mach-sa1100/badge4.c
@@ -306,4 +306,7 @@ MACHINE_START(BADGE4, "Hewlett-Packard Laboratories BadgePAD 4")
 	.map_io		= badge4_map_io,
 	.init_irq	= sa1100_init_irq,
 	.timer		= &sa1100_timer,
+#ifdef CONFIG_SA1111
+	.dma_zone_size	= SZ_1M,
+#endif
 MACHINE_END
diff --git a/arch/arm/mach-sa1100/include/mach/memory.h b/arch/arm/mach-sa1100/include/mach/memory.h
index cff31ee..12d3767 100644
--- a/arch/arm/mach-sa1100/include/mach/memory.h
+++ b/arch/arm/mach-sa1100/include/mach/memory.h
@@ -14,10 +14,6 @@
  */
 #define PLAT_PHYS_OFFSET	UL(0xc0000000)
 
-#ifdef CONFIG_SA1111
-#define ARM_DMA_ZONE_SIZE	SZ_1M
-#endif
-
 /*
  * Because of the wide memory address space between physical RAM banks on the
  * SA1100, it's much convenient to use Linux's SparseMEM support to implement
diff --git a/arch/arm/mach-sa1100/jornada720.c b/arch/arm/mach-sa1100/jornada720.c
index 491ac9f..176c066 100644
--- a/arch/arm/mach-sa1100/jornada720.c
+++ b/arch/arm/mach-sa1100/jornada720.c
@@ -369,4 +369,7 @@ MACHINE_START(JORNADA720, "HP Jornada 720")
 	.init_irq	= sa1100_init_irq,
 	.timer		= &sa1100_timer,
 	.init_machine	= jornada720_mach_init,
+#ifdef CONFIG_SA1111
+	.dma_zone_size	= SZ_1M,
+#endif
 MACHINE_END
-- 
1.7.4
