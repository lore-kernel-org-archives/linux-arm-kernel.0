From: zhengxing@rock-chips.com (Xing Zheng)
Date: Wed, 20 Jan 2016 16:37:17 +0800
Subject: [PATCH] clk: rockchip: rk3036: Add apll as the critical clock
Message-ID: <1453279037-23971-1-git-send-email-zhengxing@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The apll may be closed if there are some child clock nodes below
it when the device startup. Therefore, the apll should be keep
critical.

The apll tree like this:
    pll_apll
       apll
          armclk
             pclk_dbg
             aclk_core_pre
          aclk_hvec
          uart_pll_clk
             uart2_src
                uart2_frac
             uart1_src
                uart1_frac
             uart0_src
                uart0_frac

Signed-off-by: Xing Zheng <zhengxing@rock-chips.com>
---

 drivers/clk/rockchip/clk-rk3036.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/rockchip/clk-rk3036.c b/drivers/clk/rockchip/clk-rk3036.c
index ebce980..483913b 100644
--- a/drivers/clk/rockchip/clk-rk3036.c
+++ b/drivers/clk/rockchip/clk-rk3036.c
@@ -425,6 +425,7 @@ static struct rockchip_clk_branch rk3036_clk_branches[] __initdata = {
 };
 
 static const char *const rk3036_critical_clocks[] __initconst = {
+	"apll",
 	"aclk_cpu",
 	"aclk_peri",
 	"hclk_peri",
-- 
1.7.9.5
