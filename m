From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 16 Apr 2012 12:46:30 +0200
Subject: [PATCH 13/13] dmaengine: Kconfig: fix Atmel at_hdmac entry
In-Reply-To: <cover.1334567594.git.nicolas.ferre@atmel.com>
References: <cover.1334567594.git.nicolas.ferre@atmel.com>
Message-ID: <1334573190-14931-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove SoC dependency and make it generic for every Atmel ARM AT91. That will
allow to select this driver for newer chips. Keep dependency on AT91 because of
the use of an header file located in include/mach directory.
Modify the comment to reflect this.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Acked-by: Vinod Koul <vinod.koul@linux.intel.com>
---
I keep this Kconfig modification in this "fixes" series. The DMA
driver will not be available for 9x5 SoC family otherwise.

 drivers/dma/Kconfig |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index cf9da36..ef378b5 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -91,11 +91,10 @@ config DW_DMAC
 
 config AT_HDMAC
 	tristate "Atmel AHB DMA support"
-	depends on ARCH_AT91SAM9RL || ARCH_AT91SAM9G45
+	depends on ARCH_AT91
 	select DMA_ENGINE
 	help
-	  Support the Atmel AHB DMA controller.  This can be integrated in
-	  chips such as the Atmel AT91SAM9RL.
+	  Support the Atmel AHB DMA controller.
 
 config FSL_DMA
 	tristate "Freescale Elo and Elo Plus DMA support"
-- 
1.7.10
