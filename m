From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Tue, 19 Aug 2014 15:21:12 -0300
Subject: [PATCH 2/4] ARM: clk-imx6sl: Select appropriate parents for LCDIF
 clocks
In-Reply-To: <1408472474-4914-1-git-send-email-fabio.estevam@freescale.com>
References: <1408472474-4914-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <1408472474-4914-2-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PLL5 is well suited for being the parent of IMX6SL_CLK_LCDIF_PIX_SEL and
PLL2_PFD for IMX6SL_CLK_LCDIF_AXI_SEL.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-imx/clk-imx6sl.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/mach-imx/clk-imx6sl.c b/arch/arm/mach-imx/clk-imx6sl.c
index ba3af22..11908e8 100644
--- a/arch/arm/mach-imx/clk-imx6sl.c
+++ b/arch/arm/mach-imx/clk-imx6sl.c
@@ -376,6 +376,13 @@ static void __init imx6sl_clocks_init(struct device_node *ccm_node)
 	/* Audio-related clocks configuration */
 	clk_set_parent(clks[IMX6SL_CLK_SPDIF0_SEL], clks[IMX6SL_CLK_PLL3_PFD3]);
 
+	/* set PLL5 video as lcdif pix parent clock */
+	clk_set_parent(clks[IMX6SL_CLK_LCDIF_PIX_SEL],
+			clks[IMX6SL_CLK_PLL5_VIDEO_DIV]);
+
+	clk_set_parent(clks[IMX6SL_CLK_LCDIF_AXI_SEL],
+		       clks[IMX6SL_CLK_PLL2_PFD2]);
+
 	/* Set initial power mode */
 	imx6q_set_lpm(WAIT_CLOCKED);
 }
-- 
1.9.1
