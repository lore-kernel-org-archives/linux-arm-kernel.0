From: james.hogan@imgtec.com (James Hogan)
Date: Mon, 25 Mar 2013 14:35:07 +0000
Subject: [PATCH 1/1] clk: fix clk_mux::flags kerneldoc
Message-ID: <1364222107-1079-1-git-send-email-james.hogan@imgtec.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The kerneldoc comment for struct clk_mux documented the non-existent
num_clks instead of flags. Correct this.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
---
 include/linux/clk-provider.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index cdad3ce..e7504d5 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -276,7 +276,7 @@ struct clk *clk_register_divider_table(struct device *dev, const char *name,
  * @reg:	register controlling multiplexer
  * @shift:	shift to multiplexer bit field
  * @width:	width of mutliplexer bit field
- * @num_clks:	number of parent clocks
+ * @flags:	hardware-specific flags
  * @lock:	register lock
  *
  * Clock with multiple selectable parents.  Implements .get_parent, .set_parent
-- 
1.8.1.2
