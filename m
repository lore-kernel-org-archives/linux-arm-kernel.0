From: k.kozlowski.k@gmail.com (Krzysztof Kozlowski)
Date: Sat,  2 May 2015 00:38:40 +0900
Subject: [PATCH 3/4] video: fbdev: mxsfb: Constify platform_device_id
In-Reply-To: <1430494721-30793-1-git-send-email-k.kozlowski.k@gmail.com>
References: <1430494721-30793-1-git-send-email-k.kozlowski.k@gmail.com>
Message-ID: <1430494721-30793-3-git-send-email-k.kozlowski.k@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The platform_device_id is not modified by the driver and core uses it as
const.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
---
 drivers/video/fbdev/mxsfb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/mxsfb.c b/drivers/video/fbdev/mxsfb.c
index f8ac4a452f26..497971c82bb1 100644
--- a/drivers/video/fbdev/mxsfb.c
+++ b/drivers/video/fbdev/mxsfb.c
@@ -814,7 +814,7 @@ static void mxsfb_free_videomem(struct mxsfb_info *host)
 	free_pages_exact(fb_info->screen_base, fb_info->fix.smem_len);
 }
 
-static struct platform_device_id mxsfb_devtype[] = {
+static const struct platform_device_id mxsfb_devtype[] = {
 	{
 		.name = "imx23-fb",
 		.driver_data = MXSFB_V3,
-- 
2.1.4
