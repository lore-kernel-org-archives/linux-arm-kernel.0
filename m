From: himanshujha199640@gmail.com (Himanshu Jha)
Date: Tue, 29 Aug 2017 19:35:07 +0530
Subject: [PATCH] drm/sun4i:  Use PTR_ERR_OR_ZERO
Message-ID: <1504015507-18259-1-git-send-email-himanshujha199640@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use PTR_ERR_OR_ZERO rather than if(IS_ERR(...)) + PTR_ERR

Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>
---
 drivers/gpu/drm/sun4i/sun4i_dotclock.c      | 5 +----
 drivers/gpu/drm/sun4i/sun4i_hdmi_ddc_clk.c  | 5 +----
 drivers/gpu/drm/sun4i/sun4i_hdmi_tmds_clk.c | 5 +----
 3 files changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_dotclock.c b/drivers/gpu/drm/sun4i/sun4i_dotclock.c
index d401156..35929b3 100644
--- a/drivers/gpu/drm/sun4i/sun4i_dotclock.c
+++ b/drivers/gpu/drm/sun4i/sun4i_dotclock.c
@@ -178,10 +178,7 @@ int sun4i_dclk_create(struct device *dev, struct sun4i_tcon *tcon)
 	dclk->hw.init = &init;
 
 	tcon->dclk = clk_register(dev, &dclk->hw);
-	if (IS_ERR(tcon->dclk))
-		return PTR_ERR(tcon->dclk);
-
-	return 0;
+	return PTR_ERR_OR_ZERO(tcon->dclk);
 }
 EXPORT_SYMBOL(sun4i_dclk_create);
 
diff --git a/drivers/gpu/drm/sun4i/sun4i_hdmi_ddc_clk.c b/drivers/gpu/drm/sun4i/sun4i_hdmi_ddc_clk.c
index 4692e8c..882c80a 100644
--- a/drivers/gpu/drm/sun4i/sun4i_hdmi_ddc_clk.c
+++ b/drivers/gpu/drm/sun4i/sun4i_hdmi_ddc_clk.c
@@ -120,8 +120,5 @@ int sun4i_ddc_create(struct sun4i_hdmi *hdmi, struct clk *parent)
 	ddc->hw.init = &init;
 
 	hdmi->ddc_clk = devm_clk_register(hdmi->dev, &ddc->hw);
-	if (IS_ERR(hdmi->ddc_clk))
-		return PTR_ERR(hdmi->ddc_clk);
-
-	return 0;
+	return PTR_ERR_OR_ZERO(hdmi->ddc_clk);
 }
diff --git a/drivers/gpu/drm/sun4i/sun4i_hdmi_tmds_clk.c b/drivers/gpu/drm/sun4i/sun4i_hdmi_tmds_clk.c
index 5cf2527..44aa870 100644
--- a/drivers/gpu/drm/sun4i/sun4i_hdmi_tmds_clk.c
+++ b/drivers/gpu/drm/sun4i/sun4i_hdmi_tmds_clk.c
@@ -218,8 +218,5 @@ int sun4i_tmds_create(struct sun4i_hdmi *hdmi)
 	tmds->hw.init = &init;
 
 	hdmi->tmds_clk = devm_clk_register(hdmi->dev, &tmds->hw);
-	if (IS_ERR(hdmi->tmds_clk))
-		return PTR_ERR(hdmi->tmds_clk);
-
-	return 0;
+	return PTR_ERR_OR_ZERO(hdmi->tmds_clk);
 }
-- 
2.7.4
