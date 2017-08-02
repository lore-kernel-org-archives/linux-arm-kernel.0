From: andy.yan@rock-chips.com (Andy Yan)
Date: Wed,  2 Aug 2017 16:36:54 +0800
Subject: [PATCH v2 09/23] clk: rockchip: add some critical clocks for rv1108
 SoC
In-Reply-To: <1501662303-11687-1-git-send-email-andy.yan@rock-chips.com>
References: <1501662303-11687-1-git-send-email-andy.yan@rock-chips.com>
Message-ID: <1501663014-12192-1-git-send-email-andy.yan@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Elaine Zhang <zhangqing@rock-chips.com>

the bus/periph/nclk_ddrupctl/pclk_ddrmon/pclk_acodecphy/pclk_pmu
no driver to handle them,
chip design requirements for these clock to always on.

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
---

Changes in v2: None

 drivers/clk/rockchip/clk-rv1108.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/rockchip/clk-rv1108.c b/drivers/clk/rockchip/clk-rv1108.c
index dca9c37..e60d83a 100644
--- a/drivers/clk/rockchip/clk-rv1108.c
+++ b/drivers/clk/rockchip/clk-rv1108.c
@@ -774,10 +774,16 @@ static struct rockchip_clk_branch rv1108_clk_branches[] __initdata = {
 
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
2.7.4
