From: zhengxing@rock-chips.com (Xing Zheng)
Date: Tue, 21 Jun 2016 12:53:29 +0800
Subject: [PATCH 3/5] clk: rockchip: rk3228: export related i2s/spdif clocks
In-Reply-To: <1466484811-26923-1-git-send-email-zhengxing@rock-chips.com>
References: <1466484811-26923-1-git-send-email-zhengxing@rock-chips.com>
Message-ID: <1466484811-26923-4-git-send-email-zhengxing@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch exports related i2s/spdif clocks for dts reference.

Signed-off-by: Xing Zheng <zhengxing@rock-chips.com>
---

 drivers/clk/rockchip/clk-rk3228.c      |    8 ++++----
 include/dt-bindings/clock/rk3228-cru.h |    4 ++++
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/rockchip/clk-rk3228.c b/drivers/clk/rockchip/clk-rk3228.c
index 72bcdba..79a3db1 100644
--- a/drivers/clk/rockchip/clk-rk3228.c
+++ b/drivers/clk/rockchip/clk-rk3228.c
@@ -581,10 +581,10 @@ static struct rockchip_clk_branch rk3228_clk_branches[] __initdata = {
 	GATE(0, "aclk_bus_noc", "aclk_cpu", CLK_IGNORE_UNUSED, RK2928_CLKGATE_CON(10), 1, GFLAGS),
 
 	GATE(0, "hclk_rom", "hclk_cpu", 0, RK2928_CLKGATE_CON(8), 3, GFLAGS),
-	GATE(0, "hclk_i2s0_8ch", "hclk_cpu", 0, RK2928_CLKGATE_CON(8), 7, GFLAGS),
-	GATE(0, "hclk_i2s1_8ch", "hclk_cpu", 0, RK2928_CLKGATE_CON(8), 8, GFLAGS),
-	GATE(0, "hclk_i2s2_2ch", "hclk_cpu", 0, RK2928_CLKGATE_CON(8), 9, GFLAGS),
-	GATE(0, "hclk_spdif_8ch", "hclk_cpu", 0, RK2928_CLKGATE_CON(8), 10, GFLAGS),
+	GATE(HCLK_I2S0_8CH, "hclk_i2s0_8ch", "hclk_cpu", 0, RK2928_CLKGATE_CON(8), 7, GFLAGS),
+	GATE(HCLK_I2S1_8CH, "hclk_i2s1_8ch", "hclk_cpu", 0, RK2928_CLKGATE_CON(8), 8, GFLAGS),
+	GATE(HCLK_I2S2_2CH, "hclk_i2s2_2ch", "hclk_cpu", 0, RK2928_CLKGATE_CON(8), 9, GFLAGS),
+	GATE(HCLK_SPDIF_8CH, "hclk_spdif_8ch", "hclk_cpu", 0, RK2928_CLKGATE_CON(8), 10, GFLAGS),
 	GATE(0, "hclk_tsp", "hclk_cpu", 0, RK2928_CLKGATE_CON(10), 11, GFLAGS),
 	GATE(0, "hclk_crypto_mst", "hclk_cpu", 0, RK2928_CLKGATE_CON(8), 11, GFLAGS),
 	GATE(0, "hclk_crypto_slv", "hclk_cpu", 0, RK2928_CLKGATE_CON(8), 12, GFLAGS),
diff --git a/include/dt-bindings/clock/rk3228-cru.h b/include/dt-bindings/clock/rk3228-cru.h
index 5d43ed9..c992f3e 100644
--- a/include/dt-bindings/clock/rk3228-cru.h
+++ b/include/dt-bindings/clock/rk3228-cru.h
@@ -84,6 +84,10 @@
 #define PCLK_HDMI_PHY		365
 
 /* hclk gates */
+#define HCLK_I2S0_8CH		442
+#define HCLK_I2S1_8CH		443
+#define HCLK_I2S2_2CH		444
+#define HCLK_SPDIF_8CH		445
 #define HCLK_VOP		452
 #define HCLK_NANDC		453
 #define HCLK_SDMMC		456
-- 
1.7.9.5
