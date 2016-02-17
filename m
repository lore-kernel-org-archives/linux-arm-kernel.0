From: agust@denx.de (Anatolij Gustschin)
Date: Wed, 17 Feb 2016 19:48:19 +0100
Subject: [PATCH] clk: imx: correct pwm7 clock name in driver for i.MX6UL
Message-ID: <1455734900-1913-1-git-send-email-agust@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Don't capitalize p in the pwm7 clock name.

Signed-off-by: Anatolij Gustschin <agust@denx.de>
---
 drivers/clk/imx/clk-imx6ul.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-imx6ul.c b/drivers/clk/imx/clk-imx6ul.c
index 01718d0..15f2ac8 100644
--- a/drivers/clk/imx/clk-imx6ul.c
+++ b/drivers/clk/imx/clk-imx6ul.c
@@ -394,7 +394,7 @@ static void __init imx6ul_clocks_init(struct device_node *ccm_node)
 	clks[IMX6UL_CLK_I2C4]		= imx_clk_gate2("i2c4",		"perclk", 	 base + 0x80,	24);
 	clks[IMX6UL_CLK_PWM5]		= imx_clk_gate2("pwm5",		"perclk",	 base + 0x80,	26);
 	clks[IMX6UL_CLK_PWM6]		= imx_clk_gate2("pwm6",		"perclk",	 base +	0x80,	28);
-	clks[IMX6UL_CLK_PWM7]		= imx_clk_gate2("Pwm7",		"perclk",	 base + 0x80,	30);
+	clks[IMX6UL_CLK_PWM7]		= imx_clk_gate2("pwm7",		"perclk",	 base + 0x80,	30);
 
 	/* mask handshake of mmdc */
 	writel_relaxed(BM_CCM_CCDR_MMDC_CH0_MASK, base + CCDR);
-- 
1.7.9.5
