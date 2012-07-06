From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Fri, 6 Jul 2012 17:20:20 -0300
Subject: [PATCH 2/2] ARM: imx: clk-imx31: Fix clock id for rnga driver
In-Reply-To: <1341606020-26449-1-git-send-email-fabio.estevam@freescale.com>
References: <1341606020-26449-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <1341606020-26449-2-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix clock id for rnga driver.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-imx/clk-imx31.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-imx/clk-imx31.c b/arch/arm/mach-imx/clk-imx31.c
index c9a06d8..8a7ef99 100644
--- a/arch/arm/mach-imx/clk-imx31.c
+++ b/arch/arm/mach-imx/clk-imx31.c
@@ -165,7 +165,7 @@ int __init mx31_clocks_init(unsigned long fref)
 	clk_register_clkdev(clk[firi_gate], "firi", NULL);
 	clk_register_clkdev(clk[ata_gate], NULL, "pata_imx");
 	clk_register_clkdev(clk[rtic_gate], "rtic", NULL);
-	clk_register_clkdev(clk[rng_gate], "rng", NULL);
+	clk_register_clkdev(clk[rng_gate], NULL, "mxc_rnga");
 	clk_register_clkdev(clk[sdma_gate], NULL, "imx31-sdma");
 	clk_register_clkdev(clk[iim_gate], "iim", NULL);
 
-- 
1.7.1
