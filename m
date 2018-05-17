From: Anson.Huang@nxp.com (Anson Huang)
Date: Thu, 17 May 2018 13:00:47 +0800
Subject: [PATCH] clk: imx6sx: disable unnecessary clocks during clock
 initialization
Message-ID: <1526533248-21990-1-git-send-email-Anson.Huang@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Disable those unnecessary clocks during kernel boot up to save power,
those modules clock should be managed by modules driver in runtime.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/clk/imx/clk-imx6sx.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/clk/imx/clk-imx6sx.c b/drivers/clk/imx/clk-imx6sx.c
index 0178ee2..10c771b 100644
--- a/drivers/clk/imx/clk-imx6sx.c
+++ b/drivers/clk/imx/clk-imx6sx.c
@@ -97,12 +97,7 @@ static int const clks_init_on[] __initconst = {
 	IMX6SX_CLK_IPMUX1, IMX6SX_CLK_IPMUX2, IMX6SX_CLK_IPMUX3,
 	IMX6SX_CLK_WAKEUP, IMX6SX_CLK_MMDC_P0_FAST, IMX6SX_CLK_MMDC_P0_IPG,
 	IMX6SX_CLK_ROM, IMX6SX_CLK_ARM, IMX6SX_CLK_IPG, IMX6SX_CLK_OCRAM,
-	IMX6SX_CLK_PER2_MAIN, IMX6SX_CLK_PERCLK, IMX6SX_CLK_M4,
-	IMX6SX_CLK_QSPI1, IMX6SX_CLK_QSPI2, IMX6SX_CLK_UART_IPG,
-	IMX6SX_CLK_UART_SERIAL, IMX6SX_CLK_I2C3, IMX6SX_CLK_ECSPI5,
-	IMX6SX_CLK_CAN1_IPG, IMX6SX_CLK_CAN1_SERIAL, IMX6SX_CLK_CAN2_IPG,
-	IMX6SX_CLK_CAN2_SERIAL, IMX6SX_CLK_CANFD, IMX6SX_CLK_EPIT1,
-	IMX6SX_CLK_EPIT2,
+	IMX6SX_CLK_PER2_MAIN, IMX6SX_CLK_PERCLK, IMX6SX_CLK_TZASC1,
 };
 
 static const struct clk_div_table clk_enet_ref_table[] = {
-- 
2.7.4
