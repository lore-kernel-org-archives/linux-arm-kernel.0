From: zyw@rock-chips.com (Chris Zhong)
Date: Thu, 26 Nov 2015 15:50:16 +0800
Subject: [PATCH v5 02/11] clk: rockchip: add mipidsi clocks on rk3288
In-Reply-To: <1448524225-5489-1-git-send-email-zyw@rock-chips.com>
References: <1448524225-5489-1-git-send-email-zyw@rock-chips.com>
Message-ID: <1448524225-5489-3-git-send-email-zyw@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

sclk_mipidsi_24m is the gating of mipi dsi phy.

Signed-off-by: Chris Zhong <zyw@rock-chips.com>
Acked-by: Stephen Boyd <sboyd@codeaurora.org>

---

Changes in v5:
- modify the mipidsi clk name to SCLK_MIPIDSI_24M

Changes in v4: None
Changes in v3: None
Changes in v2: None

 drivers/clk/rockchip/clk-rk3288.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/rockchip/clk-rk3288.c b/drivers/clk/rockchip/clk-rk3288.c
index 9040878..bee96e7 100644
--- a/drivers/clk/rockchip/clk-rk3288.c
+++ b/drivers/clk/rockchip/clk-rk3288.c
@@ -709,7 +709,7 @@ static struct rockchip_clk_branch rk3288_clk_branches[] __initdata = {
 	GATE(SCLK_LCDC_PWM1, "sclk_lcdc_pwm1", "xin24m", 0, RK3288_CLKGATE_CON(13), 11, GFLAGS),
 	GATE(SCLK_PVTM_CORE, "sclk_pvtm_core", "xin24m", 0, RK3288_CLKGATE_CON(5), 9, GFLAGS),
 	GATE(SCLK_PVTM_GPU, "sclk_pvtm_gpu", "xin24m", 0, RK3288_CLKGATE_CON(5), 10, GFLAGS),
-	GATE(0, "sclk_mipidsi_24m", "xin24m", 0, RK3288_CLKGATE_CON(5), 15, GFLAGS),
+	GATE(SCLK_MIPIDSI_24M, "sclk_mipidsi_24m", "xin24m", 0, RK3288_CLKGATE_CON(5), 15, GFLAGS),
 
 	/* sclk_gpu gates */
 	GATE(ACLK_GPU, "aclk_gpu", "sclk_gpu", 0, RK3288_CLKGATE_CON(18), 0, GFLAGS),
-- 
2.6.3
