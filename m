From: paweljarosz3691@gmail.com (=?UTF-8?q?Pawe=C5=82=20Jarosz?=)
Date: Tue, 19 Jan 2016 13:09:20 +0100
Subject: [PATCH 2/3] clk: rockchip: add tsadc clock on rk3066
In-Reply-To: <1453205361-27267-1-git-send-email-paweljarosz3691@gmail.com>
References: <1453205361-27267-1-git-send-email-paweljarosz3691@gmail.com>
Message-ID: <1453205361-27267-3-git-send-email-paweljarosz3691@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Set clock id for sclk_tsadc gating clock of tsadc in rk3066

Signed-off-by: Pawe? Jarosz <paweljarosz3691@gmail.com>
---
 drivers/clk/rockchip/clk-rk3188.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/rockchip/clk-rk3188.c b/drivers/clk/rockchip/clk-rk3188.c
index 7f7444c..fda4e77 100644
--- a/drivers/clk/rockchip/clk-rk3188.c
+++ b/drivers/clk/rockchip/clk-rk3188.c
@@ -605,7 +605,7 @@ static struct rockchip_clk_branch rk3066a_clk_branches[] __initdata = {
 	GATE(SCLK_TIMER2, "timer2", "xin24m", 0,
 			RK2928_CLKGATE_CON(3), 2, GFLAGS),
 
-	COMPOSITE_NOMUX(0, "sclk_tsadc", "xin24m", 0,
+	COMPOSITE_NOMUX(SCLK_TSADC, "sclk_tsadc", "xin24m", 0,
 			RK2928_CLKSEL_CON(34), 0, 16, DFLAGS,
 			RK2928_CLKGATE_CON(2), 15, GFLAGS),
 
-- 
1.9.1
