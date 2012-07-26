From: javier.martin@vista-silicon.com (Javier Martin)
Date: Thu, 26 Jul 2012 13:20:34 +0200
Subject: [PATCH 1/4] i.MX27: Fix emma-prp and csi clocks.
In-Reply-To: <1343301637-19676-1-git-send-email-javier.martin@vista-silicon.com>
References: <1343301637-19676-1-git-send-email-javier.martin@vista-silicon.com>
Message-ID: <1343301637-19676-2-git-send-email-javier.martin@vista-silicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Naming of emma-prp related clocks for the i.MX27 is not correct.

Signed-off-by: Javier Martin <javier.martin@vista-silicon.com>
---
 arch/arm/mach-imx/clk-imx27.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-imx/clk-imx27.c b/arch/arm/mach-imx/clk-imx27.c
index b1d343c..6e9cb02 100644
--- a/arch/arm/mach-imx/clk-imx27.c
+++ b/arch/arm/mach-imx/clk-imx27.c
@@ -223,7 +223,7 @@ int __init mx27_clocks_init(unsigned long fref)
 	clk_register_clkdev(clk[per3_gate], "per", "imx-fb.0");
 	clk_register_clkdev(clk[lcdc_ipg_gate], "ipg", "imx-fb.0");
 	clk_register_clkdev(clk[lcdc_ahb_gate], "ahb", "imx-fb.0");
-	clk_register_clkdev(clk[csi_ahb_gate], NULL, "mx2-camera.0");
+	clk_register_clkdev(clk[csi_ahb_gate], "ahb", "mx2-camera.0");
 	clk_register_clkdev(clk[usb_div], "per", "fsl-usb2-udc");
 	clk_register_clkdev(clk[usb_ipg_gate], "ipg", "fsl-usb2-udc");
 	clk_register_clkdev(clk[usb_ahb_gate], "ahb", "fsl-usb2-udc");
@@ -250,8 +250,10 @@ int __init mx27_clocks_init(unsigned long fref)
 	clk_register_clkdev(clk[i2c2_ipg_gate], NULL, "imx-i2c.1");
 	clk_register_clkdev(clk[owire_ipg_gate], NULL, "mxc_w1.0");
 	clk_register_clkdev(clk[kpp_ipg_gate], NULL, "imx-keypad");
-	clk_register_clkdev(clk[emma_ahb_gate], "ahb", "imx-emma");
-	clk_register_clkdev(clk[emma_ipg_gate], "ipg", "imx-emma");
+	clk_register_clkdev(clk[emma_ahb_gate], "emma-ahb", "mx2-camera.0");
+	clk_register_clkdev(clk[emma_ipg_gate], "emma-ipg", "mx2-camera.0");
+	clk_register_clkdev(clk[emma_ahb_gate], "ahb", "m2m-emmaprp.0");
+	clk_register_clkdev(clk[emma_ipg_gate], "ipg", "m2m-emmaprp.0");
 	clk_register_clkdev(clk[iim_ipg_gate], "iim", NULL);
 	clk_register_clkdev(clk[gpio_ipg_gate], "gpio", NULL);
 	clk_register_clkdev(clk[brom_ahb_gate], "brom", NULL);
-- 
1.7.9.5
