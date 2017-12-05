From: amery@hanoverdisplays.com (Alejandro Mery)
Date: Tue, 5 Dec 2017 12:34:57 +0000
Subject: [PATCH v2 2/3] ARM: davinci: Add dma_mask to dm365's eDMA device
In-Reply-To: <20171205123458.97837-1-amery@hanoverdisplays.com>
References: <2298378f-37d0-0c04-dfe3-4503c58e5456@ti.com>,
 <20171204133359.45625-1-amery@hanoverdisplays.com>
 <20171205123458.97837-1-amery@hanoverdisplays.com>
Message-ID: <20171205123458.97837-3-amery@hanoverdisplays.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

as previously done by cef5b0da4019358cb03c9b0a964d4d63cd7deaf6 for other davinci SoCs

Signed-off-by: Alejandro Mery <amery@hanoverdisplays.com>
---
 arch/arm/mach-davinci/dm365.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-davinci/dm365.c b/arch/arm/mach-davinci/dm365.c
index 9bd17bc77b5c..103316f01a22 100644
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
