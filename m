From: david@lechnology.com (David Lechner)
Date: Thu,  4 Jan 2018 18:38:07 -0600
Subject: [PATCH 2/7] clk: mediatek: make use of clk_alloc_onecell_data()
In-Reply-To: <1515112695-3160-1-git-send-email-david@lechnology.com>
References: <1515112695-3160-1-git-send-email-david@lechnology.com>
Message-ID: <1515112695-3160-3-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A new function clk_alloc_onecell_data() has been added to the clk core
that performs the same function as mtk_alloc_clk_data(), so we can replace
all instances with the new function.

Signed-off-by: David Lechner <david@lechnology.com>
---
 drivers/clk/mediatek/clk-mt2701-bdp.c    |  2 +-
 drivers/clk/mediatek/clk-mt2701-eth.c    |  2 +-
 drivers/clk/mediatek/clk-mt2701-hif.c    |  2 +-
 drivers/clk/mediatek/clk-mt2701-img.c    |  2 +-
 drivers/clk/mediatek/clk-mt2701-mm.c     |  2 +-
 drivers/clk/mediatek/clk-mt2701-vdec.c   |  2 +-
 drivers/clk/mediatek/clk-mt2701.c        | 10 +++++-----
 drivers/clk/mediatek/clk-mt2712-bdp.c    |  2 +-
 drivers/clk/mediatek/clk-mt2712-img.c    |  2 +-
 drivers/clk/mediatek/clk-mt2712-jpgdec.c |  2 +-
 drivers/clk/mediatek/clk-mt2712-mfg.c    |  2 +-
 drivers/clk/mediatek/clk-mt2712-mm.c     |  2 +-
 drivers/clk/mediatek/clk-mt2712-vdec.c   |  2 +-
 drivers/clk/mediatek/clk-mt2712-venc.c   |  2 +-
 drivers/clk/mediatek/clk-mt2712.c        | 12 ++++++------
 drivers/clk/mediatek/clk-mt6797-img.c    |  2 +-
 drivers/clk/mediatek/clk-mt6797-mm.c     |  2 +-
 drivers/clk/mediatek/clk-mt6797-vdec.c   |  2 +-
 drivers/clk/mediatek/clk-mt6797-venc.c   |  2 +-
 drivers/clk/mediatek/clk-mt6797.c        |  8 ++++----
 drivers/clk/mediatek/clk-mt7622-aud.c    |  2 +-
 drivers/clk/mediatek/clk-mt7622-eth.c    |  4 ++--
 drivers/clk/mediatek/clk-mt7622-hif.c    |  4 ++--
 drivers/clk/mediatek/clk-mt7622.c        |  8 ++++----
 drivers/clk/mediatek/clk-mt8135.c        |  8 ++++----
 drivers/clk/mediatek/clk-mt8173.c        | 18 +++++++++---------
 drivers/clk/mediatek/clk-mtk.c           | 25 -------------------------
 drivers/clk/mediatek/clk-mtk.h           |  2 --
 28 files changed, 54 insertions(+), 81 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt2701-bdp.c b/drivers/clk/mediatek/clk-mt2701-bdp.c
index fe4964d..b055a92 100644
--- a/drivers/clk/mediatek/clk-mt2701-bdp.c
+++ b/drivers/clk/mediatek/clk-mt2701-bdp.c
@@ -113,7 +113,7 @@ static int clk_mt2701_bdp_probe(struct platform_device *pdev)
 	int r;
 	struct device_node *node = pdev->dev.of_node;
 
-	clk_data = mtk_alloc_clk_data(CLK_BDP_NR);
+	clk_data = clk_alloc_onecell_data(CLK_BDP_NR);
 
 	mtk_clk_register_gates(node, bdp_clks, ARRAY_SIZE(bdp_clks),
 						clk_data);
diff --git a/drivers/clk/mediatek/clk-mt2701-eth.c b/drivers/clk/mediatek/clk-mt2701-eth.c
index 9251a65..4b7570e 100644
--- a/drivers/clk/mediatek/clk-mt2701-eth.c
+++ b/drivers/clk/mediatek/clk-mt2701-eth.c
@@ -55,7 +55,7 @@ static int clk_mt2701_eth_probe(struct platform_device *pdev)
 	int r;
 	struct device_node *node = pdev->dev.of_node;
 
-	clk_data = mtk_alloc_clk_data(CLK_ETHSYS_NR);
+	clk_data = clk_alloc_onecell_data(CLK_ETHSYS_NR);
 
 	mtk_clk_register_gates(node, eth_clks, ARRAY_SIZE(eth_clks),
 						clk_data);
diff --git a/drivers/clk/mediatek/clk-mt2701-hif.c b/drivers/clk/mediatek/clk-mt2701-hif.c
index 18f3723..0f0c785 100644
--- a/drivers/clk/mediatek/clk-mt2701-hif.c
+++ b/drivers/clk/mediatek/clk-mt2701-hif.c
@@ -52,7 +52,7 @@ static int clk_mt2701_hif_probe(struct platform_device *pdev)
 	int r;
 	struct device_node *node = pdev->dev.of_node;
 
-	clk_data = mtk_alloc_clk_data(CLK_HIFSYS_NR);
+	clk_data = clk_alloc_onecell_data(CLK_HIFSYS_NR);
 
 	mtk_clk_register_gates(node, hif_clks, ARRAY_SIZE(hif_clks),
 						clk_data);
diff --git a/drivers/clk/mediatek/clk-mt2701-img.c b/drivers/clk/mediatek/clk-mt2701-img.c
index b7441c9..d66c3e4 100644
--- a/drivers/clk/mediatek/clk-mt2701-img.c
+++ b/drivers/clk/mediatek/clk-mt2701-img.c
@@ -55,7 +55,7 @@ static int clk_mt2701_img_probe(struct platform_device *pdev)
 	int r;
 	struct device_node *node = pdev->dev.of_node;
 
-	clk_data = mtk_alloc_clk_data(CLK_IMG_NR);
+	clk_data = clk_alloc_onecell_data(CLK_IMG_NR);
 
 	mtk_clk_register_gates(node, img_clks, ARRAY_SIZE(img_clks),
 						clk_data);
diff --git a/drivers/clk/mediatek/clk-mt2701-mm.c b/drivers/clk/mediatek/clk-mt2701-mm.c
index fe1f850..02e4736 100644
--- a/drivers/clk/mediatek/clk-mt2701-mm.c
+++ b/drivers/clk/mediatek/clk-mt2701-mm.c
@@ -98,7 +98,7 @@ static int clk_mt2701_mm_probe(struct platform_device *pdev)
 	int r;
 	struct device_node *node = pdev->dev.of_node;
 
-	clk_data = mtk_alloc_clk_data(CLK_MM_NR);
+	clk_data = clk_alloc_onecell_data(CLK_MM_NR);
 
 	mtk_clk_register_gates(node, mm_clks, ARRAY_SIZE(mm_clks),
 						clk_data);
diff --git a/drivers/clk/mediatek/clk-mt2701-vdec.c b/drivers/clk/mediatek/clk-mt2701-vdec.c
index d3c0fc9..f29414e 100644
--- a/drivers/clk/mediatek/clk-mt2701-vdec.c
+++ b/drivers/clk/mediatek/clk-mt2701-vdec.c
@@ -66,7 +66,7 @@ static int clk_mt2701_vdec_probe(struct platform_device *pdev)
 	int r;
 	struct device_node *node = pdev->dev.of_node;
 
-	clk_data = mtk_alloc_clk_data(CLK_VDEC_NR);
+	clk_data = clk_alloc_onecell_data(CLK_VDEC_NR);
 
 	mtk_clk_register_gates(node, vdec_clks, ARRAY_SIZE(vdec_clks),
 						clk_data);
diff --git a/drivers/clk/mediatek/clk-mt2701.c b/drivers/clk/mediatek/clk-mt2701.c
index 8e7f16f..df861a5 100644
--- a/drivers/clk/mediatek/clk-mt2701.c
+++ b/drivers/clk/mediatek/clk-mt2701.c
@@ -688,7 +688,7 @@ static int mtk_topckgen_init(struct platform_device *pdev)
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
-	clk_data = mtk_alloc_clk_data(CLK_TOP_NR);
+	clk_data = clk_alloc_onecell_data(CLK_TOP_NR);
 
 	mtk_clk_register_fixed_clks(top_fixed_clks, ARRAY_SIZE(top_fixed_clks),
 								clk_data);
@@ -755,7 +755,7 @@ static void __init mtk_infrasys_init_early(struct device_node *node)
 	int r, i;
 
 	if (!infra_clk_data) {
-		infra_clk_data = mtk_alloc_clk_data(CLK_INFRA_NR);
+		infra_clk_data = clk_alloc_onecell_data(CLK_INFRA_NR);
 
 		for (i = 0; i < CLK_INFRA_NR; i++)
 			infra_clk_data->clks[i] = ERR_PTR(-EPROBE_DEFER);
@@ -781,7 +781,7 @@ static int mtk_infrasys_init(struct platform_device *pdev)
 	struct device_node *node = pdev->dev.of_node;
 
 	if (!infra_clk_data) {
-		infra_clk_data = mtk_alloc_clk_data(CLK_INFRA_NR);
+		infra_clk_data = clk_alloc_onecell_data(CLK_INFRA_NR);
 	} else {
 		for (i = 0; i < CLK_INFRA_NR; i++) {
 			if (infra_clk_data->clks[i] == ERR_PTR(-EPROBE_DEFER))
@@ -909,7 +909,7 @@ static int mtk_pericfg_init(struct platform_device *pdev)
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
-	clk_data = mtk_alloc_clk_data(CLK_PERI_NR);
+	clk_data = clk_alloc_onecell_data(CLK_PERI_NR);
 
 	mtk_clk_register_gates(node, peri_clks, ARRAY_SIZE(peri_clks),
 						clk_data);
@@ -981,7 +981,7 @@ static int mtk_apmixedsys_init(struct platform_device *pdev)
 	struct clk_onecell_data *clk_data;
 	struct device_node *node = pdev->dev.of_node;
 
-	clk_data = mtk_alloc_clk_data(CLK_APMIXED_NR);
+	clk_data = clk_alloc_onecell_data(CLK_APMIXED_NR);
 	if (!clk_data)
 		return -ENOMEM;
 
diff --git a/drivers/clk/mediatek/clk-mt2712-bdp.c b/drivers/clk/mediatek/clk-mt2712-bdp.c
index 5fe4728..b8b46e5 100644
--- a/drivers/clk/mediatek/clk-mt2712-bdp.c
+++ b/drivers/clk/mediatek/clk-mt2712-bdp.c
@@ -72,7 +72,7 @@ static int clk_mt2712_bdp_probe(struct platform_device *pdev)
 	int r;
 	struct device_node *node = pdev->dev.of_node;
 
-	clk_data = mtk_alloc_clk_data(CLK_BDP_NR_CLK);
+	clk_data = clk_alloc_onecell_data(CLK_BDP_NR_CLK);
 
 	mtk_clk_register_gates(node, bdp_clks, ARRAY_SIZE(bdp_clks),
 			clk_data);
diff --git a/drivers/clk/mediatek/clk-mt2712-img.c b/drivers/clk/mediatek/clk-mt2712-img.c
index 139ff55..e9fbf20 100644
--- a/drivers/clk/mediatek/clk-mt2712-img.c
+++ b/drivers/clk/mediatek/clk-mt2712-img.c
@@ -50,7 +50,7 @@ static int clk_mt2712_img_probe(struct platform_device *pdev)
 	int r;
 	struct device_node *node = pdev->dev.of_node;
 
-	clk_data = mtk_alloc_clk_data(CLK_IMG_NR_CLK);
+	clk_data = clk_alloc_onecell_data(CLK_IMG_NR_CLK);
 
 	mtk_clk_register_gates(node, img_clks, ARRAY_SIZE(img_clks),
 			clk_data);
diff --git a/drivers/clk/mediatek/clk-mt2712-jpgdec.c b/drivers/clk/mediatek/clk-mt2712-jpgdec.c
index c7d4aad..86e7de4 100644
--- a/drivers/clk/mediatek/clk-mt2712-jpgdec.c
+++ b/drivers/clk/mediatek/clk-mt2712-jpgdec.c
@@ -46,7 +46,7 @@ static int clk_mt2712_jpgdec_probe(struct platform_device *pdev)
 	int r;
 	struct device_node *node = pdev->dev.of_node;
 
-	clk_data = mtk_alloc_clk_data(CLK_JPGDEC_NR_CLK);
+	clk_data = clk_alloc_onecell_data(CLK_JPGDEC_NR_CLK);
 
 	mtk_clk_register_gates(node, jpgdec_clks, ARRAY_SIZE(jpgdec_clks),
 			clk_data);
diff --git a/drivers/clk/mediatek/clk-mt2712-mfg.c b/drivers/clk/mediatek/clk-mt2712-mfg.c
index 570f72d..2d63776 100644
--- a/drivers/clk/mediatek/clk-mt2712-mfg.c
+++ b/drivers/clk/mediatek/clk-mt2712-mfg.c
@@ -45,7 +45,7 @@ static int clk_mt2712_mfg_probe(struct platform_device *pdev)
 	int r;
 	struct device_node *node = pdev->dev.of_node;
 
-	clk_data = mtk_alloc_clk_data(CLK_MFG_NR_CLK);
+	clk_data = clk_alloc_onecell_data(CLK_MFG_NR_CLK);
 
 	mtk_clk_register_gates(node, mfg_clks, ARRAY_SIZE(mfg_clks),
 			clk_data);
diff --git a/drivers/clk/mediatek/clk-mt2712-mm.c b/drivers/clk/mediatek/clk-mt2712-mm.c
index a8b4b6d..6685425 100644
--- a/drivers/clk/mediatek/clk-mt2712-mm.c
+++ b/drivers/clk/mediatek/clk-mt2712-mm.c
@@ -140,7 +140,7 @@ static int clk_mt2712_mm_probe(struct platform_device *pdev)
 	int r;
 	struct device_node *node = pdev->dev.of_node;
 
-	clk_data = mtk_alloc_clk_data(CLK_MM_NR_CLK);
+	clk_data = clk_alloc_onecell_data(CLK_MM_NR_CLK);
 
 	mtk_clk_register_gates(node, mm_clks, ARRAY_SIZE(mm_clks),
 			clk_data);
diff --git a/drivers/clk/mediatek/clk-mt2712-vdec.c b/drivers/clk/mediatek/clk-mt2712-vdec.c
index 55c64ee..c2de3ea 100644
--- a/drivers/clk/mediatek/clk-mt2712-vdec.c
+++ b/drivers/clk/mediatek/clk-mt2712-vdec.c
@@ -64,7 +64,7 @@ static int clk_mt2712_vdec_probe(struct platform_device *pdev)
 	int r;
 	struct device_node *node = pdev->dev.of_node;
 
-	clk_data = mtk_alloc_clk_data(CLK_VDEC_NR_CLK);
+	clk_data = clk_alloc_onecell_data(CLK_VDEC_NR_CLK);
 
 	mtk_clk_register_gates(node, vdec_clks, ARRAY_SIZE(vdec_clks),
 			clk_data);
diff --git a/drivers/clk/mediatek/clk-mt2712-venc.c b/drivers/clk/mediatek/clk-mt2712-venc.c
index ccbfe98..4b1a146 100644
--- a/drivers/clk/mediatek/clk-mt2712-venc.c
+++ b/drivers/clk/mediatek/clk-mt2712-venc.c
@@ -47,7 +47,7 @@ static int clk_mt2712_venc_probe(struct platform_device *pdev)
 	int r;
 	struct device_node *node = pdev->dev.of_node;
 
-	clk_data = mtk_alloc_clk_data(CLK_VENC_NR_CLK);
+	clk_data = clk_alloc_onecell_data(CLK_VENC_NR_CLK);
 
 	mtk_clk_register_gates(node, venc_clks, ARRAY_SIZE(venc_clks),
 			clk_data);
diff --git a/drivers/clk/mediatek/clk-mt2712.c b/drivers/clk/mediatek/clk-mt2712.c
index 498d137..b3e19d3 100644
--- a/drivers/clk/mediatek/clk-mt2712.c
+++ b/drivers/clk/mediatek/clk-mt2712.c
@@ -1226,7 +1226,7 @@ static int clk_mt2712_apmixed_probe(struct platform_device *pdev)
 	int r;
 	struct device_node *node = pdev->dev.of_node;
 
-	clk_data = mtk_alloc_clk_data(CLK_APMIXED_NR_CLK);
+	clk_data = clk_alloc_onecell_data(CLK_APMIXED_NR_CLK);
 
 	mtk_clk_register_plls(node, plls, ARRAY_SIZE(plls), clk_data);
 
@@ -1246,7 +1246,7 @@ static void clk_mt2712_top_init_early(struct device_node *node)
 	int r, i;
 
 	if (!top_clk_data) {
-		top_clk_data = mtk_alloc_clk_data(CLK_TOP_NR_CLK);
+		top_clk_data = clk_alloc_onecell_data(CLK_TOP_NR_CLK);
 
 		for (i = 0; i < CLK_TOP_NR_CLK; i++)
 			top_clk_data->clks[i] = ERR_PTR(-EPROBE_DEFER);
@@ -1278,7 +1278,7 @@ static int clk_mt2712_top_probe(struct platform_device *pdev)
 	}
 
 	if (!top_clk_data) {
-		top_clk_data = mtk_alloc_clk_data(CLK_TOP_NR_CLK);
+		top_clk_data = clk_alloc_onecell_data(CLK_TOP_NR_CLK);
 	} else {
 		for (i = 0; i < CLK_TOP_NR_CLK; i++) {
 			if (top_clk_data->clks[i] == ERR_PTR(-EPROBE_DEFER))
@@ -1313,7 +1313,7 @@ static int clk_mt2712_infra_probe(struct platform_device *pdev)
 	int r;
 	struct device_node *node = pdev->dev.of_node;
 
-	clk_data = mtk_alloc_clk_data(CLK_INFRA_NR_CLK);
+	clk_data = clk_alloc_onecell_data(CLK_INFRA_NR_CLK);
 
 	mtk_clk_register_gates(node, infra_clks, ARRAY_SIZE(infra_clks),
 			clk_data);
@@ -1335,7 +1335,7 @@ static int clk_mt2712_peri_probe(struct platform_device *pdev)
 	int r;
 	struct device_node *node = pdev->dev.of_node;
 
-	clk_data = mtk_alloc_clk_data(CLK_PERI_NR_CLK);
+	clk_data = clk_alloc_onecell_data(CLK_PERI_NR_CLK);
 
 	mtk_clk_register_gates(node, peri_clks, ARRAY_SIZE(peri_clks),
 			clk_data);
@@ -1365,7 +1365,7 @@ static int clk_mt2712_mcu_probe(struct platform_device *pdev)
 		return PTR_ERR(base);
 	}
 
-	clk_data = mtk_alloc_clk_data(CLK_MCU_NR_CLK);
+	clk_data = clk_alloc_onecell_data(CLK_MCU_NR_CLK);
 
 	mtk_clk_register_composites(mcu_muxes, ARRAY_SIZE(mcu_muxes), base,
 			&mt2712_clk_lock, clk_data);
diff --git a/drivers/clk/mediatek/clk-mt6797-img.c b/drivers/clk/mediatek/clk-mt6797-img.c
index 94cc480..6debc6d 100644
--- a/drivers/clk/mediatek/clk-mt6797-img.c
+++ b/drivers/clk/mediatek/clk-mt6797-img.c
@@ -51,7 +51,7 @@ static int clk_mt6797_img_probe(struct platform_device *pdev)
 	int r;
 	struct device_node *node = pdev->dev.of_node;
 
-	clk_data = mtk_alloc_clk_data(CLK_IMG_NR);
+	clk_data = clk_alloc_onecell_data(CLK_IMG_NR);
 
 	mtk_clk_register_gates(node, img_clks, ARRAY_SIZE(img_clks),
 			       clk_data);
diff --git a/drivers/clk/mediatek/clk-mt6797-mm.c b/drivers/clk/mediatek/clk-mt6797-mm.c
index c57d3ee..c32c274 100644
--- a/drivers/clk/mediatek/clk-mt6797-mm.c
+++ b/drivers/clk/mediatek/clk-mt6797-mm.c
@@ -111,7 +111,7 @@ static int clk_mt6797_mm_probe(struct platform_device *pdev)
 	int r;
 	struct device_node *node = pdev->dev.of_node;
 
-	clk_data = mtk_alloc_clk_data(CLK_MM_NR);
+	clk_data = clk_alloc_onecell_data(CLK_MM_NR);
 
 	mtk_clk_register_gates(node, mm_clks, ARRAY_SIZE(mm_clks),
 			       clk_data);
diff --git a/drivers/clk/mediatek/clk-mt6797-vdec.c b/drivers/clk/mediatek/clk-mt6797-vdec.c
index 7c402ca..66c0fe3 100644
--- a/drivers/clk/mediatek/clk-mt6797-vdec.c
+++ b/drivers/clk/mediatek/clk-mt6797-vdec.c
@@ -68,7 +68,7 @@ static int clk_mt6797_vdec_probe(struct platform_device *pdev)
 	int r;
 	struct device_node *node = pdev->dev.of_node;
 
-	clk_data = mtk_alloc_clk_data(CLK_VDEC_NR);
+	clk_data = clk_alloc_onecell_data(CLK_VDEC_NR);
 
 	mtk_clk_register_gates(node, vdec_clks, ARRAY_SIZE(vdec_clks),
 			       clk_data);
diff --git a/drivers/clk/mediatek/clk-mt6797-venc.c b/drivers/clk/mediatek/clk-mt6797-venc.c
index e73d517..1669b43 100644
--- a/drivers/clk/mediatek/clk-mt6797-venc.c
+++ b/drivers/clk/mediatek/clk-mt6797-venc.c
@@ -53,7 +53,7 @@ static int clk_mt6797_venc_probe(struct platform_device *pdev)
 	int r;
 	struct device_node *node = pdev->dev.of_node;
 
-	clk_data = mtk_alloc_clk_data(CLK_VENC_NR);
+	clk_data = clk_alloc_onecell_data(CLK_VENC_NR);
 
 	mtk_clk_register_gates(node, venc_clks, ARRAY_SIZE(venc_clks),
 			       clk_data);
diff --git a/drivers/clk/mediatek/clk-mt6797.c b/drivers/clk/mediatek/clk-mt6797.c
index 5702bc9..8441633 100644
--- a/drivers/clk/mediatek/clk-mt6797.c
+++ b/drivers/clk/mediatek/clk-mt6797.c
@@ -395,7 +395,7 @@ static int mtk_topckgen_init(struct platform_device *pdev)
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
-	clk_data = mtk_alloc_clk_data(CLK_TOP_NR);
+	clk_data = clk_alloc_onecell_data(CLK_TOP_NR);
 
 	mtk_clk_register_factors(top_fixed_divs, ARRAY_SIZE(top_fixed_divs),
 				 clk_data);
@@ -553,7 +553,7 @@ static void mtk_infrasys_init_early(struct device_node *node)
 	int r, i;
 
 	if (!infra_clk_data) {
-		infra_clk_data = mtk_alloc_clk_data(CLK_INFRA_NR);
+		infra_clk_data = clk_alloc_onecell_data(CLK_INFRA_NR);
 
 		for (i = 0; i < CLK_INFRA_NR; i++)
 			infra_clk_data->clks[i] = ERR_PTR(-EPROBE_DEFER);
@@ -577,7 +577,7 @@ static int mtk_infrasys_init(struct platform_device *pdev)
 	struct device_node *node = pdev->dev.of_node;
 
 	if (!infra_clk_data) {
-		infra_clk_data = mtk_alloc_clk_data(CLK_INFRA_NR);
+		infra_clk_data = clk_alloc_onecell_data(CLK_INFRA_NR);
 	} else {
 		for (i = 0; i < CLK_INFRA_NR; i++) {
 			if (infra_clk_data->clks[i] == ERR_PTR(-EPROBE_DEFER))
@@ -656,7 +656,7 @@ static int mtk_apmixedsys_init(struct platform_device *pdev)
 	struct clk_onecell_data *clk_data;
 	struct device_node *node = pdev->dev.of_node;
 
-	clk_data = mtk_alloc_clk_data(CLK_APMIXED_NR);
+	clk_data = clk_alloc_onecell_data(CLK_APMIXED_NR);
 	if (!clk_data)
 		return -ENOMEM;
 
diff --git a/drivers/clk/mediatek/clk-mt7622-aud.c b/drivers/clk/mediatek/clk-mt7622-aud.c
index fad7d9f..9b1170f 100644
--- a/drivers/clk/mediatek/clk-mt7622-aud.c
+++ b/drivers/clk/mediatek/clk-mt7622-aud.c
@@ -143,7 +143,7 @@ static int clk_mt7622_audiosys_init(struct platform_device *pdev)
 	struct device_node *node = pdev->dev.of_node;
 	int r;
 
-	clk_data = mtk_alloc_clk_data(CLK_AUDIO_NR_CLK);
+	clk_data = clk_alloc_onecell_data(CLK_AUDIO_NR_CLK);
 
 	mtk_clk_register_gates(node, audio_clks, ARRAY_SIZE(audio_clks),
 			       clk_data);
diff --git a/drivers/clk/mediatek/clk-mt7622-eth.c b/drivers/clk/mediatek/clk-mt7622-eth.c
index 6328127..881845c 100644
--- a/drivers/clk/mediatek/clk-mt7622-eth.c
+++ b/drivers/clk/mediatek/clk-mt7622-eth.c
@@ -79,7 +79,7 @@ static int clk_mt7622_ethsys_init(struct platform_device *pdev)
 	struct device_node *node = pdev->dev.of_node;
 	int r;
 
-	clk_data = mtk_alloc_clk_data(CLK_ETH_NR_CLK);
+	clk_data = clk_alloc_onecell_data(CLK_ETH_NR_CLK);
 
 	mtk_clk_register_gates(node, eth_clks, ARRAY_SIZE(eth_clks),
 			       clk_data);
@@ -101,7 +101,7 @@ static int clk_mt7622_sgmiisys_init(struct platform_device *pdev)
 	struct device_node *node = pdev->dev.of_node;
 	int r;
 
-	clk_data = mtk_alloc_clk_data(CLK_SGMII_NR_CLK);
+	clk_data = clk_alloc_onecell_data(CLK_SGMII_NR_CLK);
 
 	mtk_clk_register_gates(node, sgmii_clks, ARRAY_SIZE(sgmii_clks),
 			       clk_data);
diff --git a/drivers/clk/mediatek/clk-mt7622-hif.c b/drivers/clk/mediatek/clk-mt7622-hif.c
index a6e8534..5b0738b 100644
--- a/drivers/clk/mediatek/clk-mt7622-hif.c
+++ b/drivers/clk/mediatek/clk-mt7622-hif.c
@@ -90,7 +90,7 @@ static int clk_mt7622_ssusbsys_init(struct platform_device *pdev)
 	struct device_node *node = pdev->dev.of_node;
 	int r;
 
-	clk_data = mtk_alloc_clk_data(CLK_SSUSB_NR_CLK);
+	clk_data = clk_alloc_onecell_data(CLK_SSUSB_NR_CLK);
 
 	mtk_clk_register_gates(node, ssusb_clks, ARRAY_SIZE(ssusb_clks),
 			       clk_data);
@@ -112,7 +112,7 @@ static int clk_mt7622_pciesys_init(struct platform_device *pdev)
 	struct device_node *node = pdev->dev.of_node;
 	int r;
 
-	clk_data = mtk_alloc_clk_data(CLK_PCIE_NR_CLK);
+	clk_data = clk_alloc_onecell_data(CLK_PCIE_NR_CLK);
 
 	mtk_clk_register_gates(node, pcie_clks, ARRAY_SIZE(pcie_clks),
 			       clk_data);
diff --git a/drivers/clk/mediatek/clk-mt7622.c b/drivers/clk/mediatek/clk-mt7622.c
index 92f7e32..ba6290f 100644
--- a/drivers/clk/mediatek/clk-mt7622.c
+++ b/drivers/clk/mediatek/clk-mt7622.c
@@ -628,7 +628,7 @@ static int mtk_topckgen_init(struct platform_device *pdev)
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
-	clk_data = mtk_alloc_clk_data(CLK_TOP_NR_CLK);
+	clk_data = clk_alloc_onecell_data(CLK_TOP_NR_CLK);
 
 	mtk_clk_register_fixed_clks(top_fixed_clks, ARRAY_SIZE(top_fixed_clks),
 				    clk_data);
@@ -658,7 +658,7 @@ static int __init mtk_infrasys_init(struct platform_device *pdev)
 	struct clk_onecell_data *clk_data;
 	int r;
 
-	clk_data = mtk_alloc_clk_data(CLK_INFRA_NR_CLK);
+	clk_data = clk_alloc_onecell_data(CLK_INFRA_NR_CLK);
 
 	mtk_clk_register_gates(node, infra_clks, ARRAY_SIZE(infra_clks),
 			       clk_data);
@@ -681,7 +681,7 @@ static int mtk_apmixedsys_init(struct platform_device *pdev)
 	struct clk_onecell_data *clk_data;
 	struct device_node *node = pdev->dev.of_node;
 
-	clk_data = mtk_alloc_clk_data(CLK_APMIXED_NR_CLK);
+	clk_data = clk_alloc_onecell_data(CLK_APMIXED_NR_CLK);
 	if (!clk_data)
 		return -ENOMEM;
 
@@ -709,7 +709,7 @@ static int mtk_pericfg_init(struct platform_device *pdev)
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
-	clk_data = mtk_alloc_clk_data(CLK_PERI_NR_CLK);
+	clk_data = clk_alloc_onecell_data(CLK_PERI_NR_CLK);
 
 	mtk_clk_register_gates(node, peri_clks, ARRAY_SIZE(peri_clks),
 			       clk_data);
diff --git a/drivers/clk/mediatek/clk-mt8135.c b/drivers/clk/mediatek/clk-mt8135.c
index 07c21e4..9ce6e1d 100644
--- a/drivers/clk/mediatek/clk-mt8135.c
+++ b/drivers/clk/mediatek/clk-mt8135.c
@@ -533,7 +533,7 @@ static void __init mtk_topckgen_init(struct device_node *node)
 		return;
 	}
 
-	clk_data = mtk_alloc_clk_data(CLK_TOP_NR_CLK);
+	clk_data = clk_alloc_onecell_data(CLK_TOP_NR_CLK);
 
 	mtk_clk_register_factors(root_clk_alias, ARRAY_SIZE(root_clk_alias), clk_data);
 	mtk_clk_register_factors(top_divs, ARRAY_SIZE(top_divs), clk_data);
@@ -554,7 +554,7 @@ static void __init mtk_infrasys_init(struct device_node *node)
 	struct clk_onecell_data *clk_data;
 	int r;
 
-	clk_data = mtk_alloc_clk_data(CLK_INFRA_NR_CLK);
+	clk_data = clk_alloc_onecell_data(CLK_INFRA_NR_CLK);
 
 	mtk_clk_register_gates(node, infra_clks, ARRAY_SIZE(infra_clks),
 						clk_data);
@@ -582,7 +582,7 @@ static void __init mtk_pericfg_init(struct device_node *node)
 		return;
 	}
 
-	clk_data = mtk_alloc_clk_data(CLK_PERI_NR_CLK);
+	clk_data = clk_alloc_onecell_data(CLK_PERI_NR_CLK);
 
 	mtk_clk_register_gates(node, peri_gates, ARRAY_SIZE(peri_gates),
 						clk_data);
@@ -635,7 +635,7 @@ static void __init mtk_apmixedsys_init(struct device_node *node)
 {
 	struct clk_onecell_data *clk_data;
 
-	clk_data = mtk_alloc_clk_data(CLK_APMIXED_NR_CLK);
+	clk_data = clk_alloc_onecell_data(CLK_APMIXED_NR_CLK);
 	if (!clk_data)
 		return;
 
diff --git a/drivers/clk/mediatek/clk-mt8173.c b/drivers/clk/mediatek/clk-mt8173.c
index 96c292c..1d1d09c 100644
--- a/drivers/clk/mediatek/clk-mt8173.c
+++ b/drivers/clk/mediatek/clk-mt8173.c
@@ -941,7 +941,7 @@ static void __init mtk_topckgen_init(struct device_node *node)
 		return;
 	}
 
-	mt8173_top_clk_data = clk_data = mtk_alloc_clk_data(CLK_TOP_NR_CLK);
+	mt8173_top_clk_data = clk_data = clk_alloc_onecell_data(CLK_TOP_NR_CLK);
 
 	mtk_clk_register_fixed_clks(fixed_clks, ARRAY_SIZE(fixed_clks), clk_data);
 	mtk_clk_register_factors(top_divs, ARRAY_SIZE(top_divs), clk_data);
@@ -962,7 +962,7 @@ static void __init mtk_infrasys_init(struct device_node *node)
 	struct clk_onecell_data *clk_data;
 	int r;
 
-	clk_data = mtk_alloc_clk_data(CLK_INFRA_NR_CLK);
+	clk_data = clk_alloc_onecell_data(CLK_INFRA_NR_CLK);
 
 	mtk_clk_register_gates(node, infra_clks, ARRAY_SIZE(infra_clks),
 						clk_data);
@@ -992,7 +992,7 @@ static void __init mtk_pericfg_init(struct device_node *node)
 		return;
 	}
 
-	clk_data = mtk_alloc_clk_data(CLK_PERI_NR_CLK);
+	clk_data = clk_alloc_onecell_data(CLK_PERI_NR_CLK);
 
 	mtk_clk_register_gates(node, peri_gates, ARRAY_SIZE(peri_gates),
 						clk_data);
@@ -1096,7 +1096,7 @@ static void __init mtk_apmixedsys_init(struct device_node *node)
 		return;
 	}
 
-	mt8173_pll_clk_data = clk_data = mtk_alloc_clk_data(CLK_APMIXED_NR_CLK);
+	mt8173_pll_clk_data = clk_data = clk_alloc_onecell_data(CLK_APMIXED_NR_CLK);
 	if (!clk_data) {
 		iounmap(base);
 		return;
@@ -1139,7 +1139,7 @@ static void __init mtk_imgsys_init(struct device_node *node)
 	struct clk_onecell_data *clk_data;
 	int r;
 
-	clk_data = mtk_alloc_clk_data(CLK_IMG_NR_CLK);
+	clk_data = clk_alloc_onecell_data(CLK_IMG_NR_CLK);
 
 	mtk_clk_register_gates(node, img_clks, ARRAY_SIZE(img_clks),
 						clk_data);
@@ -1157,7 +1157,7 @@ static void __init mtk_mmsys_init(struct device_node *node)
 	struct clk_onecell_data *clk_data;
 	int r;
 
-	clk_data = mtk_alloc_clk_data(CLK_MM_NR_CLK);
+	clk_data = clk_alloc_onecell_data(CLK_MM_NR_CLK);
 
 	mtk_clk_register_gates(node, mm_clks, ARRAY_SIZE(mm_clks),
 						clk_data);
@@ -1174,7 +1174,7 @@ static void __init mtk_vdecsys_init(struct device_node *node)
 	struct clk_onecell_data *clk_data;
 	int r;
 
-	clk_data = mtk_alloc_clk_data(CLK_VDEC_NR_CLK);
+	clk_data = clk_alloc_onecell_data(CLK_VDEC_NR_CLK);
 
 	mtk_clk_register_gates(node, vdec_clks, ARRAY_SIZE(vdec_clks),
 						clk_data);
@@ -1191,7 +1191,7 @@ static void __init mtk_vencsys_init(struct device_node *node)
 	struct clk_onecell_data *clk_data;
 	int r;
 
-	clk_data = mtk_alloc_clk_data(CLK_VENC_NR_CLK);
+	clk_data = clk_alloc_onecell_data(CLK_VENC_NR_CLK);
 
 	mtk_clk_register_gates(node, venc_clks, ARRAY_SIZE(venc_clks),
 						clk_data);
@@ -1208,7 +1208,7 @@ static void __init mtk_vencltsys_init(struct device_node *node)
 	struct clk_onecell_data *clk_data;
 	int r;
 
-	clk_data = mtk_alloc_clk_data(CLK_VENCLT_NR_CLK);
+	clk_data = clk_alloc_onecell_data(CLK_VENCLT_NR_CLK);
 
 	mtk_clk_register_gates(node, venclt_clks, ARRAY_SIZE(venclt_clks),
 						clk_data);
diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index 9c0ae42..64cf1ef 100644
--- a/drivers/clk/mediatek/clk-mtk.c
+++ b/drivers/clk/mediatek/clk-mtk.c
@@ -24,31 +24,6 @@
 #include "clk-mtk.h"
 #include "clk-gate.h"
 
-struct clk_onecell_data *mtk_alloc_clk_data(unsigned int clk_num)
-{
-	int i;
-	struct clk_onecell_data *clk_data;
-
-	clk_data = kzalloc(sizeof(*clk_data), GFP_KERNEL);
-	if (!clk_data)
-		return NULL;
-
-	clk_data->clks = kcalloc(clk_num, sizeof(*clk_data->clks), GFP_KERNEL);
-	if (!clk_data->clks)
-		goto err_out;
-
-	clk_data->clk_num = clk_num;
-
-	for (i = 0; i < clk_num; i++)
-		clk_data->clks[i] = ERR_PTR(-ENOENT);
-
-	return clk_data;
-err_out:
-	kfree(clk_data);
-
-	return NULL;
-}
-
 void mtk_clk_register_fixed_clks(const struct mtk_fixed_clk *clks,
 		int num, struct clk_onecell_data *clk_data)
 {
diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mtk.h
index bf8006d..651a9e9 100644
--- a/drivers/clk/mediatek/clk-mtk.h
+++ b/drivers/clk/mediatek/clk-mtk.h
@@ -190,8 +190,6 @@ void mtk_clk_register_dividers(const struct mtk_clk_divider *mcds,
 			int num, void __iomem *base, spinlock_t *lock,
 				struct clk_onecell_data *clk_data);
 
-struct clk_onecell_data *mtk_alloc_clk_data(unsigned int clk_num);
-
 #define HAVE_RST_BAR	BIT(0)
 #define PLL_AO		BIT(1)
 
-- 
2.7.4
