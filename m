From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  9 Oct 2013 15:50:49 +0900
Subject: [PATCH 01/14] ARM: shmobile: ape6evm: add DMA support to MMCIF
In-Reply-To: <cover.1381299817.git.horms+renesas@verge.net.au>
References: <cover.1381299817.git.horms+renesas@verge.net.au>
Message-ID: <7a2a7a371145e83ad60482313e8cd7501994df3a.1381299817.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Add DMA support for MMCIF on APE6EVM, using the shdma dmaengine driver.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-ape6evm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-shmobile/board-ape6evm.c b/arch/arm/mach-shmobile/board-ape6evm.c
index 7627385..2de4b09 100644
--- a/arch/arm/mach-shmobile/board-ape6evm.c
+++ b/arch/arm/mach-shmobile/board-ape6evm.c
@@ -162,6 +162,8 @@ static struct regulator_consumer_supply vcc_sdhi1_consumers[] =
 /* MMCIF */
 static const struct sh_mmcif_plat_data mmcif0_pdata __initconst = {
 	.caps		= MMC_CAP_8_BIT_DATA | MMC_CAP_NONREMOVABLE,
+	.slave_id_tx	= SHDMA_SLAVE_MMCIF0_TX,
+	.slave_id_rx	= SHDMA_SLAVE_MMCIF0_RX,
 	.ccs_unsupported = true,
 };
 
-- 
1.8.4
