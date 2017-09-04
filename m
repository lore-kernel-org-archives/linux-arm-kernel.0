From: romain.perier@collabora.com (Romain Perier)
Date: Mon,  4 Sep 2017 10:51:17 +0200
Subject: [PATCH v2 2/4] clk: rockchip: export clock pclk_efuse_256 for RK3368
 SoCs
In-Reply-To: <20170904085119.25981-1-romain.perier@collabora.com>
References: <20170904085119.25981-1-romain.perier@collabora.com>
Message-ID: <20170904085119.25981-3-romain.perier@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This exports the clock for the pclk gate of the eFuse that is part of
the RK3368 SoCs. So we can use it from the dt-bindings.

Signed-off-by: Romain Perier <romain.perier@collabora.com>
---
 drivers/clk/rockchip/clk-rk3368.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/rockchip/clk-rk3368.c b/drivers/clk/rockchip/clk-rk3368.c
index fc56565379dd..7c4d242f19c1 100644
--- a/drivers/clk/rockchip/clk-rk3368.c
+++ b/drivers/clk/rockchip/clk-rk3368.c
@@ -711,7 +711,7 @@ static struct rockchip_clk_branch rk3368_clk_branches[] __initdata = {
 	GATE(PCLK_SIM, "pclk_sim", "pclk_bus", 0, RK3368_CLKGATE_CON(13), 8, GFLAGS),
 	GATE(PCLK_PWM1, "pclk_pwm1", "pclk_bus", 0, RK3368_CLKGATE_CON(13), 6, GFLAGS),
 	GATE(PCLK_UART2, "pclk_uart2", "pclk_bus", 0, RK3368_CLKGATE_CON(13), 5, GFLAGS),
-	GATE(0, "pclk_efuse_256", "pclk_bus", 0, RK3368_CLKGATE_CON(13), 1, GFLAGS),
+	GATE(PCLK_EFUSE256, "pclk_efuse_256", "pclk_bus", 0, RK3368_CLKGATE_CON(13), 1, GFLAGS),
 	GATE(0, "pclk_efuse_1024", "pclk_bus", 0, RK3368_CLKGATE_CON(13), 0, GFLAGS),
 
 	/*
-- 
2.11.0
