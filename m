From: weiyongjun1@huawei.com (Wei Yongjun)
Date: Wed, 11 Jul 2018 13:22:47 +0000
Subject: [PATCH -next] drm/sun4i: DW HDMI: Make symbol
 sun8i_dw_hdmi_pltfm_driver static
Message-ID: <1531315367-190647-1-git-send-email-weiyongjun1@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fixes the following sparse warning:

drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c:228:24: warning:
 symbol 'sun8i_dw_hdmi_pltfm_driver' was not declared. Should it be static?

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
index 3459b9e..281c42a 100644
--- a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
+++ b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
@@ -225,7 +225,7 @@ static int sun8i_dw_hdmi_remove(struct platform_device *pdev)
 };
 MODULE_DEVICE_TABLE(of, sun8i_dw_hdmi_dt_ids);
 
-struct platform_driver sun8i_dw_hdmi_pltfm_driver = {
+static struct platform_driver sun8i_dw_hdmi_pltfm_driver = {
 	.probe  = sun8i_dw_hdmi_probe,
 	.remove = sun8i_dw_hdmi_remove,
 	.driver = {
