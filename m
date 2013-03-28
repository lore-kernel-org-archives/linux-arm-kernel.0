From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 28 Mar 2013 11:22:25 +0000
Subject: [PATCH 1/2] ARM: S3C64XX: Clear DMA flags on channel request
Message-ID: <1364469746-5026-1-git-send-email-broonie@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

This patch clears the DMA flags when a DMA channel is requested. This is
necessary because otherwise the channel may inherit incompatible
settings from its last usage.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 arch/arm/mach-s3c64xx/dma.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-s3c64xx/dma.c b/arch/arm/mach-s3c64xx/dma.c
index 6af1aa1..759846c 100644
--- a/arch/arm/mach-s3c64xx/dma.c
+++ b/arch/arm/mach-s3c64xx/dma.c
@@ -509,6 +509,7 @@ int s3c2410_dma_request(enum dma_ch channel,
 	chan->client = client;
 	chan->in_use = 1;
 	chan->peripheral = channel;
+	chan->flags = 0;
 
 	local_irq_restore(flags);
 
-- 
1.7.10.4
