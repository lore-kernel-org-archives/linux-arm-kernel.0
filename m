From: linux@mniewoehner.de (Michael Niewoehner)
Date: Mon, 17 Aug 2015 21:50:53 +0200
Subject: [PATCH v2] clk: rockchip: add pclk_cpu to the list of rk3188 critical
 clocks
In-Reply-To: <10213368.VjAQGt7Kjq@phil>
References: <5400BEF8-5245-4F7B-845B-D326A7BC56B5@mniewoehner.de>
 <5275855.eah07vmf4I@phil>
 <9DBF9CCE-196E-43FB-BA76-BFB4B5F47A22@mniewoehner.de>
 <10213368.VjAQGt7Kjq@phil>
Message-ID: <F5234F5E-2A91-4B63-B260-3F20A4D16A9D@mniewoehner.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

pclk_cpu needs to keep running because it is needed for devices like
the act8865 regulator but with the recent gpio clock handling this is
not always the case anymore. So add it to the list of critical clocks.

Signed-off-by: Michael Niewoehner <linux@mniewoehner.de>
---
Changes in v2:
- adapt commit message
- add Linus Walleij to recipients, as the patch is related to the gpio clock
  change in the rockchip pinctrl driver it should go through his tree as well

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
