From: b32955@freescale.com (Huang Shijie)
Date: Thu, 24 May 2012 18:50:59 +0800
Subject: [PATCH 5/5] ARM: imx6q: add clocks for gpmi-nand
In-Reply-To: <1337856659-24812-1-git-send-email-b32955@freescale.com>
References: <1337856659-24812-1-git-send-email-b32955@freescale.com>
Message-ID: <1337856659-24812-5-git-send-email-b32955@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

add the clocks for gpmi-nand.

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 arch/arm/mach-imx/clk-imx6q.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-imx/clk-imx6q.c b/arch/arm/mach-imx/clk-imx6q.c
index 12d9040..2b5ab5f 100644
--- a/arch/arm/mach-imx/clk-imx6q.c
+++ b/arch/arm/mach-imx/clk-imx6q.c
@@ -151,7 +151,7 @@ enum mx6q_clks {
 	esai, gpt_ipg, gpt_ipg_per, gpu2d_core, gpu3d_core, hdmi_iahb,
 	hdmi_isfr, i2c1, i2c2, i2c3, iim, enfc, ipu1, ipu1_di0, ipu1_di1, ipu2,
 	ipu2_di0, ldb_di0, ldb_di1, ipu2_di1, hsi_tx, mlb, mmdc_ch0_axi,
-	mmdc_ch1_axi, ocram, openvg_axi, pcie_axi, pwm1, pwm2, pwm3, pwm4,
+	mmdc_ch1_axi, ocram, openvg_axi, pcie_axi, pwm1, pwm2, pwm3, pwm4, per1_bch,
 	gpmi_bch_apb, gpmi_bch, gpmi_io, gpmi_apb, sata, sdma, spba, ssi1,
 	ssi2, ssi3, uart_ipg, uart_serial, usboh3, usdhc1, usdhc2, usdhc3,
 	usdhc4, vdo_axi, vpu_axi, cko1, pll1_sys, pll2_bus, pll3_usb_otg,
@@ -357,6 +357,7 @@ int __init mx6q_clocks_init(void)
 	clk[ocram]        = imx_clk_gate2("ocram",         "ahb",               base + 0x74, 28);
 	clk[openvg_axi]   = imx_clk_gate2("openvg_axi",    "axi",               base + 0x74, 30);
 	clk[pcie_axi]     = imx_clk_gate2("pcie_axi",      "pcie_axi_sel",      base + 0x78, 0);
+	clk[per1_bch]     = imx_clk_gate2("per1_bch",      "usdhc3",            base + 0x78, 12);
 	clk[pwm1]         = imx_clk_gate2("pwm1",          "ipg_per",           base + 0x78, 16);
 	clk[pwm2]         = imx_clk_gate2("pwm2",          "ipg_per",           base + 0x78, 18);
 	clk[pwm3]         = imx_clk_gate2("pwm3",          "ipg_per",           base + 0x78, 20);
@@ -394,6 +395,7 @@ int __init mx6q_clocks_init(void)
 	clk_register_clkdev(clk[twd], NULL, "smp_twd");
 	clk_register_clkdev(clk[usboh3], NULL, "usboh3");
 	clk_register_clkdev(clk[apbh_dma], NULL, "110000.dma-apbh");
+	clk_register_clkdev(clk[gpmi_io], NULL, "112000.gpmi-nand");
 	clk_register_clkdev(clk[uart_serial], "per", "2020000.serial");
 	clk_register_clkdev(clk[uart_ipg], "ipg", "2020000.serial");
 	clk_register_clkdev(clk[uart_serial], "per", "21e8000.serial");
-- 
1.7.0.4
