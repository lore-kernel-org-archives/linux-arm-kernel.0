From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Fri, 26 Apr 2013 18:27:42 +0200
Subject: [PATCH 1/6] ARM: shmobile: armadillo800eva: remove left-overs
In-Reply-To: <1366993667-23294-1-git-send-email-g.liakhovetski@gmx.de>
References: <1366993667-23294-1-git-send-email-g.liakhovetski@gmx.de>
Message-ID: <1366993667-23294-2-git-send-email-g.liakhovetski@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A comment and a #define in board-armadillo800eva.c have been left over
after recent changes and are no longer relevant or needed, remove them.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
---
 arch/arm/mach-shmobile/board-armadillo800eva.c |    9 ---------
 1 files changed, 0 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-armadillo800eva.c b/arch/arm/mach-shmobile/board-armadillo800eva.c
index ff04d1e..acfc267 100644
--- a/arch/arm/mach-shmobile/board-armadillo800eva.c
+++ b/arch/arm/mach-shmobile/board-armadillo800eva.c
@@ -673,15 +673,6 @@ static struct platform_device vcc_sdhi1 = {
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
1.7.2.5
