From: weiyj_lk@163.com (weiyj_lk at 163.com)
Date: Tue, 12 Jul 2016 11:02:59 +0000
Subject: [PATCH -next] [media] mtk-vcodec: remove redundant dev_err call in
 mtk_vcodec_probe()
Message-ID: <1468321379-16133-1-git-send-email-weiyj_lk@163.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

There is a error message within devm_ioremap_resource
already, so remove the dev_err call to avoid redundant
error message.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_drv.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_drv.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_drv.c
index 9c10cc2..b33a931 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_drv.c
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_drv.c
@@ -279,8 +279,6 @@ static int mtk_vcodec_probe(struct platform_device *pdev)
 		}
 		dev->reg_base[i] = devm_ioremap_resource(&pdev->dev, res);
 		if (IS_ERR((__force void *)dev->reg_base[i])) {
-			dev_err(&pdev->dev,
-				"devm_ioremap_resource %d failed.", i);
 			ret = PTR_ERR((__force void *)dev->reg_base[i]);
 			goto err_res;
 		}
