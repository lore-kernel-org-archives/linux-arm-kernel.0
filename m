From: anup.patel@broadcom.com (Anup Patel)
Date: Tue,  3 Oct 2017 10:53:00 +0530
Subject: [PATCH 4/4] dmaengine: Build bcm-sba-raid driver as loadable module
 for iProc SoCs
In-Reply-To: <1507008180-27171-1-git-send-email-anup.patel@broadcom.com>
References: <1507008180-27171-1-git-send-email-anup.patel@broadcom.com>
Message-ID: <1507008180-27171-5-git-send-email-anup.patel@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

By default, we build Broadcom SBA RAID driver as loadable module for
iProc SOCs so that kernel image is little smaller and we load SBA RAID
driver only when required.

Signed-off-by: Anup Patel <anup.patel@broadcom.com>
Reviewed-by: Scott Branden <scott.branden@broadcom.com>
---
 drivers/dma/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index fadc4d8..48cf8df 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -115,7 +115,7 @@ config BCM_SBA_RAID
 	select DMA_ENGINE_RAID
 	select ASYNC_TX_DISABLE_XOR_VAL_DMA
 	select ASYNC_TX_DISABLE_PQ_VAL_DMA
-	default ARCH_BCM_IPROC
+	default m if ARCH_BCM_IPROC
 	help
 	  Enable support for Broadcom SBA RAID Engine. The SBA RAID
 	  engine is available on most of the Broadcom iProc SoCs. It
-- 
2.7.4
