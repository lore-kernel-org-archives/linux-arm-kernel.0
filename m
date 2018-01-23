From: aisheng.dong@nxp.com (Dong Aisheng)
Date: Tue, 23 Jan 2018 20:24:45 +0800
Subject: [PATCH 1/1] clk: add more __must_check for bulk APIs
Message-ID: <1516710285-23683-1-git-send-email-aisheng.dong@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

we need it even when !CONFIG_HAVE_CLK because it allows
us to catch missing checking return values in the non-clk
compile configurations too. More test coverage.

Cc: Stephen Boyd <sboyd@codeaurora.org>
Suggested-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 include/linux/clk.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/linux/clk.h b/include/linux/clk.h
index 4c4ef9f..0dbd088 100644
--- a/include/linux/clk.h
+++ b/include/linux/clk.h
@@ -209,7 +209,7 @@ static inline int clk_prepare(struct clk *clk)
 	return 0;
 }
 
-static inline int clk_bulk_prepare(int num_clks, struct clk_bulk_data *clks)
+static inline int __must_check clk_bulk_prepare(int num_clks, struct clk_bulk_data *clks)
 {
 	might_sleep();
 	return 0;
@@ -603,8 +603,8 @@ static inline struct clk *clk_get(struct device *dev, const char *id)
 	return NULL;
 }
 
-static inline int clk_bulk_get(struct device *dev, int num_clks,
-			       struct clk_bulk_data *clks)
+static inline int __must_check clk_bulk_get(struct device *dev, int num_clks,
+					    struct clk_bulk_data *clks)
 {
 	return 0;
 }
@@ -614,8 +614,8 @@ static inline struct clk *devm_clk_get(struct device *dev, const char *id)
 	return NULL;
 }
 
-static inline int devm_clk_bulk_get(struct device *dev, int num_clks,
-				    struct clk_bulk_data *clks)
+static inline int __must_check devm_clk_bulk_get(struct device *dev, int num_clks,
+						 struct clk_bulk_data *clks)
 {
 	return 0;
 }
@@ -645,7 +645,7 @@ static inline int clk_enable(struct clk *clk)
 	return 0;
 }
 
-static inline int clk_bulk_enable(int num_clks, struct clk_bulk_data *clks)
+static inline int __must_check clk_bulk_enable(int num_clks, struct clk_bulk_data *clks)
 {
 	return 0;
 }
@@ -719,8 +719,8 @@ static inline void clk_disable_unprepare(struct clk *clk)
 	clk_unprepare(clk);
 }
 
-static inline int clk_bulk_prepare_enable(int num_clks,
-					  struct clk_bulk_data *clks)
+static inline int __must_check clk_bulk_prepare_enable(int num_clks,
+					struct clk_bulk_data *clks)
 {
 	int ret;
 
-- 
2.7.4
