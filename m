From: gabriel.fernandez@st.com (gabriel.fernandez at st.com)
Date: Tue, 18 Jul 2017 09:53:32 +0200
Subject: [PATCH v6 1/3] clk: nxp: clk-lpc32xx: rename clk_gate_is_enabled()
In-Reply-To: <1500364414-10021-1-git-send-email-gabriel.fernandez@st.com>
References: <1500364414-10021-1-git-send-email-gabriel.fernandez@st.com>
Message-ID: <1500364414-10021-2-git-send-email-gabriel.fernandez@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gabriel Fernandez <gabriel.fernandez@st.com>

We need to export clk_gate_is_enabled() from clk framework, then
to avoid compilation issue we have to rename clk_gate_is_enabled()
in NXP LPC32xx clock driver.

Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
---
 drivers/clk/nxp/clk-lpc32xx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/nxp/clk-lpc32xx.c b/drivers/clk/nxp/clk-lpc32xx.c
index 5b98ff9..1cc71ad 100644
--- a/drivers/clk/nxp/clk-lpc32xx.c
+++ b/drivers/clk/nxp/clk-lpc32xx.c
@@ -903,7 +903,7 @@ static void clk_gate_disable(struct clk_hw *hw)
 	regmap_update_bits(clk_regmap, clk->reg, mask, val);
 }
 
-static int clk_gate_is_enabled(struct clk_hw *hw)
+static int __clk_gate_is_enabled(struct clk_hw *hw)
 {
 	struct lpc32xx_clk_gate *clk = to_lpc32xx_gate(hw);
 	u32 val;
@@ -918,7 +918,7 @@ static int clk_gate_is_enabled(struct clk_hw *hw)
 static const struct clk_ops lpc32xx_clk_gate_ops = {
 	.enable = clk_gate_enable,
 	.disable = clk_gate_disable,
-	.is_enabled = clk_gate_is_enabled,
+	.is_enabled = __clk_gate_is_enabled,
 };
 
 #define div_mask(width)	((1 << (width)) - 1)
-- 
1.9.1
