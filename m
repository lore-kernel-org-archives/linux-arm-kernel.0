From: guodong.xu@linaro.org (Guodong Xu)
Date: Mon, 15 May 2017 13:54:21 +0800
Subject: [PATCH 1/3] clk: hi3660: fix wrong parent name of clk_mux_sysbus
Message-ID: <20170515055423.1803-1-guodong.xu@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Chen Jun <chenjun14@huawei.com>

Parent name of clk_mux_sysbus is not correct. This patch fixes it.

Signed-off-by: Chen Jun <chenjun14@huawei.com>
Signed-off-by: John Stultz <john.stultz@linaro.org>
Signed-off-by: Guodong Xu <guodong.xu@linaro.org>
---
 drivers/clk/hisilicon/clk-hi3660.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/hisilicon/clk-hi3660.c b/drivers/clk/hisilicon/clk-hi3660.c
index 96a9697..143ce0c 100644
--- a/drivers/clk/hisilicon/clk-hi3660.c
+++ b/drivers/clk/hisilicon/clk-hi3660.c
@@ -206,6 +206,8 @@ static const struct hisi_gate_clock hi3660_crgctrl_gate_clks[] = {
 };
 
 static const char *const
+clk_mux_sysbus_p[] = {"clk_ppll1", "clk_ppll0"};
+static const char *const
 clk_mux_sdio_sys_p[] = {"clk_factor_mmc", "clk_div_sdio",};
 static const char *const
 clk_mux_sd_sys_p[] = {"clk_factor_mmc", "clk_div_sd",};
@@ -239,8 +241,8 @@ static const char *const
 clk_mux_i2c_p[] = {"clkin_sys", "clk_div_i2c",};
 
 static const struct hisi_mux_clock hi3660_crgctrl_mux_clks[] = {
-	{ HI3660_CLK_MUX_SYSBUS, "clk_mux_sysbus", clk_mux_sdio_sys_p,
-	  ARRAY_SIZE(clk_mux_sdio_sys_p), CLK_SET_RATE_PARENT, 0xac, 0, 1,
+	{ HI3660_CLK_MUX_SYSBUS, "clk_mux_sysbus", clk_mux_sysbus_p,
+	  ARRAY_SIZE(clk_mux_sysbus_p), CLK_SET_RATE_PARENT, 0xac, 0, 1,
 	  CLK_MUX_HIWORD_MASK, },
 	{ HI3660_CLK_MUX_UART0, "clk_mux_uart0", clk_mux_uart0_p,
 	  ARRAY_SIZE(clk_mux_uart0_p), CLK_SET_RATE_PARENT, 0xac, 2, 1,
-- 
2.10.2
