From: festevam@gmail.com (Fabio Estevam)
Date: Fri,  2 Aug 2013 13:14:07 -0300
Subject: [PATCH] clk: clk-divider: Export clk_register_divider()
Message-ID: <1375460047-27160-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

clk_register_divider() needs to be exported so that it could be used
in a module driver, otherwise we get the following error:

ERROR: "clk_register_divider" [sound/soc/mxs/snd-soc-mxs.ko] undefined!

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/clk/clk-divider.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
index 6d55eb2..98ee97f 100644
--- a/drivers/clk/clk-divider.c
+++ b/drivers/clk/clk-divider.c
@@ -317,6 +317,7 @@ struct clk *clk_register_divider(struct device *dev, const char *name,
 	return _register_divider(dev, name, parent_name, flags, reg, shift,
 			width, clk_divider_flags, NULL, lock);
 }
+EXPORT_SYMBOL_GPL(clk_register_divider);
 
 /**
  * clk_register_divider_table - register a table based divider clock with
-- 
1.8.1.2
