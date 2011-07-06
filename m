From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 05 Jul 2011 22:30:35 -0400
Subject: [PATCH 03/10] ARM: mach-davinci: move from ARM_DMA_ZONE_SIZE to
	mdesc->dma_zone_size
In-Reply-To: <1309919442-20451-1-git-send-email-nicolas.pitre@linaro.org>
References: <1309919442-20451-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1309919442-20451-3-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/mach-davinci/board-da830-evm.c     |    1 +
 arch/arm/mach-davinci/board-da850-evm.c     |    1 +
 arch/arm/mach-davinci/board-dm355-evm.c     |    1 +
 arch/arm/mach-davinci/board-dm355-leopard.c |    1 +
 arch/arm/mach-davinci/board-dm365-evm.c     |    1 +
 arch/arm/mach-davinci/board-dm644x-evm.c    |    1 +
 arch/arm/mach-davinci/board-dm646x-evm.c    |    2 ++
 arch/arm/mach-davinci/board-mityomapl138.c  |    1 +
 arch/arm/mach-davinci/board-neuros-osd2.c   |    1 +
 arch/arm/mach-davinci/board-omapl138-hawk.c |    1 +
 arch/arm/mach-davinci/board-sffsdr.c        |    1 +
 arch/arm/mach-davinci/board-tnetv107x-evm.c |    1 +
 arch/arm/mach-davinci/include/mach/memory.h |    7 -------
 13 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-davinci/board-da830-evm.c b/arch/arm/mach-davinci/board-da830-evm.c
index 8bc3701..84fd7868 100644
--- a/arch/arm/mach-davinci/board-da830-evm.c
+++ b/arch/arm/mach-davinci/board-da830-evm.c
@@ -681,4 +681,5 @@ MACHINE_START(DAVINCI_DA830_EVM, "DaVinci DA830/OMAP-L137/AM17x EVM")
 	.init_irq	= cp_intc_init,
 	.timer		= &davinci_timer,
 	.init_machine	= da830_evm_init,
+	.dma_zone_size	= SZ_128M,
 MACHINE_END
diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
index a7b41bf..29671ef 100644
--- a/arch/arm/mach-davinci/board-da850-evm.c
+++ b/arch/arm/mach-davinci/board-da850-evm.c
@@ -1261,4 +1261,5 @@ MACHINE_START(DAVINCI_DA850_EVM, "DaVinci DA850/OMAP-L138/AM18x EVM")
 	.init_irq	= cp_intc_init,
 	.timer		= &davinci_timer,
 	.init_machine	= da850_evm_init,
+	.dma_zone_size	= SZ_128M,
 MACHINE_END
diff --git a/arch/arm/mach-davinci/board-dm355-evm.c b/arch/arm/mach-davinci/board-dm355-evm.c
index 6e7cad13..241a6bd 100644
--- a/arch/arm/mach-davinci/board-dm355-evm.c
+++ b/arch/arm/mach-davinci/board-dm355-evm.c
@@ -356,4 +356,5 @@ MACHINE_START(DAVINCI_DM355_EVM, "DaVinci DM355 EVM")
 	.init_irq     = davinci_irq_init,
 	.timer	      = &davinci_timer,
 	.init_machine = dm355_evm_init,
+	.dma_zone_size	= SZ_128M,
 MACHINE_END
diff --git a/arch/arm/mach-davinci/board-dm355-leopard.c b/arch/arm/mach-davinci/board-dm355-leopard.c
index 543f991..bee284c 100644
--- a/arch/arm/mach-davinci/board-dm355-leopard.c
+++ b/arch/arm/mach-davinci/board-dm355-leopard.c
@@ -275,4 +275,5 @@ MACHINE_START(DM355_LEOPARD, "DaVinci DM355 leopard")
 	.init_irq     = davinci_irq_init,
 	.timer	      = &davinci_timer,
 	.init_machine = dm355_leopard_init,
+	.dma_zone_size	= SZ_128M,
 MACHINE_END
diff --git a/arch/arm/mach-davinci/board-dm365-evm.c b/arch/arm/mach-davinci/board-dm365-evm.c
index c67f684..9844fa4 100644
--- a/arch/arm/mach-davinci/board-dm365-evm.c
+++ b/arch/arm/mach-davinci/board-dm365-evm.c
@@ -617,5 +617,6 @@ MACHINE_START(DAVINCI_DM365_EVM, "DaVinci DM365 EVM")
 	.init_irq	= davinci_irq_init,
 	.timer		= &davinci_timer,
 	.init_machine	= dm365_evm_init,
+	.dma_zone_size	= SZ_128M,
 MACHINE_END
 
diff --git a/arch/arm/mach-davinci/board-dm644x-evm.c b/arch/arm/mach-davinci/board-dm644x-evm.c
index 556bbd4..95607a1 100644
--- a/arch/arm/mach-davinci/board-dm644x-evm.c
+++ b/arch/arm/mach-davinci/board-dm644x-evm.c
@@ -717,4 +717,5 @@ MACHINE_START(DAVINCI_EVM, "DaVinci DM644x EVM")
 	.init_irq     = davinci_irq_init,
 	.timer	      = &davinci_timer,
 	.init_machine = davinci_evm_init,
+	.dma_zone_size	= SZ_128M,
 MACHINE_END
diff --git a/arch/arm/mach-davinci/board-dm646x-evm.c b/arch/arm/mach-davinci/board-dm646x-evm.c
index f6ac9ba..6d03643 100644
--- a/arch/arm/mach-davinci/board-dm646x-evm.c
+++ b/arch/arm/mach-davinci/board-dm646x-evm.c
@@ -802,6 +802,7 @@ MACHINE_START(DAVINCI_DM6467_EVM, "DaVinci DM646x EVM")
 	.init_irq     = davinci_irq_init,
 	.timer        = &davinci_timer,
 	.init_machine = evm_init,
+	.dma_zone_size	= SZ_128M,
 MACHINE_END
 
 MACHINE_START(DAVINCI_DM6467TEVM, "DaVinci DM6467T EVM")
@@ -810,5 +811,6 @@ MACHINE_START(DAVINCI_DM6467TEVM, "DaVinci DM6467T EVM")
 	.init_irq     = davinci_irq_init,
 	.timer        = &davinci_timer,
 	.init_machine = evm_init,
+	.dma_zone_size	= SZ_128M,
 MACHINE_END
 
diff --git a/arch/arm/mach-davinci/board-mityomapl138.c b/arch/arm/mach-davinci/board-mityomapl138.c
index 606a6f2..b8d59ca 100644
--- a/arch/arm/mach-davinci/board-mityomapl138.c
+++ b/arch/arm/mach-davinci/board-mityomapl138.c
@@ -570,4 +570,5 @@ MACHINE_START(MITYOMAPL138, "MityDSP-L138/MityARM-1808")
 	.init_irq	= cp_intc_init,
 	.timer		= &davinci_timer,
 	.init_machine	= mityomapl138_init,
+	.dma_zone_size	= SZ_128M,
 MACHINE_END
diff --git a/arch/arm/mach-davinci/board-neuros-osd2.c b/arch/arm/mach-davinci/board-neuros-osd2.c
index 3e7be2d..d60a800 100644
--- a/arch/arm/mach-davinci/board-neuros-osd2.c
+++ b/arch/arm/mach-davinci/board-neuros-osd2.c
@@ -277,4 +277,5 @@ MACHINE_START(NEUROS_OSD2, "Neuros OSD2")
 	.init_irq	= davinci_irq_init,
 	.timer		= &davinci_timer,
 	.init_machine = davinci_ntosd2_init,
+	.dma_zone_size	= SZ_128M,
 MACHINE_END
diff --git a/arch/arm/mach-davinci/board-omapl138-hawk.c b/arch/arm/mach-davinci/board-omapl138-hawk.c
index 67c38d0..237332a 100644
--- a/arch/arm/mach-davinci/board-omapl138-hawk.c
+++ b/arch/arm/mach-davinci/board-omapl138-hawk.c
@@ -343,4 +343,5 @@ MACHINE_START(OMAPL138_HAWKBOARD, "AM18x/OMAP-L138 Hawkboard")
 	.init_irq	= cp_intc_init,
 	.timer		= &davinci_timer,
 	.init_machine	= omapl138_hawk_init,
+	.dma_zone_size	= SZ_128M,
 MACHINE_END
diff --git a/arch/arm/mach-davinci/board-sffsdr.c b/arch/arm/mach-davinci/board-sffsdr.c
index 61ac96d..5f4385c 100644
--- a/arch/arm/mach-davinci/board-sffsdr.c
+++ b/arch/arm/mach-davinci/board-sffsdr.c
@@ -156,4 +156,5 @@ MACHINE_START(SFFSDR, "Lyrtech SFFSDR")
 	.init_irq     = davinci_irq_init,
 	.timer	      = &davinci_timer,
 	.init_machine = davinci_sffsdr_init,
+	.dma_zone_size	= SZ_128M,
 MACHINE_END
diff --git a/arch/arm/mach-davinci/board-tnetv107x-evm.c b/arch/arm/mach-davinci/board-tnetv107x-evm.c
index 1a656e8..7828920 100644
--- a/arch/arm/mach-davinci/board-tnetv107x-evm.c
+++ b/arch/arm/mach-davinci/board-tnetv107x-evm.c
@@ -282,4 +282,5 @@ MACHINE_START(TNETV107X, "TNETV107X EVM")
 	.init_irq	= cp_intc_init,
 	.timer		= &davinci_timer,
 	.init_machine	= tnetv107x_evm_board_init,
+	.dma_zone_size	= SZ_128M,
 MACHINE_END
diff --git a/arch/arm/mach-davinci/include/mach/memory.h b/arch/arm/mach-davinci/include/mach/memory.h
index 491249e..7873194 100644
--- a/arch/arm/mach-davinci/include/mach/memory.h
+++ b/arch/arm/mach-davinci/include/mach/memory.h
@@ -41,11 +41,4 @@
  */
 #define CONSISTENT_DMA_SIZE (14<<20)
 
-/*
- * Restrict DMA-able region to workaround silicon bug.  The bug
- * restricts buffers available for DMA to video hardware to be
- * below 128M
- */
-#define ARM_DMA_ZONE_SIZE	SZ_128M
-
 #endif /* __ASM_ARCH_MEMORY_H */
-- 
1.7.4
