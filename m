From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 11 Jul 2016 22:34:47 +0200
Subject: [PATCH 1/2] clk: sunxi-ng: h3: Fix audio clock divider offset
Message-ID: <20160711203448.18062-1-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The code had a typo and got the wrong offset for the hardcoded divider, fix
that.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Reported-by: Jean-Francois Moine <moinejf@free.fr>
Reported-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/clk/sunxi-ng/ccu-sun8i-h3.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-h3.c b/drivers/clk/sunxi-ng/ccu-sun8i-h3.c
index bcc0a95549d3..9af359544110 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-h3.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-h3.c
@@ -817,8 +817,8 @@ static void __init sun8i_h3_ccu_setup(struct device_node *node)
 
 	/* Force the PLL-Audio-1x divider to 4 */
 	val = readl(reg + SUN8I_H3_PLL_AUDIO_REG);
-	val &= ~GENMASK(4, 0);
-	writel(val | 3, reg + SUN8I_H3_PLL_AUDIO_REG);
+	val &= ~GENMASK(19, 16);
+	writel(val | (3 << 16), reg + SUN8I_H3_PLL_AUDIO_REG);
 
 	sunxi_ccu_probe(node, reg, &sun8i_h3_ccu_desc);
 }
-- 
2.9.0
