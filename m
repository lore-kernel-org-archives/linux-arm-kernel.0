From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 10 Oct 2012 10:01:59 +0200
Subject: [PATCH 3/3] ARM i.MX25: Fix PWM per clock lookups
In-Reply-To: <1349856119-22363-1-git-send-email-s.hauer@pengutronix.de>
References: <1349856119-22363-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1349856119-22363-4-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

They are behind the gate pwm_ipg_per, not directly behind per10.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-imx/clk-imx25.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-imx/clk-imx25.c b/arch/arm/mach-imx/clk-imx25.c
index 01e2f84..840fdfa 100644
--- a/arch/arm/mach-imx/clk-imx25.c
+++ b/arch/arm/mach-imx/clk-imx25.c
@@ -203,13 +203,13 @@ int __init mx25_clocks_init(void)
 	clk_register_clkdev(clk[cspi2_ipg], NULL, "imx35-cspi.1");
 	clk_register_clkdev(clk[cspi3_ipg], NULL, "imx35-cspi.2");
 	clk_register_clkdev(clk[pwm1_ipg], "ipg", "mxc_pwm.0");
-	clk_register_clkdev(clk[per10], "per", "mxc_pwm.0");
+	clk_register_clkdev(clk[pwm_ipg_per], "per", "mxc_pwm.0");
 	clk_register_clkdev(clk[pwm1_ipg], "ipg", "mxc_pwm.1");
-	clk_register_clkdev(clk[per10], "per", "mxc_pwm.1");
+	clk_register_clkdev(clk[pwm_ipg_per], "per", "mxc_pwm.1");
 	clk_register_clkdev(clk[pwm1_ipg], "ipg", "mxc_pwm.2");
-	clk_register_clkdev(clk[per10], "per", "mxc_pwm.2");
+	clk_register_clkdev(clk[pwm_ipg_per], "per", "mxc_pwm.2");
 	clk_register_clkdev(clk[pwm1_ipg], "ipg", "mxc_pwm.3");
-	clk_register_clkdev(clk[per10], "per", "mxc_pwm.3");
+	clk_register_clkdev(clk[pwm_ipg_per], "per", "mxc_pwm.3");
 	clk_register_clkdev(clk[kpp_ipg], NULL, "imx-keypad");
 	clk_register_clkdev(clk[tsc_ipg], NULL, "mx25-adc");
 	clk_register_clkdev(clk[i2c_ipg_per], NULL, "imx-i2c.0");
-- 
1.7.10.4
