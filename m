From: dianders@chromium.org (Douglas Anderson)
Date: Wed, 24 Aug 2016 11:29:39 -0700
Subject: [PATCH] clk: rockchip: mark aclk_emmc_noc as a critical clock on
 rk3399
Message-ID: <1472063379-717-1-git-send-email-dianders@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Xing Zheng <zhengxing@rock-chips.com>

We don't have code to handle any of the noc clocks in rk3399 and they're
all just listed as critical clocks.  Let's do the same for
aclk_emmc_noc.

Without this clock being marked as critical we have problems around
suspend/resume after commit 20c389e656a8 ("clk: rockchip: fix incorrect
aclk_emmc source gate bits on rk3399").  Before that change we were
presumably not actually gating any of these clocks because we were
setting the wrong gate.

Signed-off-by: Xing Zheng <zhengxing@rock-chips.com>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
 drivers/clk/rockchip/clk-rk3399.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/rockchip/clk-rk3399.c b/drivers/clk/rockchip/clk-rk3399.c
index e445cd64952a..ede6c475b537 100644
--- a/drivers/clk/rockchip/clk-rk3399.c
+++ b/drivers/clk/rockchip/clk-rk3399.c
@@ -1489,6 +1489,7 @@ static const char *const rk3399_cru_critical_clocks[] __initconst = {
 	"hclk_perilp1",
 	"hclk_perilp1_noc",
 	"aclk_dmac0_perilp",
+	"aclk_emmc_noc",
 	"gpll_hclk_perilp1_src",
 	"gpll_aclk_perilp0_src",
 	"gpll_aclk_perihp_src",
-- 
2.8.0.rc3.226.g39d4020
