From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Thu, 26 Jul 2012 16:08:53 -0300
Subject: [PATCH] ARM: clk-imx31: Fix the keypad clock name
Message-ID: <1343329733-14720-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the keypad clock name, in order to fix the following error:

imx-keypad imx-keypad: failed to get keypad clock
imx-keypad: probe of imx-keypad failed with error -2

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-imx/clk-imx31.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-imx/clk-imx31.c b/arch/arm/mach-imx/clk-imx31.c
index 8e19e70..1253af2 100644
--- a/arch/arm/mach-imx/clk-imx31.c
+++ b/arch/arm/mach-imx/clk-imx31.c
@@ -130,7 +130,7 @@ int __init mx31_clocks_init(unsigned long fref)
 	clk_register_clkdev(clk[nfc], NULL, "mxc_nand.0");
 	clk_register_clkdev(clk[ipu_gate], NULL, "ipu-core");
 	clk_register_clkdev(clk[ipu_gate], NULL, "mx3_sdc_fb");
-	clk_register_clkdev(clk[kpp_gate], "kpp", NULL);
+	clk_register_clkdev(clk[kpp_gate], NULL, "imx-keypad");
 	clk_register_clkdev(clk[usb_div_post], "per", "mxc-ehci.0");
 	clk_register_clkdev(clk[usb_gate], "ahb", "mxc-ehci.0");
 	clk_register_clkdev(clk[ipg], "ipg", "mxc-ehci.0");
-- 
1.7.1
