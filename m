From: yuehaibing@huawei.com (YueHaibing)
Date: Wed, 7 Nov 2018 02:34:23 +0000
Subject: [PATCH -next] drm/sun4i: hdmi: Use PTR_ERR_OR_ZERO in
 sun4i_tmds_create()
Message-ID: <1541558063-100341-1-git-send-email-yuehaibing@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use PTR_ERR_OR_ZERO rather than if(IS_ERR(...)) + PTR_ERR

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/gpu/drm/sun4i/sun4i_hdmi_tmds_clk.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_hdmi_tmds_clk.c b/drivers/gpu/drm/sun4i/sun4i_hdmi_tmds_clk.c
index fb985ba..3d5ee6f 100644
--- a/drivers/gpu/drm/sun4i/sun4i_hdmi_tmds_clk.c
+++ b/drivers/gpu/drm/sun4i/sun4i_hdmi_tmds_clk.c
@@ -232,8 +232,5 @@ int sun4i_tmds_create(struct sun4i_hdmi *hdmi)
 	tmds->div_offset = hdmi->variant->tmds_clk_div_offset;
 
 	hdmi->tmds_clk = devm_clk_register(hdmi->dev, &tmds->hw);
-	if (IS_ERR(hdmi->tmds_clk))
-		return PTR_ERR(hdmi->tmds_clk);
-
-	return 0;
+	return PTR_ERR_OR_ZERO(hdmi->tmds_clk);
 }
