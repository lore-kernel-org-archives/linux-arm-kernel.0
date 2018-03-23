From: ryder.lee@mediatek.com (Ryder Lee)
Date: Fri, 23 Mar 2018 11:44:13 +0800
Subject: [PATCH] [media] vcodec: fix error return value from
 mtk_jpeg_clk_init()
Message-ID: <f9295ecafa4c845ef5d9414fca47b2dc0fc6640d.1521776018.git.ryder.lee@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The error return value should be fixed as it may return EPROBE_DEFER.

Cc: Rick Chang <rick.chang@mediatek.com>
Cc: Bin Liu <bin.liu@mediatek.com>
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c b/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c
index 226f908..af17aaa 100644
--- a/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c
+++ b/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c
@@ -1081,11 +1081,11 @@ static int mtk_jpeg_clk_init(struct mtk_jpeg_dev *jpeg)
 
 	jpeg->clk_jdec = devm_clk_get(jpeg->dev, "jpgdec");
 	if (IS_ERR(jpeg->clk_jdec))
-		return -EINVAL;
+		return PTR_ERR(jpeg->clk_jdec);
 
 	jpeg->clk_jdec_smi = devm_clk_get(jpeg->dev, "jpgdec-smi");
 	if (IS_ERR(jpeg->clk_jdec_smi))
-		return -EINVAL;
+		return PTR_ERR(jpeg->clk_jdec_smi);
 
 	return 0;
 }
-- 
1.9.1
