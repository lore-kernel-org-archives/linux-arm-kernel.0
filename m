From: wsa-dev@sang-engineering.com (Wolfram Sang)
Date: Tue,  9 Aug 2016 13:30:28 +0200
Subject: [PATCH 2/5] gpu: drm: mediatek: mtk_hdmi_ddc: don't print error when
 adding adapter fails
In-Reply-To: <1470742232-12559-1-git-send-email-wsa-dev@sang-engineering.com>
References: <1470742232-12559-1-git-send-email-wsa-dev@sang-engineering.com>
Message-ID: <1470742232-12559-3-git-send-email-wsa-dev@sang-engineering.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The core will do this for us now.

Signed-off-by: Wolfram Sang <wsa-dev@sang-engineering.com>
---
 drivers/gpu/drm/mediatek/mtk_hdmi_ddc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi_ddc.c b/drivers/gpu/drm/mediatek/mtk_hdmi_ddc.c
index 33c9e1bdb114b8..ca4caf924deb81 100644
--- a/drivers/gpu/drm/mediatek/mtk_hdmi_ddc.c
+++ b/drivers/gpu/drm/mediatek/mtk_hdmi_ddc.c
@@ -310,10 +310,8 @@ static int mtk_hdmi_ddc_probe(struct platform_device *pdev)
 	ddc->adap.dev.parent = &pdev->dev;
 
 	ret = i2c_add_adapter(&ddc->adap);
-	if (ret < 0) {
-		dev_err(dev, "failed to add bus to i2c core\n");
+	if (ret < 0)
 		goto err_clk_disable;
-	}
 
 	platform_set_drvdata(pdev, ddc);
 
-- 
2.8.1
