From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 05 Jul 2011 22:30:41 -0400
Subject: [PATCH 09/10] ARM: mach-shark: move ARM_DMA_ZONE_SIZE to
	mdesc->dma_zone_size
In-Reply-To: <1309919442-20451-1-git-send-email-nicolas.pitre@linaro.org>
References: <1309919442-20451-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1309919442-20451-9-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/mach-shark/core.c                |    1 +
 arch/arm/mach-shark/include/mach/memory.h |    2 --
 2 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-shark/core.c b/arch/arm/mach-shark/core.c
index 5cf7f94..ac2873c 100644
--- a/arch/arm/mach-shark/core.c
+++ b/arch/arm/mach-shark/core.c
@@ -156,4 +156,5 @@ MACHINE_START(SHARK, "Shark")
 	.map_io		= shark_map_io,
 	.init_irq	= shark_init_irq,
 	.timer		= &shark_timer,
+	.dma_zone_size	= SZ_4M,
 MACHINE_END
diff --git a/arch/arm/mach-shark/include/mach/memory.h b/arch/arm/mach-shark/include/mach/memory.h
index 4c0831f8..1cf8d69 100644
--- a/arch/arm/mach-shark/include/mach/memory.h
+++ b/arch/arm/mach-shark/include/mach/memory.h
@@ -17,8 +17,6 @@
  */
 #define PLAT_PHYS_OFFSET     UL(0x08000000)
 
-#define ARM_DMA_ZONE_SIZE	SZ_4M
-
 /*
  * Cache flushing area
  */
-- 
1.7.4
