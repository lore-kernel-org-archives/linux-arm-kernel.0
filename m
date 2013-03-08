From: ckeepax@opensource.wolfsonmicro.com (Charles Keepax)
Date: Fri,  8 Mar 2013 15:53:04 +0000
Subject: [PATCH] ARM: S3C64XX: Clear DMA flags on channel request
Message-ID: <1362757984-19249-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch clears the DMA flags when a DMA channel is requested. This is
necessary because otherwise the channel may inherit incompatible
settings from its last usage.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 arch/arm/mach-s3c64xx/dma.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

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
1.7.2.5
