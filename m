From: hl@rock-chips.com (Lin Huang)
Date: Fri,  7 Aug 2015 17:31:11 +0800
Subject: [PATCH v4 1/2] clk: rockchip: add pclk_pd_pmu to the list of rk3288
 critical clocks
Message-ID: <1438939872-2116-1-git-send-email-hl@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

pclk_pd_pmu needs to keep running and with the upcoming gpio clock
handling this is not always the case anymore. So add it to the list
of critical clocks for now.

From: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Lin Huang <hl@rock-chips.com>
---
Changes in v4:
- Add From: Heiko Stuebner <heiko@sntech.de>

 drivers/clk/rockchip/clk-rk3288.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/rockchip/clk-rk3288.c b/drivers/clk/rockchip/clk-rk3288.c
index 0df5bae..9040878 100644
--- a/drivers/clk/rockchip/clk-rk3288.c
+++ b/drivers/clk/rockchip/clk-rk3288.c
@@ -780,6 +780,7 @@ static const char *const rk3288_critical_clocks[] __initconst = {
 	"aclk_cpu",
 	"aclk_peri",
 	"hclk_peri",
+	"pclk_pd_pmu",
 };
 
 #ifdef CONFIG_PM_SLEEP
-- 
1.9.1
