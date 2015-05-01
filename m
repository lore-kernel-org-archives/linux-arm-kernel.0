From: k.kozlowski.k@gmail.com (Krzysztof Kozlowski)
Date: Sat,  2 May 2015 00:51:03 +0900
Subject: [PATCH 4/4] media: platform: sp5: Constify platform_device_id
In-Reply-To: <1430495463-31633-1-git-send-email-k.kozlowski.k@gmail.com>
References: <1430495463-31633-1-git-send-email-k.kozlowski.k@gmail.com>
Message-ID: <1430495463-31633-4-git-send-email-k.kozlowski.k@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The platform_device_id is not modified by the driver and core uses it as
const.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
---
 drivers/media/platform/s5p-g2d/g2d.c     | 2 +-
 drivers/media/platform/s5p-mfc/s5p_mfc.c | 2 +-
 drivers/media/platform/s5p-tv/hdmi_drv.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/s5p-g2d/g2d.c b/drivers/media/platform/s5p-g2d/g2d.c
index ec3e1248923d..421a7c3b595b 100644
--- a/drivers/media/platform/s5p-g2d/g2d.c
+++ b/drivers/media/platform/s5p-g2d/g2d.c
@@ -787,7 +787,7 @@ static const struct of_device_id exynos_g2d_match[] = {
 };
 MODULE_DEVICE_TABLE(of, exynos_g2d_match);
 
-static struct platform_device_id g2d_driver_ids[] = {
+static const struct platform_device_id g2d_driver_ids[] = {
 	{
 		.name = "s5p-g2d",
 		.driver_data = (unsigned long)&g2d_drvdata_v3x,
diff --git a/drivers/media/platform/s5p-mfc/s5p_mfc.c b/drivers/media/platform/s5p-mfc/s5p_mfc.c
index 8333fbc2fe96..fa878cb04004 100644
--- a/drivers/media/platform/s5p-mfc/s5p_mfc.c
+++ b/drivers/media/platform/s5p-mfc/s5p_mfc.c
@@ -1463,7 +1463,7 @@ static struct s5p_mfc_variant mfc_drvdata_v8 = {
 	.fw_name[0]     = "s5p-mfc-v8.fw",
 };
 
-static struct platform_device_id mfc_driver_ids[] = {
+static const struct platform_device_id mfc_driver_ids[] = {
 	{
 		.name = "s5p-mfc",
 		.driver_data = (unsigned long)&mfc_drvdata_v5,
diff --git a/drivers/media/platform/s5p-tv/hdmi_drv.c b/drivers/media/platform/s5p-tv/hdmi_drv.c
index 0e74aabf5f9a..e8c069de6238 100644
--- a/drivers/media/platform/s5p-tv/hdmi_drv.c
+++ b/drivers/media/platform/s5p-tv/hdmi_drv.c
@@ -96,7 +96,7 @@ struct hdmi_device {
 	struct hdmi_resources res;
 };
 
-static struct platform_device_id hdmi_driver_types[] = {
+static const struct platform_device_id hdmi_driver_types[] = {
 	{
 		.name		= "s5pv210-hdmi",
 	}, {
-- 
2.1.4
