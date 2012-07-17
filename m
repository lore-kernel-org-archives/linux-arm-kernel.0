From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Tue, 17 Jul 2012 12:53:53 +0200 (CEST)
Subject: [PATCH/RFC 3/4] ARM: shmobile: extend MMCIF DMA client configuration
 entries
In-Reply-To: <Pine.LNX.4.64.1207171201550.11241@axis700.grange>
References: <Pine.LNX.4.64.1207171201550.11241@axis700.grange>
Message-ID: <Pine.LNX.4.64.1207171248150.17060@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To prepare for MMCIF driver transition to the dma_request_slave_channel()
API the MMCIF DMA client configuration entries in the slave configuration
table have to be extended with device ID and DMA transfer direction fields.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

This is just an example. Eventually all DMA client configurations on all 
affected platforms should be converted.

 arch/arm/mach-shmobile/setup-sh7372.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/setup-sh7372.c b/arch/arm/mach-shmobile/setup-sh7372.c
index 7873159..f583e03 100644
--- a/arch/arm/mach-shmobile/setup-sh7372.c
+++ b/arch/arm/mach-shmobile/setup-sh7372.c
@@ -452,11 +452,15 @@ static const struct sh_dmae_slave_config sh7372_dmae_slaves[] = {
 		.addr		= 0xe6bd0034,
 		.chcr		= CHCR_TX(XMIT_SZ_32BIT),
 		.mid_rid	= 0xd1,
+		.dev_id		= "sh_mmcif.0",
+		.direction	= DMA_MEM_TO_DEV,
 	}, {
 		.slave_id	= SHDMA_SLAVE_MMCIF_RX,
 		.addr		= 0xe6bd0034,
 		.chcr		= CHCR_RX(XMIT_SZ_32BIT),
 		.mid_rid	= 0xd2,
+		.dev_id		= "sh_mmcif.0",
+		.direction	= DMA_DEV_TO_MEM,
 	},
 };
 
-- 
1.7.2.5
