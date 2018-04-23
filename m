From: matthias.bgg@kernel.org (matthias.bgg at kernel.org)
Date: Mon, 23 Apr 2018 18:13:55 +0200
Subject: [v2 06/10] mfd: mtk-mmsys: Add mt8173 nodes
In-Reply-To: <cover.1524497268.git.mbrugger@suse.com>
References: <cover.1524497268.git.mbrugger@suse.com>
Message-ID: <ce7c173efe9929712af11ea38be7f3a4d515879b.1524497268.git.mbrugger@suse.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Matthias Brugger <mbrugger@suse.com>

Add devices for the mt8173 SoC.

Signed-off-by: Matthias Brugger <mbrugger@suse.com>
Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/mfd/mtk-mmsys.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/mfd/mtk-mmsys.c b/drivers/mfd/mtk-mmsys.c
index c802343fb1c6..5585a561a02f 100644
--- a/drivers/mfd/mtk-mmsys.c
+++ b/drivers/mfd/mtk-mmsys.c
@@ -19,6 +19,7 @@
 
 enum {
 	MMSYS_MT2701 = 1,
+	MMSYS_MT8173,
 };
 
 static const struct mfd_cell mmsys_mt2701_devs[] = {
@@ -26,6 +27,12 @@ static const struct mfd_cell mmsys_mt2701_devs[] = {
 	{ .name = "drm-mt2701-mm", },
 };
 
+static const struct mfd_cell mmsys_mt8173_devs[] = {
+	{ .name = "clk-mt8173-mm", },
+	{ .name = "drm-mt8173-mm", },
+};
+
+
 static int mmsys_probe(struct platform_device *pdev)
 {
 	const struct mfd_cell *mmsys_cells;
@@ -44,6 +51,10 @@ static int mmsys_probe(struct platform_device *pdev)
 		mmsys_cells = mmsys_mt2701_devs;
 		nr_cells = ARRAY_SIZE(mmsys_mt2701_devs);
 		break;
+	case MMSYS_MT8173:
+		mmsys_cells = mmsys_mt8173_devs;
+		nr_cells = ARRAY_SIZE(mmsys_mt8173_devs);
+		break;
 	default:
 		return -ENODEV;
 	}
@@ -62,6 +73,9 @@ static const struct of_device_id of_match_mmsys[] = {
 	{ .compatible = "mediatek,mt2701-mmsys",
 	  .data = (void *) MMSYS_MT2701,
 	},
+	{ .compatible = "mediatek,mt8173-mmsys",
+	  .data = (void *) MMSYS_MT8173,
+	},
 	{ /* sentinel */ },
 };
 
-- 
2.16.3
