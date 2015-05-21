From: jamesjj.liao@mediatek.com (James Liao)
Date: Thu, 21 May 2015 15:12:52 +0800
Subject: [PATCH 1/5] clk: mediatek: Fix apmixedsys clock registration
In-Reply-To: <1432192376-6712-1-git-send-email-jamesjj.liao@mediatek.com>
References: <1432192376-6712-1-git-send-email-jamesjj.liao@mediatek.com>
Message-ID: <1432192376-6712-2-git-send-email-jamesjj.liao@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The size of clk_data should be the same as CLK_APMIXED_NR_CLK
instead of ARRAY_SIZE(plls). CLK_APMIXED_* is numbered from 1, so
CLK_APMIXED_NR_CLK will be greater than ARRAY_SIZE(plls).

Signed-off-by: James Liao <jamesjj.liao@mediatek.com>
---
 drivers/clk/mediatek/clk-mt8135.c | 2 +-
 drivers/clk/mediatek/clk-mt8173.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8135.c b/drivers/clk/mediatek/clk-mt8135.c
index a63435b..08b4b84 100644
--- a/drivers/clk/mediatek/clk-mt8135.c
+++ b/drivers/clk/mediatek/clk-mt8135.c
@@ -634,7 +634,7 @@ static void __init mtk_apmixedsys_init(struct device_node *node)
 {
 	struct clk_onecell_data *clk_data;
 
-	clk_data = mtk_alloc_clk_data(ARRAY_SIZE(plls));
+	clk_data = mtk_alloc_clk_data(CLK_APMIXED_NR_CLK);
 	if (!clk_data)
 		return;
 
diff --git a/drivers/clk/mediatek/clk-mt8173.c b/drivers/clk/mediatek/clk-mt8173.c
index 357b080..4b9e04c 100644
--- a/drivers/clk/mediatek/clk-mt8173.c
+++ b/drivers/clk/mediatek/clk-mt8173.c
@@ -818,7 +818,7 @@ static void __init mtk_apmixedsys_init(struct device_node *node)
 {
 	struct clk_onecell_data *clk_data;
 
-	clk_data = mtk_alloc_clk_data(ARRAY_SIZE(plls));
+	clk_data = mtk_alloc_clk_data(CLK_APMIXED_NR_CLK);
 	if (!clk_data)
 		return;
 
-- 
1.8.1.1.dirty
