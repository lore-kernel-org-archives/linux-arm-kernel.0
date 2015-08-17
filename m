From: linux@mniewoehner.de (Michael Niewoehner)
Date: Mon, 17 Aug 2015 19:38:22 +0200
Subject: [PATCH] clk: rockchip: add pclk_cpu to the list of rk3188 critical
 clocks
Message-ID: <5400BEF8-5245-4F7B-845B-D326A7BC56B5@mniewoehner.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

gpio clock is getting disabled to save power but pclk_cpu is needed for act8865 regulator

Signed-off-by: Michael Niewoehner <linux@mniewoehner.de>
---
 drivers/clk/rockchip/clk-rk3188.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/rockchip/clk-rk3188.c b/drivers/clk/rockchip/clk-rk3188.c
index e4f9d47..1c93229 100644
--- a/drivers/clk/rockchip/clk-rk3188.c
+++ b/drivers/clk/rockchip/clk-rk3188.c
@@ -708,6 +708,7 @@ static const char *const rk3188_critical_clocks[] __initconst = {
 	"aclk_cpu",
 	"aclk_peri",
 	"hclk_peri",
+	"pclk_cpu",
 };
 
 static void __init rk3188_common_clk_init(struct device_node *np)
-- 
2.5.0
