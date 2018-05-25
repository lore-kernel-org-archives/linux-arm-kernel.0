From: david@lechnology.com (David Lechner)
Date: Fri, 25 May 2018 13:11:43 -0500
Subject: [PATCH 2/9] clk: davinci: pll-dm355: fix SYSCLKn parent names
In-Reply-To: <20180525181150.17873-1-david@lechnology.com>
References: <20180525181150.17873-1-david@lechnology.com>
Message-ID: <20180525181150.17873-3-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This fixes the parent clock names of the SYSCLKn clocks for the DM355
SoC in the TI DaVinici PLL clock driver.

It appears that this name just didn't get updated to the correct name
like the other SoCs during the driver's development.

Reported-by: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: David Lechner <david@lechnology.com>
Acked-by: Sekhar Nori <nsekhar@ti.com>
---
 drivers/clk/davinci/pll-dm355.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/davinci/pll-dm355.c b/drivers/clk/davinci/pll-dm355.c
index 718d9bbbf30d..93f4a53d6b44 100644
--- a/drivers/clk/davinci/pll-dm355.c
+++ b/drivers/clk/davinci/pll-dm355.c
@@ -22,10 +22,10 @@ static const struct davinci_pll_clk_info dm355_pll1_info = {
 		 PLL_POSTDIV_ALWAYS_ENABLED | PLL_POSTDIV_FIXED_DIV,
 };
 
-SYSCLK(1, pll1_sysclk1, pll1, 5, SYSCLK_FIXED_DIV | SYSCLK_ALWAYS_ENABLED);
-SYSCLK(2, pll1_sysclk2, pll1, 5, SYSCLK_FIXED_DIV | SYSCLK_ALWAYS_ENABLED);
-SYSCLK(3, pll1_sysclk3, pll1, 5, SYSCLK_ALWAYS_ENABLED);
-SYSCLK(4, pll1_sysclk4, pll1, 5, SYSCLK_ALWAYS_ENABLED);
+SYSCLK(1, pll1_sysclk1, pll1_pllen, 5, SYSCLK_FIXED_DIV | SYSCLK_ALWAYS_ENABLED);
+SYSCLK(2, pll1_sysclk2, pll1_pllen, 5, SYSCLK_FIXED_DIV | SYSCLK_ALWAYS_ENABLED);
+SYSCLK(3, pll1_sysclk3, pll1_pllen, 5, SYSCLK_ALWAYS_ENABLED);
+SYSCLK(4, pll1_sysclk4, pll1_pllen, 5, SYSCLK_ALWAYS_ENABLED);
 
 int dm355_pll1_init(struct device *dev, void __iomem *base)
 {
@@ -62,7 +62,7 @@ static const struct davinci_pll_clk_info dm355_pll2_info = {
 		 PLL_POSTDIV_ALWAYS_ENABLED | PLL_POSTDIV_FIXED_DIV,
 };
 
-SYSCLK(1, pll2_sysclk1, pll2, 5, SYSCLK_FIXED_DIV | SYSCLK_ALWAYS_ENABLED);
+SYSCLK(1, pll2_sysclk1, pll2_pllen, 5, SYSCLK_FIXED_DIV | SYSCLK_ALWAYS_ENABLED);
 
 int dm355_pll2_init(struct device *dev, void __iomem *base)
 {
-- 
2.17.0
