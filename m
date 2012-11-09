From: horms@verge.net.au (Simon Horman)
Date: Fri,  9 Nov 2012 16:31:43 +0900
Subject: [PATCH 4/7] ARM: shmobile: mackerel: enable DMAEngine on USB Host
In-Reply-To: <1352446306-19945-1-git-send-email-horms@verge.net.au>
References: <1352446306-19945-1-git-send-email-horms@verge.net.au>
Message-ID: <1352446306-19945-5-git-send-email-horms@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms@verge.net.au>
---
 arch/arm/mach-shmobile/board-mackerel.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-shmobile/board-mackerel.c b/arch/arm/mach-shmobile/board-mackerel.c
index f274252..d5fe365 100644
--- a/arch/arm/mach-shmobile/board-mackerel.c
+++ b/arch/arm/mach-shmobile/board-mackerel.c
@@ -816,6 +816,8 @@ static struct platform_device usbhs1_device = {
 	.id	= 1,
 	.dev = {
 		.platform_data		= &usbhs1_private.info,
+		.dma_mask		= &usbhs1_device.dev.coherent_dma_mask,
+		.coherent_dma_mask	= DMA_BIT_MASK(32),
 	},
 	.num_resources	= ARRAY_SIZE(usbhs1_resources),
 	.resource	= usbhs1_resources,
-- 
1.7.10.4
