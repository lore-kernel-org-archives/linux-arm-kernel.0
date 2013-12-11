From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Wed, 11 Dec 2013 16:13:32 +0800
Subject: [PATCH 02/02] clk: hi3620: add gate clock flag
In-Reply-To: <1386749612-12437-1-git-send-email-haojian.zhuang@gmail.com>
References: <1386749612-12437-1-git-send-email-haojian.zhuang@gmail.com>
Message-ID: <1386749612-12437-2-git-send-email-haojian.zhuang@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add missing CLK_SET_RATE_PARENT flag for gate clock.

Signed-off-by: Haojian Zhuang <haojian.zhuang@gmail.com>
---
 drivers/clk/hisilicon/clk-hi3620.c | 118 ++++++++++++++++++-------------------
 1 file changed, 59 insertions(+), 59 deletions(-)

diff --git a/drivers/clk/hisilicon/clk-hi3620.c b/drivers/clk/hisilicon/clk-hi3620.c
index f0e779f..f24ad6a 100644
--- a/drivers/clk/hisilicon/clk-hi3620.c
+++ b/drivers/clk/hisilicon/clk-hi3620.c
@@ -147,65 +147,65 @@ static struct hisi_divider_clock hi3620_div_clks[] __initdata = {
 };
 
 static struct hisi_gate_clock hi3620_seperated_gate_clks[] __initdata = {
-	{ HI3620_TIMERCLK01,   "timerclk01",   "timer_rclk01", 0, 0x20, 0, 0, },
-	{ HI3620_TIMER_RCLK01, "timer_rclk01", "rclk_tcxo",    0, 0x20, 1, 0, },
-	{ HI3620_TIMERCLK23,   "timerclk23",   "timer_rclk23", 0, 0x20, 2, 0, },
-	{ HI3620_TIMER_RCLK23, "timer_rclk23", "rclk_tcxo",    0, 0x20, 3, 0, },
-	{ HI3620_RTCCLK,       "rtcclk",       "pclk",         0, 0x20, 5, 0, },
-	{ HI3620_KPC_CLK,      "kpc_clk",      "pclk",         0, 0x20, 6, 0, },
-	{ HI3620_GPIOCLK0,     "gpioclk0",     "pclk",         0, 0x20, 8, 0, },
-	{ HI3620_GPIOCLK1,     "gpioclk1",     "pclk",         0, 0x20, 9, 0, },
-	{ HI3620_GPIOCLK2,     "gpioclk2",     "pclk",         0, 0x20, 10, 0, },
-	{ HI3620_GPIOCLK3,     "gpioclk3",     "pclk",         0, 0x20, 11, 0, },
-	{ HI3620_GPIOCLK4,     "gpioclk4",     "pclk",         0, 0x20, 12, 0, },
-	{ HI3620_GPIOCLK5,     "gpioclk5",     "pclk",         0, 0x20, 13, 0, },
-	{ HI3620_GPIOCLK6,     "gpioclk6",     "pclk",         0, 0x20, 14, 0, },
-	{ HI3620_GPIOCLK7,     "gpioclk7",     "pclk",         0, 0x20, 15, 0, },
-	{ HI3620_GPIOCLK8,     "gpioclk8",     "pclk",         0, 0x20, 16, 0, },
-	{ HI3620_GPIOCLK9,     "gpioclk9",     "pclk",         0, 0x20, 17, 0, },
-	{ HI3620_GPIOCLK10,    "gpioclk10",    "pclk",         0, 0x20, 18, 0, },
-	{ HI3620_GPIOCLK11,    "gpioclk11",    "pclk",         0, 0x20, 19, 0, },
-	{ HI3620_GPIOCLK12,    "gpioclk12",    "pclk",         0, 0x20, 20, 0, },
-	{ HI3620_GPIOCLK13,    "gpioclk13",    "pclk",         0, 0x20, 21, 0, },
-	{ HI3620_GPIOCLK14,    "gpioclk14",    "pclk",         0, 0x20, 22, 0, },
-	{ HI3620_GPIOCLK15,    "gpioclk15",    "pclk",         0, 0x20, 23, 0, },
-	{ HI3620_GPIOCLK16,    "gpioclk16",    "pclk",         0, 0x20, 24, 0, },
-	{ HI3620_GPIOCLK17,    "gpioclk17",    "pclk",         0, 0x20, 25, 0, },
-	{ HI3620_GPIOCLK18,    "gpioclk18",    "pclk",         0, 0x20, 26, 0, },
-	{ HI3620_GPIOCLK19,    "gpioclk19",    "pclk",         0, 0x20, 27, 0, },
-	{ HI3620_GPIOCLK20,    "gpioclk20",    "pclk",         0, 0x20, 28, 0, },
-	{ HI3620_GPIOCLK21,    "gpioclk21",    "pclk",         0, 0x20, 29, 0, },
-	{ HI3620_DPHY0_CLK,    "dphy0_clk",    "osc26m",       0, 0x30, 15, 0, },
-	{ HI3620_DPHY1_CLK,    "dphy1_clk",    "osc26m",       0, 0x30, 16, 0, },
-	{ HI3620_DPHY2_CLK,    "dphy2_clk",    "osc26m",       0, 0x30, 17, 0, },
-	{ HI3620_USBPHY_CLK,   "usbphy_clk",   "rclk_pico",    0, 0x30, 24, 0, },
-	{ HI3620_ACP_CLK,      "acp_clk",      "rclk_cfgaxi",  0, 0x30, 28, 0, },
-	{ HI3620_TIMERCLK45,   "timerclk45",   "rclk_tcxo",    0, 0x40, 3, 0, },
-	{ HI3620_TIMERCLK67,   "timerclk67",   "rclk_tcxo",    0, 0x40, 4, 0, },
-	{ HI3620_TIMERCLK89,   "timerclk89",   "rclk_tcxo",    0, 0x40, 5, 0, },
-	{ HI3620_PWMCLK0,      "pwmclk0",      "pwm0_mux",     0, 0x40, 7, 0, },
-	{ HI3620_PWMCLK1,      "pwmclk1",      "pwm1_mux",     0, 0x40, 8, 0, },
-	{ HI3620_UARTCLK0,     "uartclk0",     "uart0_mux",    0, 0x40, 16, 0, },
-	{ HI3620_UARTCLK1,     "uartclk1",     "uart1_mux",    0, 0x40, 17, 0, },
-	{ HI3620_UARTCLK2,     "uartclk2",     "uart2_mux",    0, 0x40, 18, 0, },
-	{ HI3620_UARTCLK3,     "uartclk3",     "uart3_mux",    0, 0x40, 19, 0, },
-	{ HI3620_UARTCLK4,     "uartclk4",     "uart4_mux",    0, 0x40, 20, 0, },
-	{ HI3620_SPICLK0,      "spiclk0",      "spi0_mux",     0, 0x40, 21, 0, },
-	{ HI3620_SPICLK1,      "spiclk1",      "spi1_mux",     0, 0x40, 22, 0, },
-	{ HI3620_SPICLK2,      "spiclk2",      "spi2_mux",     0, 0x40, 23, 0, },
-	{ HI3620_I2CCLK0,      "i2cclk0",      "pclk",         0, 0x40, 24, 0, },
-	{ HI3620_I2CCLK1,      "i2cclk1",      "pclk",         0, 0x40, 25, 0, },
-	{ HI3620_SCI_CLK,      "sci_clk",      "osc26m",       0, 0x40, 26, 0, },
-	{ HI3620_I2CCLK2,      "i2cclk2",      "pclk",         0, 0x40, 28, 0, },
-	{ HI3620_I2CCLK3,      "i2cclk3",      "pclk",         0, 0x40, 29, 0, },
-	{ HI3620_DDRC_PER_CLK, "ddrc_per_clk", "rclk_cfgaxi",  0, 0x50, 9, 0, },
-	{ HI3620_DMAC_CLK,     "dmac_clk",     "rclk_cfgaxi",  0, 0x50, 10, 0, },
-	{ HI3620_USB2DVC_CLK,  "usb2dvc_clk",  "rclk_cfgaxi",  0, 0x50, 17, 0, },
-	{ HI3620_SD_CLK,       "sd_clk",       "sd_div",       0, 0x50, 20, 0, },
-	{ HI3620_MMC_CLK1,     "mmc_clk1",     "mmc1_mux2",    0, 0x50, 21, 0, },
-	{ HI3620_MMC_CLK2,     "mmc_clk2",     "mmc2_div",     0, 0x50, 22, 0, },
-	{ HI3620_MMC_CLK3,     "mmc_clk3",     "mmc3_div",     0, 0x50, 23, 0, },
-	{ HI3620_MCU_CLK,      "mcu_clk",      "acp_clk",      0, 0x50, 24, 0, },
+	{ HI3620_TIMERCLK01,   "timerclk01",   "timer_rclk01", CLK_SET_RATE_PARENT, 0x20, 0, 0, },
+	{ HI3620_TIMER_RCLK01, "timer_rclk01", "rclk_tcxo",    CLK_SET_RATE_PARENT, 0x20, 1, 0, },
+	{ HI3620_TIMERCLK23,   "timerclk23",   "timer_rclk23", CLK_SET_RATE_PARENT, 0x20, 2, 0, },
+	{ HI3620_TIMER_RCLK23, "timer_rclk23", "rclk_tcxo",    CLK_SET_RATE_PARENT, 0x20, 3, 0, },
+	{ HI3620_RTCCLK,       "rtcclk",       "pclk",         CLK_SET_RATE_PARENT, 0x20, 5, 0, },
+	{ HI3620_KPC_CLK,      "kpc_clk",      "pclk",         CLK_SET_RATE_PARENT, 0x20, 6, 0, },
+	{ HI3620_GPIOCLK0,     "gpioclk0",     "pclk",         CLK_SET_RATE_PARENT, 0x20, 8, 0, },
+	{ HI3620_GPIOCLK1,     "gpioclk1",     "pclk",         CLK_SET_RATE_PARENT, 0x20, 9, 0, },
+	{ HI3620_GPIOCLK2,     "gpioclk2",     "pclk",         CLK_SET_RATE_PARENT, 0x20, 10, 0, },
+	{ HI3620_GPIOCLK3,     "gpioclk3",     "pclk",         CLK_SET_RATE_PARENT, 0x20, 11, 0, },
+	{ HI3620_GPIOCLK4,     "gpioclk4",     "pclk",         CLK_SET_RATE_PARENT, 0x20, 12, 0, },
+	{ HI3620_GPIOCLK5,     "gpioclk5",     "pclk",         CLK_SET_RATE_PARENT, 0x20, 13, 0, },
+	{ HI3620_GPIOCLK6,     "gpioclk6",     "pclk",         CLK_SET_RATE_PARENT, 0x20, 14, 0, },
+	{ HI3620_GPIOCLK7,     "gpioclk7",     "pclk",         CLK_SET_RATE_PARENT, 0x20, 15, 0, },
+	{ HI3620_GPIOCLK8,     "gpioclk8",     "pclk",         CLK_SET_RATE_PARENT, 0x20, 16, 0, },
+	{ HI3620_GPIOCLK9,     "gpioclk9",     "pclk",         CLK_SET_RATE_PARENT, 0x20, 17, 0, },
+	{ HI3620_GPIOCLK10,    "gpioclk10",    "pclk",         CLK_SET_RATE_PARENT, 0x20, 18, 0, },
+	{ HI3620_GPIOCLK11,    "gpioclk11",    "pclk",         CLK_SET_RATE_PARENT, 0x20, 19, 0, },
+	{ HI3620_GPIOCLK12,    "gpioclk12",    "pclk",         CLK_SET_RATE_PARENT, 0x20, 20, 0, },
+	{ HI3620_GPIOCLK13,    "gpioclk13",    "pclk",         CLK_SET_RATE_PARENT, 0x20, 21, 0, },
+	{ HI3620_GPIOCLK14,    "gpioclk14",    "pclk",         CLK_SET_RATE_PARENT, 0x20, 22, 0, },
+	{ HI3620_GPIOCLK15,    "gpioclk15",    "pclk",         CLK_SET_RATE_PARENT, 0x20, 23, 0, },
+	{ HI3620_GPIOCLK16,    "gpioclk16",    "pclk",         CLK_SET_RATE_PARENT, 0x20, 24, 0, },
+	{ HI3620_GPIOCLK17,    "gpioclk17",    "pclk",         CLK_SET_RATE_PARENT, 0x20, 25, 0, },
+	{ HI3620_GPIOCLK18,    "gpioclk18",    "pclk",         CLK_SET_RATE_PARENT, 0x20, 26, 0, },
+	{ HI3620_GPIOCLK19,    "gpioclk19",    "pclk",         CLK_SET_RATE_PARENT, 0x20, 27, 0, },
+	{ HI3620_GPIOCLK20,    "gpioclk20",    "pclk",         CLK_SET_RATE_PARENT, 0x20, 28, 0, },
+	{ HI3620_GPIOCLK21,    "gpioclk21",    "pclk",         CLK_SET_RATE_PARENT, 0x20, 29, 0, },
+	{ HI3620_DPHY0_CLK,    "dphy0_clk",    "osc26m",       CLK_SET_RATE_PARENT, 0x30, 15, 0, },
+	{ HI3620_DPHY1_CLK,    "dphy1_clk",    "osc26m",       CLK_SET_RATE_PARENT, 0x30, 16, 0, },
+	{ HI3620_DPHY2_CLK,    "dphy2_clk",    "osc26m",       CLK_SET_RATE_PARENT, 0x30, 17, 0, },
+	{ HI3620_USBPHY_CLK,   "usbphy_clk",   "rclk_pico",    CLK_SET_RATE_PARENT, 0x30, 24, 0, },
+	{ HI3620_ACP_CLK,      "acp_clk",      "rclk_cfgaxi",  CLK_SET_RATE_PARENT, 0x30, 28, 0, },
+	{ HI3620_TIMERCLK45,   "timerclk45",   "rclk_tcxo",    CLK_SET_RATE_PARENT, 0x40, 3, 0, },
+	{ HI3620_TIMERCLK67,   "timerclk67",   "rclk_tcxo",    CLK_SET_RATE_PARENT, 0x40, 4, 0, },
+	{ HI3620_TIMERCLK89,   "timerclk89",   "rclk_tcxo",    CLK_SET_RATE_PARENT, 0x40, 5, 0, },
+	{ HI3620_PWMCLK0,      "pwmclk0",      "pwm0_mux",     CLK_SET_RATE_PARENT, 0x40, 7, 0, },
+	{ HI3620_PWMCLK1,      "pwmclk1",      "pwm1_mux",     CLK_SET_RATE_PARENT, 0x40, 8, 0, },
+	{ HI3620_UARTCLK0,     "uartclk0",     "uart0_mux",    CLK_SET_RATE_PARENT, 0x40, 16, 0, },
+	{ HI3620_UARTCLK1,     "uartclk1",     "uart1_mux",    CLK_SET_RATE_PARENT, 0x40, 17, 0, },
+	{ HI3620_UARTCLK2,     "uartclk2",     "uart2_mux",    CLK_SET_RATE_PARENT, 0x40, 18, 0, },
+	{ HI3620_UARTCLK3,     "uartclk3",     "uart3_mux",    CLK_SET_RATE_PARENT, 0x40, 19, 0, },
+	{ HI3620_UARTCLK4,     "uartclk4",     "uart4_mux",    CLK_SET_RATE_PARENT, 0x40, 20, 0, },
+	{ HI3620_SPICLK0,      "spiclk0",      "spi0_mux",     CLK_SET_RATE_PARENT, 0x40, 21, 0, },
+	{ HI3620_SPICLK1,      "spiclk1",      "spi1_mux",     CLK_SET_RATE_PARENT, 0x40, 22, 0, },
+	{ HI3620_SPICLK2,      "spiclk2",      "spi2_mux",     CLK_SET_RATE_PARENT, 0x40, 23, 0, },
+	{ HI3620_I2CCLK0,      "i2cclk0",      "pclk",         CLK_SET_RATE_PARENT, 0x40, 24, 0, },
+	{ HI3620_I2CCLK1,      "i2cclk1",      "pclk",         CLK_SET_RATE_PARENT, 0x40, 25, 0, },
+	{ HI3620_SCI_CLK,      "sci_clk",      "osc26m",       CLK_SET_RATE_PARENT, 0x40, 26, 0, },
+	{ HI3620_I2CCLK2,      "i2cclk2",      "pclk",         CLK_SET_RATE_PARENT, 0x40, 28, 0, },
+	{ HI3620_I2CCLK3,      "i2cclk3",      "pclk",         CLK_SET_RATE_PARENT, 0x40, 29, 0, },
+	{ HI3620_DDRC_PER_CLK, "ddrc_per_clk", "rclk_cfgaxi",  CLK_SET_RATE_PARENT, 0x50, 9, 0, },
+	{ HI3620_DMAC_CLK,     "dmac_clk",     "rclk_cfgaxi",  CLK_SET_RATE_PARENT, 0x50, 10, 0, },
+	{ HI3620_USB2DVC_CLK,  "usb2dvc_clk",  "rclk_cfgaxi",  CLK_SET_RATE_PARENT, 0x50, 17, 0, },
+	{ HI3620_SD_CLK,       "sd_clk",       "sd_div",       CLK_SET_RATE_PARENT, 0x50, 20, 0, },
+	{ HI3620_MMC_CLK1,     "mmc_clk1",     "mmc1_mux2",    CLK_SET_RATE_PARENT, 0x50, 21, 0, },
+	{ HI3620_MMC_CLK2,     "mmc_clk2",     "mmc2_div",     CLK_SET_RATE_PARENT, 0x50, 22, 0, },
+	{ HI3620_MMC_CLK3,     "mmc_clk3",     "mmc3_div",     CLK_SET_RATE_PARENT, 0x50, 23, 0, },
+	{ HI3620_MCU_CLK,      "mcu_clk",      "acp_clk",      CLK_SET_RATE_PARENT, 0x50, 24, 0, },
 };
 
 static void __init hi3620_clk_init(struct device_node *np)
-- 
1.8.3.2
