From: richard.zhao@freescale.com (Richard Zhao)
Date: Wed, 9 May 2012 19:33:04 +0800
Subject: [PATCH V2 05/11] ARM: imx6q: add ssi1_ipg clk_lookup
In-Reply-To: <1336563190-19974-1-git-send-email-richard.zhao@freescale.com>
References: <1336563190-19974-1-git-send-email-richard.zhao@freescale.com>
Message-ID: <1336563190-19974-6-git-send-email-richard.zhao@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It's used by audio drivers.

Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
---
 arch/arm/mach-imx/clk-imx6q.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-imx/clk-imx6q.c b/arch/arm/mach-imx/clk-imx6q.c
index f40a35d..92550c5 100644
--- a/arch/arm/mach-imx/clk-imx6q.c
+++ b/arch/arm/mach-imx/clk-imx6q.c
@@ -155,7 +155,8 @@ enum mx6q_clks {
 	gpmi_bch_apb, gpmi_bch, gpmi_io, gpmi_apb, sata, sdma, spba, ssi1,
 	ssi2, ssi3, uart_ipg, uart_serial, usboh3, usdhc1, usdhc2, usdhc3,
 	usdhc4, vdo_axi, vpu_axi, cko1, pll1_sys, pll2_bus, pll3_usb_otg,
-	pll4_audio, pll5_video, pll6_mlb, pll7_usb_host, pll8_enet, clk_max
+	pll4_audio, pll5_video, pll6_mlb, pll7_usb_host, pll8_enet, ssi1_ipg,
+	ssi2_ipg, ssi3_ipg, clk_max
 };
 
 static struct clk *clk[clk_max];
@@ -367,9 +368,9 @@ int __init mx6q_clocks_init(void)
 	clk[sata]         = imx_clk_gate2("sata",          "ipg",               base + 0x7c, 4);
 	clk[sdma]         = imx_clk_gate2("sdma",          "ahb",               base + 0x7c, 6);
 	clk[spba]         = imx_clk_gate2("spba",          "ipg",               base + 0x7c, 12);
-	clk[ssi1]         = imx_clk_gate2("ssi1",          "ssi1_podf",         base + 0x7c, 18);
-	clk[ssi2]         = imx_clk_gate2("ssi2",          "ssi2_podf",         base + 0x7c, 20);
-	clk[ssi3]         = imx_clk_gate2("ssi3",          "ssi3_podf",         base + 0x7c, 22);
+	clk[ssi1_ipg]     = imx_clk_gate2("ssi1_ipg",      "ipg",               base + 0x7c, 18);
+	clk[ssi2_ipg]     = imx_clk_gate2("ssi2_ipg",      "ipg",               base + 0x7c, 20);
+	clk[ssi3_ipg]     = imx_clk_gate2("ssi3_ipg",      "ipg",               base + 0x7c, 22);
 	clk[uart_ipg]     = imx_clk_gate2("uart_ipg",      "ipg",               base + 0x7c, 24);
 	clk[uart_serial]  = imx_clk_gate2("uart_serial",   "uart_serial_podf",  base + 0x7c, 26);
 	clk[usboh3]       = imx_clk_gate2("usboh3",        "ipg",               base + 0x80, 0);
@@ -418,6 +419,7 @@ int __init mx6q_clocks_init(void)
 	clk_register_clkdev(clk[sdma], NULL, "20ec000.sdma");
 	clk_register_clkdev(clk[dummy], NULL, "20bc000.wdog");
 	clk_register_clkdev(clk[dummy], NULL, "20c0000.wdog");
+	clk_register_clkdev(clk[ssi1_ipg], NULL, "2028000.ssi");
 
 	for (i = 0; i < ARRAY_SIZE(clks_init_on); i++) {
 		c = clk_get_sys(clks_init_on[i], NULL);
-- 
1.7.5.4
