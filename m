From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri,  5 Nov 2010 10:46:09 +0100
Subject: [PATCH 5/7] ARM i.MX DMA: return gracefully on different socs
In-Reply-To: <1288950371-1552-1-git-send-email-s.hauer@pengutronix.de>
References: <1288950371-1552-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1288950371-1552-6-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Code called from an initcall can be maybe called for
machines it's not intended for. So check for valid
machines and return gracefully if an incompatible machine
is found.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-imx/dma-v1.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-imx/dma-v1.c b/arch/arm/mach-imx/dma-v1.c
index 3e8c47c..dcb24a9 100644
--- a/arch/arm/mach-imx/dma-v1.c
+++ b/arch/arm/mach-imx/dma-v1.c
@@ -818,7 +818,7 @@ static int __init imx_dma_init(void)
 		imx_dmav1_baseaddr = MX27_IO_ADDRESS(MX27_DMA_BASE_ADDR);
 	else
 #endif
-		BUG();
+		return 0;
 
 	dma_clk = clk_get(NULL, "dma");
 	clk_enable(dma_clk);
-- 
1.7.2.3
