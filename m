From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Thu, 22 Nov 2012 17:10:45 -0200
Subject: [PATCH 3/4] ARM: clk-imx31: Add dummy clock
In-Reply-To: <1353611447-7732-1-git-send-email-fabio.estevam@freescale.com>
References: <1353611447-7732-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <1353611447-7732-3-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add dummy clock as it is required by some i.mx drivers.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-imx/clk-imx31.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-imx/clk-imx31.c b/arch/arm/mach-imx/clk-imx31.c
index 8be64e0..07af70d 100644
--- a/arch/arm/mach-imx/clk-imx31.c
+++ b/arch/arm/mach-imx/clk-imx31.c
@@ -34,8 +34,8 @@ static const char *csi_sel[] = { "upll", "spll", };
 static const char *fir_sel[] = { "mcu_main", "upll", "spll" };
 
 enum mx31_clks {
-	ckih, ckil, mpll, spll, upll, mcu_main, hsp, ahb, nfc, ipg, per_div,
-	per, csi, fir, csi_div, usb_div_pre, usb_div_post, fir_div_pre,
+	dummy, ckih, ckil, mpll, spll, upll, mcu_main, hsp, ahb, nfc, ipg,
+	per_div, per, csi, fir, csi_div, usb_div_pre, usb_div_post, fir_div_pre,
 	fir_div_post, sdhc1_gate, sdhc2_gate, gpt_gate, epit1_gate, epit2_gate,
 	iim_gate, ata_gate, sdma_gate, cspi3_gate, rng_gate, uart1_gate,
 	uart2_gate, ssi1_gate, i2c1_gate, i2c2_gate, i2c3_gate, hantro_gate,
@@ -52,6 +52,7 @@ int __init mx31_clocks_init(unsigned long fref)
 	void __iomem *base = MX31_IO_ADDRESS(MX31_CCM_BASE_ADDR);
 	int i;
 
+	clk[dummy] = imx_clk_fixed("dummy", 0);
 	clk[ckih] = imx_clk_fixed("ckih", fref);
 	clk[ckil] = imx_clk_fixed("ckil", 32768);
 	clk[mpll] = imx_clk_pllv1("mpll", "ckih", base + MXC_CCM_MPCTL);
-- 
1.7.9.5
