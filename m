From: pwalmsley@nvidia.com (Paul Walmsley)
Date: Mon, 25 Nov 2013 15:55:33 -0800
Subject: clk: clk_round_rate() should return 0, not negative numbers, upon
 error
Message-ID: <alpine.DEB.2.02.1311251553080.23090@tamien>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Update the documentation for clk_round_rate() to state that it should
return 0 rather than a negative error code when it encounters an
error.  This describes how the common clock framework currently works;
howeever, some clock code does not yet align to this.

This change is to prepare for returning unsigned values from
clk_round_rate().

Signed-off-by: Paul Walmsley <pwalmsley@nvidia.com>
Cc: Mike Turquette <mturquette@linaro.org>
Cc: Russell King <linux@arm.linux.org.uk>
---
Applies on v3.13-rc1.

  include/linux/clk.h |    2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/clk.h b/include/linux/clk.h
index 9a6d04524b1a..ffbbb7b2de43 100644
--- a/include/linux/clk.h
+++ b/include/linux/clk.h
@@ -228,7 +228,7 @@ void devm_clk_put(struct device *dev, struct clk *clk);
   * @clk: clock source
   * @rate: desired clock rate in Hz
   *
- * Returns rounded clock rate in Hz, or negative errno.
+ * Returns rounded clock rate in Hz, or 0 upon error.
   */
  long clk_round_rate(struct clk *clk, unsigned long rate);
