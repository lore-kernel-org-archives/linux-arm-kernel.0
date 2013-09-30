From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Mon, 30 Sep 2013 18:41:25 -0400
Subject: [PATCH v2 3/5] dma: Allow TI_EDMA selectable for ARCH_KEYSTONE
In-Reply-To: <1380580887-24249-1-git-send-email-santosh.shilimkar@ti.com>
References: <1380580887-24249-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <1380580887-24249-4-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allow the TI_EDMA to be built for ARCH_KEYSTONE which also supports
the EDMA IP.

Cc: Vinod Koul <vinod.koul@intel.com>

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
Vinod,
I need your ack on this patch to carry $subject patch via arm-soc tree
to avoid the unmet dependency warnings.

 drivers/dma/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index 526ec77..b1dde16 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -195,7 +195,7 @@ config SIRF_DMA
 
 config TI_EDMA
 	bool "TI EDMA support"
-	depends on ARCH_DAVINCI || ARCH_OMAP
+	depends on ARCH_DAVINCI || ARCH_OMAP || ARCH_KEYSTONE
 	select DMA_ENGINE
 	select DMA_VIRTUAL_CHANNELS
 	default n
-- 
1.7.9.5
