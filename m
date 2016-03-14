From: wxt@rock-chips.com (Caesar Wang)
Date: Mon, 14 Mar 2016 16:01:57 +0800
Subject: [PATCH v3 6/9] clk: rockchip: associate the rk3036 HCLK_EMAC clock-id
In-Reply-To: <1457942520-12859-1-git-send-email-wxt@rock-chips.com>
References: <1457942520-12859-1-git-send-email-wxt@rock-chips.com>
Message-ID: <1457942520-12859-7-git-send-email-wxt@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Xing Zheng <zhengxing@rock-chips.com>

Associate the new clock id the clock.

Signed-off-by: Xing Zheng <zhengxing@rock-chips.com>
Signed-off-by: Caesar Wang <wxt@rock-chips.com>
Cc: Xing Zheng <zhengxing@rock-chips.com>
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: Stephen Boyd <sboyd@codeaurora.org>
Cc: linux-clk at vger.kernel.org
Cc: linux-rockchip at lists.infradead.org

---

Changes in v3:
- Add the Cc people.

Changes in v2: None

 drivers/clk/rockchip/clk-rk3036.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/rockchip/clk-rk3036.c b/drivers/clk/rockchip/clk-rk3036.c
index 0703c8f..cc66e5f 100644
--- a/drivers/clk/rockchip/clk-rk3036.c
+++ b/drivers/clk/rockchip/clk-rk3036.c
@@ -408,7 +408,7 @@ static struct rockchip_clk_branch rk3036_clk_branches[] __initdata = {
 	GATE(HCLK_OTG1, "hclk_otg1", "hclk_peri", CLK_IGNORE_UNUSED, RK2928_CLKGATE_CON(7), 3, GFLAGS),
 	GATE(HCLK_I2S, "hclk_i2s", "hclk_peri", 0, RK2928_CLKGATE_CON(7), 2, GFLAGS),
 	GATE(0, "hclk_sfc", "hclk_peri", CLK_IGNORE_UNUSED, RK2928_CLKGATE_CON(3), 14, GFLAGS),
-	GATE(0, "hclk_mac", "hclk_peri", CLK_IGNORE_UNUSED, RK2928_CLKGATE_CON(3), 15, GFLAGS),
+	GATE(HCLK_MAC, "hclk_mac", "hclk_peri", 0, RK2928_CLKGATE_CON(3), 5, GFLAGS),
 
 	/* pclk_peri gates */
 	GATE(0, "pclk_peri_matrix", "pclk_peri", CLK_IGNORE_UNUSED, RK2928_CLKGATE_CON(4), 1, GFLAGS),
-- 
1.9.1
