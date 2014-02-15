From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sat, 15 Feb 2014 04:26:52 +0300
Subject: [PATCH 1/5] ARM: shmobile: Armadillo 800 EVA: set proper DMA masks
 for Ether device
In-Reply-To: <201402150424.30954.sergei.shtylyov@cogentembedded.com>
References: <201402150424.30954.sergei.shtylyov@cogentembedded.com>
Message-ID: <201402150426.52493.sergei.shtylyov@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ether MAC is a DMA-capable device and so should have 'dev.dma_mask' and
'dev.coherent_dma_mask' fields set properly, to reflect 32-bit DMA addressing
ability.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 arch/arm/mach-shmobile/board-armadillo800eva.c |    2 ++
 1 file changed, 2 insertions(+)

Index: renesas/arch/arm/mach-shmobile/board-armadillo800eva.c
===================================================================
--- renesas.orig/arch/arm/mach-shmobile/board-armadillo800eva.c
+++ renesas/arch/arm/mach-shmobile/board-armadillo800eva.c
@@ -383,6 +383,8 @@ static struct platform_device sh_eth_dev
 	.id = -1,
 	.dev = {
 		.platform_data = &sh_eth_platdata,
+		.dma_mask = &sh_eth_device.dev.coherent_dma_mask,
+		.coherent_dma_mask = DMA_BIT_MASK(32),
 	},
 	.resource = sh_eth_resources,
 	.num_resources = ARRAY_SIZE(sh_eth_resources),
