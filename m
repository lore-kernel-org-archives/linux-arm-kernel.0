From: heiko@sntech.de (Heiko =?utf-8?q?St=C3=BCbner?=)
Date: Sun, 5 Aug 2012 17:39:48 +0200
Subject: [PATCH 2/2] ARM: S3C24XX: Fix s3c2410_dma_enqueue parameters
In-Reply-To: <201208051738.27728.heiko@sntech.de>
References: <201208051738.27728.heiko@sntech.de>
Message-ID: <201208051739.49023.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit d670ac019f60 (ARM: SAMSUNG: DMA Cleanup as per sparse) changed the
prototype of the s3c2410_dma_* functions to use the enum dma_ch instead
of an generic unsigned int.

In the s3c24xx dma.c s3c2410_dma_enqueue seems to have been forgotten,
the other functions there were changed correctly.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/plat-s3c24xx/dma.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-s3c24xx/dma.c b/arch/arm/plat-s3c24xx/dma.c
index 28f898f..db98e70 100644
--- a/arch/arm/plat-s3c24xx/dma.c
+++ b/arch/arm/plat-s3c24xx/dma.c
@@ -430,7 +430,7 @@ s3c2410_dma_canload(struct s3c2410_dma_chan *chan)
  * when necessary.
 */
 
-int s3c2410_dma_enqueue(unsigned int channel, void *id,
+int s3c2410_dma_enqueue(enum dma_ch channel, void *id,
 			dma_addr_t data, int size)
 {
 	struct s3c2410_dma_chan *chan = s3c_dma_lookup_channel(channel);
-- 
1.7.2.3
