From: sboyd@kernel.org (Stephen Boyd)
Date: Wed, 28 Nov 2018 10:37:02 -0800
Subject: [PATCH] clk: renesas: Mark rza2_cpg_clk_register static
Message-ID: <20181128183702.231609-1-sboyd@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is only used in this file, so mark it static to silence a sparse
warning.

Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---

I've applied this to clk-renesas branch already, just not pushed out
yet.

 drivers/clk/renesas/r7s9210-cpg-mssr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/renesas/r7s9210-cpg-mssr.c b/drivers/clk/renesas/r7s9210-cpg-mssr.c
index e0793a9eb668..57c49fe88295 100644
--- a/drivers/clk/renesas/r7s9210-cpg-mssr.c
+++ b/drivers/clk/renesas/r7s9210-cpg-mssr.c
@@ -155,7 +155,7 @@ static void __init r7s9210_update_clk_table(struct clk *extal_clk,
 	}
 }
 
-struct clk * __init rza2_cpg_clk_register(struct device *dev,
+static struct clk * __init rza2_cpg_clk_register(struct device *dev,
 	const struct cpg_core_clk *core, const struct cpg_mssr_info *info,
 	struct clk **clks, void __iomem *base,
 	struct raw_notifier_head *notifiers)
-- 
Sent by a computer through tubes
