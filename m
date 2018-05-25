From: david@lechnology.com (David Lechner)
Date: Fri, 25 May 2018 13:11:45 -0500
Subject: [PATCH 4/9] clk: davinci: pll-dm646x: keep PLL2 SYSCLK1 always enabled
In-Reply-To: <20180525181150.17873-1-david@lechnology.com>
References: <20180525181150.17873-1-david@lechnology.com>
Message-ID: <20180525181150.17873-5-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sekhar Nori <nsekhar@ti.com>

PLL2 SYSCLK1 on DM646x is connected to DDR2 PHY and cannot
be disabled. Mark it so to prevent unused clock disable
infrastructure from disabling it.

Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Reviewed-by: David Lechner <david@lechnology.com>
---
 drivers/clk/davinci/pll-dm646x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/davinci/pll-dm646x.c b/drivers/clk/davinci/pll-dm646x.c
index a61cc3256418..0ae827e3ce80 100644
--- a/drivers/clk/davinci/pll-dm646x.c
+++ b/drivers/clk/davinci/pll-dm646x.c
@@ -72,7 +72,7 @@ static const struct davinci_pll_clk_info dm646x_pll2_info = {
 	.flags = 0,
 };
 
-SYSCLK(1, pll2_sysclk1, pll2_pllen, 4, 0);
+SYSCLK(1, pll2_sysclk1, pll2_pllen, 4, SYSCLK_ALWAYS_ENABLED);
 
 int dm646x_pll2_init(struct device *dev, void __iomem *base)
 {
-- 
2.17.0
