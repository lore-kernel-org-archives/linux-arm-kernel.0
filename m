From: zhangqing@rock-chips.com (Elaine Zhang)
Date: Tue,  8 Aug 2017 15:19:33 +0800
Subject: [PATCH v3 9/9] clk: rockchip: add some critical clocks for rv1108 SoC
In-Reply-To: <1502176547-30817-1-git-send-email-zhangqing@rock-chips.com>
References: <1502176547-30817-1-git-send-email-zhangqing@rock-chips.com>
Message-ID: <1502176773-32415-1-git-send-email-zhangqing@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

the bus/periph/nclk_ddrupctl/pclk_ddrmon/pclk_acodecphy/pclk_pmu
no driver to handle them,
Chip design requirements for these clock to always on.

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
---
 drivers/clk/rockchip/clk-rv1108.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/rockchip/clk-rv1108.c b/drivers/clk/rockchip/clk-rv1108.c
index b845c5d8e792..e3101d8dae08 100644
--- a/drivers/clk/rockchip/clk-rv1108.c
+++ b/drivers/clk/rockchip/clk-rv1108.c
@@ -776,10 +776,16 @@ enum rv1108_plls {
 
 static const char *const rv1108_critical_clocks[] __initconst = {
 	"aclk_core",
-	"aclk_bus_src_gpll",
+	"aclk_bus",
+	"hclk_bus",
+	"pclk_bus",
 	"aclk_periph",
 	"hclk_periph",
 	"pclk_periph",
+	"nclk_ddrupctl",
+	"pclk_ddrmon",
+	"pclk_acodecphy",
+	"pclk_pmu",
 };
 
 static void __init rv1108_clk_init(struct device_node *np)
-- 
1.9.1
