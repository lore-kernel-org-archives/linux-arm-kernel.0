From: linux@prisktech.co.nz (Tony Prisk)
Date: Wed, 19 Dec 2012 06:34:05 +1300
Subject: [PATCH RESEND 3/6] clk: exynos: Fix incorrect usage of IS_ERR_OR_NULL
In-Reply-To: <1355852048-23188-1-git-send-email-linux@prisktech.co.nz>
References: <1355852048-23188-1-git-send-email-linux@prisktech.co.nz>
Message-ID: <1355852048-23188-4-git-send-email-linux@prisktech.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Resend to include mailing lists.

Replace IS_ERR_OR_NULL with IS_ERR on clk_get results.

Signed-off-by: Tony Prisk <linux@prisktech.co.nz>
CC: Inki Dae <inki.dae@samsung.com>
CC: Joonyoung Shim <jy0922.shim@samsung.com>
CC: Seung-Woo Kim <sw0312.kim@samsung.com>
CC: Kyungmin Park <kyungmin.park@samsung.com>
CC: dri-devel at lists.freedesktop.org
---
 drivers/gpu/drm/exynos/exynos_hdmi.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_hdmi.c b/drivers/gpu/drm/exynos/exynos_hdmi.c
index 2c115f8..557ef2f 100644
--- a/drivers/gpu/drm/exynos/exynos_hdmi.c
+++ b/drivers/gpu/drm/exynos/exynos_hdmi.c
@@ -2167,27 +2167,27 @@ static int __devinit hdmi_resources_init(struct hdmi_context *hdata)
 
 	/* get clocks, power */
 	res->hdmi = clk_get(dev, "hdmi");
-	if (IS_ERR_OR_NULL(res->hdmi)) {
+	if (IS_ERR(res->hdmi)) {
 		DRM_ERROR("failed to get clock 'hdmi'\n");
 		goto fail;
 	}
 	res->sclk_hdmi = clk_get(dev, "sclk_hdmi");
-	if (IS_ERR_OR_NULL(res->sclk_hdmi)) {
+	if (IS_ERR(res->sclk_hdmi)) {
 		DRM_ERROR("failed to get clock 'sclk_hdmi'\n");
 		goto fail;
 	}
 	res->sclk_pixel = clk_get(dev, "sclk_pixel");
-	if (IS_ERR_OR_NULL(res->sclk_pixel)) {
+	if (IS_ERR(res->sclk_pixel)) {
 		DRM_ERROR("failed to get clock 'sclk_pixel'\n");
 		goto fail;
 	}
 	res->sclk_hdmiphy = clk_get(dev, "sclk_hdmiphy");
-	if (IS_ERR_OR_NULL(res->sclk_hdmiphy)) {
+	if (IS_ERR(res->sclk_hdmiphy)) {
 		DRM_ERROR("failed to get clock 'sclk_hdmiphy'\n");
 		goto fail;
 	}
 	res->hdmiphy = clk_get(dev, "hdmiphy");
-	if (IS_ERR_OR_NULL(res->hdmiphy)) {
+	if (IS_ERR(res->hdmiphy)) {
 		DRM_ERROR("failed to get clock 'hdmiphy'\n");
 		goto fail;
 	}
-- 
1.7.9.5
