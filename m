From: zyw@rock-chips.com (Chris Zhong)
Date: Sat, 10 Oct 2015 17:55:21 +0800
Subject: [PATCH 01/10] clk: rockchip: Add sclk_mipidsi_24m for mipi dsi
In-Reply-To: <1444470930-17150-1-git-send-email-zyw@rock-chips.com>
References: <1444470930-17150-1-git-send-email-zyw@rock-chips.com>
Message-ID: <1444470930-17150-2-git-send-email-zyw@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

sclk_mipidsi_24m is the gating of mipi dsi phy.

Signed-off-by: Chris Zhong <zyw@rock-chips.com>
---

 drivers/clk/rockchip/clk-rk3288.c      | 2 +-
 include/dt-bindings/clock/rk3288-cru.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/rockchip/clk-rk3288.c b/drivers/clk/rockchip/clk-rk3288.c
index 9040878..c7d7ebf 100644
--- a/drivers/clk/rockchip/clk-rk3288.c
+++ b/drivers/clk/rockchip/clk-rk3288.c
@@ -709,7 +709,7 @@ static struct rockchip_clk_branch rk3288_clk_branches[] __initdata = {
 	GATE(SCLK_LCDC_PWM1, "sclk_lcdc_pwm1", "xin24m", 0, RK3288_CLKGATE_CON(13), 11, GFLAGS),
 	GATE(SCLK_PVTM_CORE, "sclk_pvtm_core", "xin24m", 0, RK3288_CLKGATE_CON(5), 9, GFLAGS),
 	GATE(SCLK_PVTM_GPU, "sclk_pvtm_gpu", "xin24m", 0, RK3288_CLKGATE_CON(5), 10, GFLAGS),
-	GATE(0, "sclk_mipidsi_24m", "xin24m", 0, RK3288_CLKGATE_CON(5), 15, GFLAGS),
+	GATE(SCLK_MIPI_24M, "sclk_mipidsi_24m", "xin24m", 0, RK3288_CLKGATE_CON(5), 15, GFLAGS),
 
 	/* sclk_gpu gates */
 	GATE(ACLK_GPU, "aclk_gpu", "sclk_gpu", 0, RK3288_CLKGATE_CON(18), 0, GFLAGS),
diff --git a/include/dt-bindings/clock/rk3288-cru.h b/include/dt-bindings/clock/rk3288-cru.h
index c719aac..b07cdd3 100644
--- a/include/dt-bindings/clock/rk3288-cru.h
+++ b/include/dt-bindings/clock/rk3288-cru.h
@@ -86,6 +86,7 @@
 #define SCLK_USBPHY480M_SRC	122
 #define SCLK_PVTM_CORE		123
 #define SCLK_PVTM_GPU		124
+#define SCLK_MIPI_24M		125
 
 #define SCLK_MAC		151
 #define SCLK_MACREF_OUT		152
-- 
2.6.1
