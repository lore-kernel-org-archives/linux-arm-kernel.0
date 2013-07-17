From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 18 Jul 2013 08:32:02 +0900
Subject: [PATCH 01/22] ARM: shmobile: armadillo800eva: remove left-overs
In-Reply-To: <cover.1374103272.git.horms+renesas@verge.net.au>
References: <cover.1374103272.git.horms+renesas@verge.net.au>
Message-ID: <bcfed2a8a61a0f6ee7769f5093a8279a9e50c526.1374103272.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

A comment and a #define in board-armadillo800eva.c have been left over
after recent changes and are no longer relevant or needed, remove them.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-armadillo800eva.c |    9 ---------
 1 file changed, 9 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-armadillo800eva.c b/arch/arm/mach-shmobile/board-armadillo800eva.c
index e115f67..66cfd56 100644
--- a/arch/arm/mach-shmobile/board-armadillo800eva.c
+++ b/arch/arm/mach-shmobile/board-armadillo800eva.c
@@ -679,15 +679,6 @@ static struct platform_device vcc_sdhi1 = {
 };
 
 /* SDHI0 */
-/*
- * FIXME
- *
- * It use polling mode here, since
- * CD (= Card Detect) pin is not connected to SDHI0_CD.
- * We can use IRQ31 as card detect irq,
- * but it needs chattering removal operation
- */
-#define IRQ31	irq_pin(31)
 static struct sh_mobile_sdhi_info sdhi0_info = {
 	.dma_slave_tx	= SHDMA_SLAVE_SDHI0_TX,
 	.dma_slave_rx	= SHDMA_SLAVE_SDHI0_RX,
-- 
1.7.10.4
