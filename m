From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 05 Jul 2011 22:30:38 -0400
Subject: [PATCH 06/10] ARM: mach-pxa: move from ARM_DMA_ZONE_SIZE to
	mdesc->dma_zone_size
In-Reply-To: <1309919442-20451-1-git-send-email-nicolas.pitre@linaro.org>
References: <1309919442-20451-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1309919442-20451-6-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/mach-pxa/cm-x2xx.c             |    3 +++
 arch/arm/mach-pxa/include/mach/memory.h |    4 ----
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-pxa/cm-x2xx.c b/arch/arm/mach-pxa/cm-x2xx.c
index a109967..bc55d07 100644
--- a/arch/arm/mach-pxa/cm-x2xx.c
+++ b/arch/arm/mach-pxa/cm-x2xx.c
@@ -518,4 +518,7 @@ MACHINE_START(ARMCORE, "Compulab CM-X2XX")
 	.init_irq	= cmx2xx_init_irq,
 	.timer		= &pxa_timer,
 	.init_machine	= cmx2xx_init,
+#ifdef CONFIG_PCI
+	.dma_zone_size	= SZ_64M,
+#endif
 MACHINE_END
diff --git a/arch/arm/mach-pxa/include/mach/memory.h b/arch/arm/mach-pxa/include/mach/memory.h
index 07734f3..d05a597 100644
--- a/arch/arm/mach-pxa/include/mach/memory.h
+++ b/arch/arm/mach-pxa/include/mach/memory.h
@@ -17,8 +17,4 @@
  */
 #define PLAT_PHYS_OFFSET	UL(0xa0000000)
 
-#if defined(CONFIG_MACH_ARMCORE) && defined(CONFIG_PCI)
-#define ARM_DMA_ZONE_SIZE	SZ_64M
-#endif
-
 #endif
-- 
1.7.4
