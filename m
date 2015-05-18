From: jcliang@chromium.org (Ricky Liang)
Date: Mon, 18 May 2015 11:41:49 +0800
Subject: [PATCH v2] clk: mediatek: Initialize clk_init_data
Message-ID: <1431920513-1491-1-git-send-email-jcliang@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The variable init (struct clk_init_data) is allocated on the stack.
We weren't initializing the .flags field, so it contains random junk,
which can cause all kinds of interesting issues when the flags are
parsed by clk_register.

Signed-off-by: Ricky Liang <jcliang@chromium.org>
---
 drivers/clk/mediatek/clk-pll.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/mediatek/clk-pll.c b/drivers/clk/mediatek/clk-pll.c
index 66154ca..44409e9 100644
--- a/drivers/clk/mediatek/clk-pll.c
+++ b/drivers/clk/mediatek/clk-pll.c
@@ -268,7 +268,7 @@ static struct clk *mtk_clk_register_pll(const struct mtk_pll_data *data,
 		void __iomem *base)
 {
 	struct mtk_clk_pll *pll;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 	struct clk *clk;
 	const char *parent_name = "clk26m";
 
-- 
2.1.2
