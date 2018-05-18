From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Fri, 18 May 2018 12:58:40 +0200
Subject: [PATCH] clkdev: Remove duplicated negative index check from
 __of_clk_get()
Message-ID: <1526641120-1585-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

__of_clk_get() calls of_parse_phandle_with_args(), which rejects
negative indices since commit bd69f73f2c81eed9 ("of: Create function for
counting number of phandles in a property").

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Commit bd69f73f2c81eed9 is in v3.9.
---
 drivers/clk/clkdev.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/clk/clkdev.c b/drivers/clk/clkdev.c
index 7513411140b693ec..02fcee2012e05250 100644
--- a/drivers/clk/clkdev.c
+++ b/drivers/clk/clkdev.c
@@ -35,9 +35,6 @@ static struct clk *__of_clk_get(struct device_node *np, int index,
 	struct clk *clk;
 	int rc;
 
-	if (index < 0)
-		return ERR_PTR(-EINVAL);
-
 	rc = of_parse_phandle_with_args(np, "clocks", "#clock-cells", index,
 					&clkspec);
 	if (rc)
-- 
2.7.4
