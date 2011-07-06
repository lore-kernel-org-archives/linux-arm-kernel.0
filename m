From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 05 Jul 2011 22:30:36 -0400
Subject: [PATCH 04/10] ARM: mach-h720x: move from ARM_DMA_ZONE_SIZE to
	mdesc->dma_zone_size
In-Reply-To: <1309919442-20451-1-git-send-email-nicolas.pitre@linaro.org>
References: <1309919442-20451-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1309919442-20451-4-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/mach-h720x/h7201-eval.c          |    1 +
 arch/arm/mach-h720x/h7202-eval.c          |    1 +
 arch/arm/mach-h720x/include/mach/memory.h |    7 -------
 3 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-h720x/h7201-eval.c b/arch/arm/mach-h720x/h7201-eval.c
index 629454d..65f1bea 100644
--- a/arch/arm/mach-h720x/h7201-eval.c
+++ b/arch/arm/mach-h720x/h7201-eval.c
@@ -33,4 +33,5 @@ MACHINE_START(H7201, "Hynix GMS30C7201")
 	.map_io		= h720x_map_io,
 	.init_irq	= h720x_init_irq,
 	.timer		= &h7201_timer,
+	.dma_zone_size	= SZ_256M,
 MACHINE_END
diff --git a/arch/arm/mach-h720x/h7202-eval.c b/arch/arm/mach-h720x/h7202-eval.c
index e9f46b6..884584a 100644
--- a/arch/arm/mach-h720x/h7202-eval.c
+++ b/arch/arm/mach-h720x/h7202-eval.c
@@ -76,4 +76,5 @@ MACHINE_START(H7202, "Hynix HMS30C7202")
 	.init_irq	= h7202_init_irq,
 	.timer		= &h7202_timer,
 	.init_machine	= init_eval_h7202,
+	.dma_zone_size	= SZ_256M,
 MACHINE_END
diff --git a/arch/arm/mach-h720x/include/mach/memory.h b/arch/arm/mach-h720x/include/mach/memory.h
index b0b3bae..96dcf50 100644
--- a/arch/arm/mach-h720x/include/mach/memory.h
+++ b/arch/arm/mach-h720x/include/mach/memory.h
@@ -8,11 +8,4 @@
 #define __ASM_ARCH_MEMORY_H
 
 #define PLAT_PHYS_OFFSET	UL(0x40000000)
-/*
- * This is the maximum DMA address that can be DMAd to.
- * There should not be more than (0xd0000000 - 0xc0000000)
- * bytes of RAM.
- */
-#define ARM_DMA_ZONE_SIZE	SZ_256M
-
 #endif
-- 
1.7.4
