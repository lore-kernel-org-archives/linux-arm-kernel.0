From: pawel.mikolaj.chmiel@gmail.com (=?UTF-8?q?Pawe=C5=82=20Chmiel?=)
Date: Sat, 21 Apr 2018 19:26:10 +0200
Subject: [PATCH v2 1/2] drm/exynos: fimd: Add support for S5PV210 FIMD variant
In-Reply-To: <1524331571-7420-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
References: <1524331571-7420-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
Message-ID: <1524331571-7420-2-git-send-email-pawel.mikolaj.chmiel@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Tomasz Figa <tomasz.figa@gmail.com>

This patch adds support for FIMD variant found on S5PV210 SoC.
Except CLKSEL bit availability, it is identical to Exynos4210.

Tested-by: Pawe? Chmiel <pawel.mikolaj.chmiel@gmail.com>
Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
Signed-off-by: Pawe? Chmiel <pawel.mikolaj.chmiel@gmail.com>
---

Changes from v1:
  - Added missing signed-off-by
---
 drivers/gpu/drm/exynos/exynos_drm_fimd.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_fimd.c b/drivers/gpu/drm/exynos/exynos_drm_fimd.c
index d42ae2bc3e56..01b1570d0c3a 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_fimd.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_fimd.c
@@ -121,6 +121,12 @@ static struct fimd_driver_data s3c64xx_fimd_driver_data = {
 	.has_limited_fmt = 1,
 };
 
+static struct fimd_driver_data s5pv210_fimd_driver_data = {
+	.timing_base = 0x0,
+	.has_shadowcon = 1,
+	.has_clksel = 1,
+};
+
 static struct fimd_driver_data exynos3_fimd_driver_data = {
 	.timing_base = 0x20000,
 	.lcdblk_offset = 0x210,
@@ -193,6 +199,8 @@ struct fimd_context {
 static const struct of_device_id fimd_driver_dt_match[] = {
 	{ .compatible = "samsung,s3c6400-fimd",
 	  .data = &s3c64xx_fimd_driver_data },
+	{ .compatible = "samsung,s5pv210-fimd",
+	  .data = &s5pv210_fimd_driver_data },
 	{ .compatible = "samsung,exynos3250-fimd",
 	  .data = &exynos3_fimd_driver_data },
 	{ .compatible = "samsung,exynos4210-fimd",
-- 
2.7.4
