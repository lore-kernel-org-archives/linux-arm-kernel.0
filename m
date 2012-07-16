From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Mon, 16 Jul 2012 09:53:25 +0200
Subject: [PATCH] ARM i.MX53: clk: change cspi_ipg_gate device name
Message-ID: <1342425205-24567-1-git-send-email-s.trumtrar@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The cspi is compatible to the imx35 one. imx51-dt.c, imx53-dt.c, imx53.dtsi and
imx51.dtsi already reflect this fact. But as the clock driver is not registered
accordingly, spi-imx can not probe for the device, as it can not find the clock
device and return with an error.
A rename of the clock device fixes this.

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
 arch/arm/mach-imx/clk-imx51-imx53.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/clk-imx51-imx53.c b/arch/arm/mach-imx/clk-imx51-imx53.c
index a2200c7..508f104 100644
--- a/arch/arm/mach-imx/clk-imx51-imx53.c
+++ b/arch/arm/mach-imx/clk-imx51-imx53.c
@@ -248,7 +248,7 @@ static void __init mx5_clocks_common_init(unsigned long rate_ckil,
 	clk_register_clkdev(clk[ecspi1_ipg_gate], "ipg", "imx51-ecspi.0");
 	clk_register_clkdev(clk[ecspi2_per_gate], "per", "imx51-ecspi.1");
 	clk_register_clkdev(clk[ecspi2_ipg_gate], "ipg", "imx51-ecspi.1");
-	clk_register_clkdev(clk[cspi_ipg_gate], NULL, "imx51-cspi.0");
+	clk_register_clkdev(clk[cspi_ipg_gate], NULL, "imx35-cspi.0");
 	clk_register_clkdev(clk[pwm1_ipg_gate], "pwm", "mxc_pwm.0");
 	clk_register_clkdev(clk[pwm2_ipg_gate], "pwm", "mxc_pwm.1");
 	clk_register_clkdev(clk[i2c1_gate], NULL, "imx-i2c.0");
