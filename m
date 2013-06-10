From: will.deacon@arm.com (Will Deacon)
Date: Mon, 10 Jun 2013 19:34:38 +0100
Subject: [PATCH 2/9] dma: pl330: use dma_addr_t for describing bus addresses
In-Reply-To: <1370889285-22799-1-git-send-email-will.deacon@arm.com>
References: <1370889285-22799-1-git-send-email-will.deacon@arm.com>
Message-ID: <1370889285-22799-3-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The microcode bus address (pl330_dmac.mcode_bus) is currently a u32,
which fails to compile when building on a system with 64-bit bus
addresses.

This patch uses dma_addr_t to represent the address instead.

Cc: Jassi Brar <jaswinder.singh@linaro.org>
Cc: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 drivers/dma/pl330.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index 22e2a8f..f1bc593 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -501,7 +501,7 @@ struct pl330_dmac {
 	/* Maximum possible events/irqs */
 	int			events[32];
 	/* BUS address of MicroCode buffer */
-	u32			mcode_bus;
+	dma_addr_t		mcode_bus;
 	/* CPU address of MicroCode buffer */
 	void			*mcode_cpu;
 	/* List of all Channel threads */
-- 
1.8.2.2
