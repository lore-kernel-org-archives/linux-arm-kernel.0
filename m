From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 19 Jun 2012 20:26:32 -0300
Subject: [PATCH] clk: mxs: Register USB clocks for mx23
Message-ID: <1340148392-9847-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Register USB clocks for mx23.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/clk/mxs/clk-imx23.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/clk/mxs/clk-imx23.c b/drivers/clk/mxs/clk-imx23.c
index f7be225..4735136 100644
--- a/drivers/clk/mxs/clk-imx23.c
+++ b/drivers/clk/mxs/clk-imx23.c
@@ -195,6 +195,8 @@ int __init mx23_clocks_init(void)
 	clk_register_clkdevs(clks[ssp], ssp_lookups, ARRAY_SIZE(ssp_lookups));
 	clk_register_clkdevs(clks[gpmi], gpmi_lookups, ARRAY_SIZE(gpmi_lookups));
 	clk_register_clkdevs(clks[lcdif], lcdif_lookups, ARRAY_SIZE(lcdif_lookups));
+	clk_register_clkdev(clks[usb_pwr], NULL, "8007c000.usbphy");
+	clk_register_clkdev(clks[usb], NULL, "80080000.usb");
 
 	for (i = 0; i < ARRAY_SIZE(clks_init_on); i++)
 		clk_prepare_enable(clks[clks_init_on[i]]);
-- 
1.7.1
