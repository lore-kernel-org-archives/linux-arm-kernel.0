From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 21 Jul 2011 17:11:26 +0100
Subject: [PATCH 1/9] DMA: PL08x: remove unused constants
In-Reply-To: <20110721160800.GR26574@n2100.arm.linux.org.uk>
References: <20110721160800.GR26574@n2100.arm.linux.org.uk>
Message-ID: <E1QjvqQ-0003MA-Au@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PL08X_WQ_PERIODMIN and PL08X_MAX_ALLOCS are not used, remove them.

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/dma/amba-pl08x.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index e6d7228..90db51f 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -156,14 +156,10 @@ struct pl08x_driver_data {
 #define PL08X_BOUNDARY_SHIFT		(10)	/* 1KB 0x400 */
 #define PL08X_BOUNDARY_SIZE		(1 << PL08X_BOUNDARY_SHIFT)
 
-/* Minimum period between work queue runs */
-#define PL08X_WQ_PERIODMIN	20
-
 /* Size (bytes) of each LLI buffer allocated for one transfer */
 # define PL08X_LLI_TSFR_SIZE	0x2000
 
 /* Maximum times we call dma_pool_alloc on this pool without freeing */
-#define PL08X_MAX_ALLOCS	0x40
 #define MAX_NUM_TSFR_LLIS	(PL08X_LLI_TSFR_SIZE/sizeof(struct pl08x_lli))
 #define PL08X_ALIGN		8
 
-- 
1.7.4.4
