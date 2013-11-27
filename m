From: laurent.pinchart+renesas@ideasonboard.com (Laurent Pinchart)
Date: Wed, 27 Nov 2013 02:18:27 +0100
Subject: [PATCH 05/15] DMA: shdma: Enable driver compilation with COMPILE_TEST
In-Reply-To: <1385515117-23664-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1385515117-23664-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <1385515117-23664-6-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This helps increasing build testing coverage.

Cc: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
Cc: Vinod Koul <vinod.koul@intel.com>
Cc: dmaengine at vger.kernel.org
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Simon Horman <horms@verge.net.au>
---
 drivers/dma/sh/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/sh/Kconfig b/drivers/dma/sh/Kconfig
index dadd9e01..dc0fe03 100644
--- a/drivers/dma/sh/Kconfig
+++ b/drivers/dma/sh/Kconfig
@@ -4,7 +4,7 @@
 
 config SH_DMAE_BASE
 	bool "Renesas SuperH DMA Engine support"
-	depends on (SUPERH && SH_DMA) || (ARM && ARCH_SHMOBILE)
+	depends on (SUPERH && SH_DMA) || ARCH_SHMOBILE || COMPILE_TEST
 	depends on !SH_DMA_API
 	default y
 	select DMA_ENGINE
-- 
1.8.3.2
