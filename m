From: zhangqing@rock-chips.com (Elaine Zhang)
Date: Thu, 16 Mar 2017 16:44:54 +0800
Subject: [PATCH v1 4/4] clk: rockchip: rk3368: add CLK_IGNORE_UNUSED flag for
 some clks
In-Reply-To: <1489653894-2440-1-git-send-email-zhangqing@rock-chips.com>
References: <1489653894-2440-1-git-send-email-zhangqing@rock-chips.com>
Message-ID: <1489653894-2440-5-git-send-email-zhangqing@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
---
 drivers/clk/rockchip/clk-rk3368.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/rockchip/clk-rk3368.c b/drivers/clk/rockchip/clk-rk3368.c
index 6cb474c593e7..e91dd52c328f 100644
--- a/drivers/clk/rockchip/clk-rk3368.c
+++ b/drivers/clk/rockchip/clk-rk3368.c
@@ -638,7 +638,7 @@ enum rk3368_plls {
 	GATE(SCLK_MAC_TX, "sclk_mac_tx", "mac_clk", 0,
 			RK3368_CLKGATE_CON(7), 5, GFLAGS),
 
-	GATE(0, "jtag", "ext_jtag", 0,
+	GATE(0, "jtag", "ext_jtag", CLK_IGNORE_UNUSED,
 			RK3368_CLKGATE_CON(7), 0, GFLAGS),
 
 	COMPOSITE_NODIV(0, "hsic_usbphy_480m", mux_hsic_usbphy480m_p, 0,
@@ -702,8 +702,8 @@ enum rk3368_plls {
 	GATE(MCLK_CRYPTO, "mclk_crypto", "hclk_bus", 0, RK3368_CLKGATE_CON(13), 3, GFLAGS),
 
 	/* pclk_cpu gates */
-	GATE(PCLK_DDRPHY, "pclk_ddrphy", "pclk_bus", 0, RK3368_CLKGATE_CON(12), 14, GFLAGS),
-	GATE(PCLK_DDRUPCTL, "pclk_ddrupctl", "pclk_bus", 0, RK3368_CLKGATE_CON(12), 13, GFLAGS),
+	GATE(PCLK_DDRPHY, "pclk_ddrphy", "pclk_bus", CLK_IGNORE_UNUSED, RK3368_CLKGATE_CON(12), 14, GFLAGS),
+	GATE(PCLK_DDRUPCTL, "pclk_ddrupctl", "pclk_bus", CLK_IGNORE_UNUSED, RK3368_CLKGATE_CON(12), 13, GFLAGS),
 	GATE(PCLK_I2C1, "pclk_i2c1", "pclk_bus", 0, RK3368_CLKGATE_CON(12), 3, GFLAGS),
 	GATE(PCLK_I2C0, "pclk_i2c0", "pclk_bus", 0, RK3368_CLKGATE_CON(12), 2, GFLAGS),
 	GATE(PCLK_MAILBOX, "pclk_mailbox", "pclk_bus", 0, RK3368_CLKGATE_CON(12), 1, GFLAGS),
@@ -711,8 +711,8 @@ enum rk3368_plls {
 	GATE(PCLK_SIM, "pclk_sim", "pclk_bus", 0, RK3368_CLKGATE_CON(13), 8, GFLAGS),
 	GATE(PCLK_PWM1, "pclk_pwm1", "pclk_bus", 0, RK3368_CLKGATE_CON(13), 6, GFLAGS),
 	GATE(PCLK_UART2, "pclk_uart2", "pclk_bus", 0, RK3368_CLKGATE_CON(13), 5, GFLAGS),
-	GATE(0, "pclk_efuse_256", "pclk_bus", 0, RK3368_CLKGATE_CON(13), 1, GFLAGS),
-	GATE(0, "pclk_efuse_1024", "pclk_bus", 0, RK3368_CLKGATE_CON(13), 0, GFLAGS),
+	GATE(0, "pclk_efuse_256", "pclk_bus", CLK_IGNORE_UNUSED, RK3368_CLKGATE_CON(13), 1, GFLAGS),
+	GATE(0, "pclk_efuse_1024", "pclk_bus", CLK_IGNORE_UNUSED, RK3368_CLKGATE_CON(13), 0, GFLAGS),
 
 	/*
 	 * video clk gates
@@ -786,7 +786,7 @@ enum rk3368_plls {
 	GATE(HCLK_HSIC, "hclk_hsic", "hclk_peri", 0, RK3368_CLKGATE_CON(20), 5, GFLAGS),
 	GATE(HCLK_HOST1, "hclk_host1", "hclk_peri", CLK_IGNORE_UNUSED, RK3368_CLKGATE_CON(20), 4, GFLAGS),
 	GATE(HCLK_HOST0, "hclk_host0", "hclk_peri", 0, RK3368_CLKGATE_CON(20), 3, GFLAGS),
-	GATE(0, "pmu_hclk_otg0", "hclk_peri", 0, RK3368_CLKGATE_CON(20), 2, GFLAGS),
+	GATE(0, "pmu_hclk_otg0", "hclk_peri", CLK_IGNORE_UNUSED, RK3368_CLKGATE_CON(20), 2, GFLAGS),
 	GATE(HCLK_OTG0, "hclk_otg0", "hclk_peri", CLK_IGNORE_UNUSED, RK3368_CLKGATE_CON(20), 1, GFLAGS),
 	GATE(HCLK_HSADC, "hclk_hsadc", "hclk_peri", 0, RK3368_CLKGATE_CON(21), 3, GFLAGS),
 	GATE(HCLK_EMMC, "hclk_emmc", "hclk_peri", 0, RK3368_CLKGATE_CON(21), 2, GFLAGS),
-- 
1.9.1
