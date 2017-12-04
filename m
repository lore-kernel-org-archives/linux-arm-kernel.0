From: amery@hanoverdisplays.com (Alejandro Mery)
Date: Mon, 4 Dec 2017 13:33:59 +0000
Subject: [PATCH 2/2] ARM: davinci: Add dma_mask to dm365's eDMA device
In-Reply-To: <20171204133359.45625-1-amery@hanoverdisplays.com>
References: <20171204133359.45625-1-amery@hanoverdisplays.com>
Message-ID: <20171204133359.45625-3-amery@hanoverdisplays.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

as previously done by cef5b0da4019358cb03c9b0a964d4d63cd7deaf6 for other davinci SoCs

Signed-off-by: Alejandro Mery <amery@hanoverdisplays.com>
---
 arch/arm/mach-davinci/dm365.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-davinci/dm365.c b/arch/arm/mach-davinci/dm365.c
index 855e0a57b219..90858bc9dd18 100644
--- a/arch/arm/mach-davinci/dm365.c
+++ b/arch/arm/mach-davinci/dm365.c
@@ -928,6 +928,7 @@ static struct resource edma_resources[] = {
 static const struct platform_device_info dm365_edma_device __initconst = {
 	.name		= "edma",
 	.id		= 0,
+	.dma_mask	= DMA_BIT_MASK(32),
 	.res		= edma_resources,
 	.num_res	= ARRAY_SIZE(edma_resources),
 	.data		= &dm365_edma_pdata,
-- 
2.15.0
