From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 05 Jul 2011 22:30:39 -0400
Subject: [PATCH 07/10] ARM: mach-realview: move from ARM_DMA_ZONE_SIZE to
	mdesc->dma_zone_size
In-Reply-To: <1309919442-20451-1-git-send-email-nicolas.pitre@linaro.org>
References: <1309919442-20451-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1309919442-20451-7-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/mach-realview/include/mach/memory.h |    4 ----
 arch/arm/mach-realview/realview_eb.c         |    3 +++
 arch/arm/mach-realview/realview_pb1176.c     |    3 +++
 arch/arm/mach-realview/realview_pb11mp.c     |    3 +++
 arch/arm/mach-realview/realview_pba8.c       |    3 +++
 arch/arm/mach-realview/realview_pbx.c        |    3 +++
 6 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-realview/include/mach/memory.h b/arch/arm/mach-realview/include/mach/memory.h
index 1759fa6..2022e09 100644
--- a/arch/arm/mach-realview/include/mach/memory.h
+++ b/arch/arm/mach-realview/include/mach/memory.h
@@ -29,10 +29,6 @@
 #define PLAT_PHYS_OFFSET		UL(0x00000000)
 #endif
 
-#ifdef CONFIG_ZONE_DMA
-#define ARM_DMA_ZONE_SIZE	SZ_256M
-#endif
-
 #ifdef CONFIG_SPARSEMEM
 
 /*
diff --git a/arch/arm/mach-realview/realview_eb.c b/arch/arm/mach-realview/realview_eb.c
index 10e75fa..006a11b 100644
--- a/arch/arm/mach-realview/realview_eb.c
+++ b/arch/arm/mach-realview/realview_eb.c
@@ -470,4 +470,7 @@ MACHINE_START(REALVIEW_EB, "ARM-RealView EB")
 	.init_irq	= gic_init_irq,
 	.timer		= &realview_eb_timer,
 	.init_machine	= realview_eb_init,
+#ifdef CONFIG_ZONE_DMA
+	.dma_zone_size	= SZ_128M,
+#endif
 MACHINE_END
diff --git a/arch/arm/mach-realview/realview_pb1176.c b/arch/arm/mach-realview/realview_pb1176.c
index eab6070..a43ca35 100644
--- a/arch/arm/mach-realview/realview_pb1176.c
+++ b/arch/arm/mach-realview/realview_pb1176.c
@@ -365,4 +365,7 @@ MACHINE_START(REALVIEW_PB1176, "ARM-RealView PB1176")
 	.init_irq	= gic_init_irq,
 	.timer		= &realview_pb1176_timer,
 	.init_machine	= realview_pb1176_init,
+#ifdef CONFIG_ZONE_DMA
+	.dma_zone_size	= SZ_128M,
+#endif
 MACHINE_END
diff --git a/arch/arm/mach-realview/realview_pb11mp.c b/arch/arm/mach-realview/realview_pb11mp.c
index b2985fc..1f56fef 100644
--- a/arch/arm/mach-realview/realview_pb11mp.c
+++ b/arch/arm/mach-realview/realview_pb11mp.c
@@ -367,4 +367,7 @@ MACHINE_START(REALVIEW_PB11MP, "ARM-RealView PB11MPCore")
 	.init_irq	= gic_init_irq,
 	.timer		= &realview_pb11mp_timer,
 	.init_machine	= realview_pb11mp_init,
+#ifdef CONFIG_ZONE_DMA
+	.dma_zone_size	= SZ_128M,
+#endif
 MACHINE_END
diff --git a/arch/arm/mach-realview/realview_pba8.c b/arch/arm/mach-realview/realview_pba8.c
index fb68665..64374d7 100644
--- a/arch/arm/mach-realview/realview_pba8.c
+++ b/arch/arm/mach-realview/realview_pba8.c
@@ -317,4 +317,7 @@ MACHINE_START(REALVIEW_PBA8, "ARM-RealView PB-A8")
 	.init_irq	= gic_init_irq,
 	.timer		= &realview_pba8_timer,
 	.init_machine	= realview_pba8_init,
+#ifdef CONFIG_ZONE_DMA
+	.dma_zone_size	= SZ_128M,
+#endif
 MACHINE_END
diff --git a/arch/arm/mach-realview/realview_pbx.c b/arch/arm/mach-realview/realview_pbx.c
index 92ace2c..1f9eae6 100644
--- a/arch/arm/mach-realview/realview_pbx.c
+++ b/arch/arm/mach-realview/realview_pbx.c
@@ -400,4 +400,7 @@ MACHINE_START(REALVIEW_PBX, "ARM-RealView PBX")
 	.init_irq	= gic_init_irq,
 	.timer		= &realview_pbx_timer,
 	.init_machine	= realview_pbx_init,
+#ifdef CONFIG_ZONE_DMA
+	.dma_zone_size	= SZ_128M,
+#endif
 MACHINE_END
-- 
1.7.4
