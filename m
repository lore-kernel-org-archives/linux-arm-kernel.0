From: zhengxing@rock-chips.com (Xing Zheng)
Date: Mon,  1 Aug 2016 12:24:45 +0800
Subject: [RESEND PATCH 5/6] clk: rockchip: rk3399: delete the
 CLK_IGNORE_UNUSED for aclk_pcie
In-Reply-To: <1470025389-4094-1-git-send-email-zhengxing@rock-chips.com>
References: <1470025389-4094-1-git-send-email-zhengxing@rock-chips.com>
Message-ID: <1470025485-4218-1-git-send-email-zhengxing@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Elaine Zhang <zhangqing@rock-chips.com>

allow aclk_pcie and aclk_perf_pcie disabled when unused.

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
Signed-off-by: Xing Zheng <zhengxing@rock-chips.com>

---

 drivers/clk/rockchip/clk-rk3399.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/rockchip/clk-rk3399.c b/drivers/clk/rockchip/clk-rk3399.c
index 74afec0..4a15ce5b 100644
--- a/drivers/clk/rockchip/clk-rk3399.c
+++ b/drivers/clk/rockchip/clk-rk3399.c
@@ -848,9 +848,9 @@ static struct rockchip_clk_branch rk3399_clk_branches[] __initdata = {
 			RK3399_CLKSEL_CON(14), 12, 2, DFLAGS,
 			RK3399_CLKGATE_CON(5), 4, GFLAGS),
 
-	GATE(ACLK_PERF_PCIE, "aclk_perf_pcie", "aclk_perihp", CLK_IGNORE_UNUSED,
+	GATE(ACLK_PERF_PCIE, "aclk_perf_pcie", "aclk_perihp", 0,
 			RK3399_CLKGATE_CON(20), 2, GFLAGS),
-	GATE(ACLK_PCIE, "aclk_pcie", "aclk_perihp", CLK_IGNORE_UNUSED,
+	GATE(ACLK_PCIE, "aclk_pcie", "aclk_perihp", 0,
 			RK3399_CLKGATE_CON(20), 10, GFLAGS),
 	GATE(0, "aclk_perihp_noc", "aclk_perihp", CLK_IGNORE_UNUSED,
 			RK3399_CLKGATE_CON(20), 12, GFLAGS),
-- 
1.7.9.5
