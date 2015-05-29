From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Fri, 29 May 2015 11:25:46 +0200
Subject: [PATCH 2/5] clk: st: Use of_clk_get_parent_count() instead of open
 coding
In-Reply-To: <1432891549-23295-1-git-send-email-geert+renesas@glider.be>
References: <1432891549-23295-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1432891549-23295-3-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/clk/st/clk-flexgen.c | 2 +-
 drivers/clk/st/clkgen-mux.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/st/clk-flexgen.c b/drivers/clk/st/clk-flexgen.c
index 409ed4b0b569ff60..657ca14ba709a64b 100644
--- a/drivers/clk/st/clk-flexgen.c
+++ b/drivers/clk/st/clk-flexgen.c
@@ -245,7 +245,7 @@ static const char ** __init flexgen_get_parents(struct device_node *np,
 	const char **parents;
 	int nparents, i;
 
-	nparents = of_count_phandle_with_args(np, "clocks", "#clock-cells");
+	nparents = of_clk_get_parent_count(np);
 	if (WARN_ON(nparents <= 0))
 		return NULL;
 
diff --git a/drivers/clk/st/clkgen-mux.c b/drivers/clk/st/clkgen-mux.c
index 80aa77dbf660cf0c..4fbe6e099587c054 100644
--- a/drivers/clk/st/clkgen-mux.c
+++ b/drivers/clk/st/clkgen-mux.c
@@ -26,7 +26,7 @@ static const char ** __init clkgen_mux_get_parents(struct device_node *np,
 	const char **parents;
 	int nparents, i;
 
-	nparents = of_count_phandle_with_args(np, "clocks", "#clock-cells");
+	nparents = of_clk_get_parent_count(np);
 	if (WARN_ON(nparents <= 0))
 		return ERR_PTR(-EINVAL);
 
-- 
1.9.1
