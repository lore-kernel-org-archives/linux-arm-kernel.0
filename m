From: stefan@agner.ch (Stefan Agner)
Date: Sun, 17 Jun 2018 10:55:29 +0200
Subject: [PATCH] drm/exynos: ipp: use correct enum type
Message-ID: <20180617085533.13867-1-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The limit_id_fallback array uses enum drm_ipp_size_id to index its
content. The content itself is of type enum drm_exynos_ipp_limit_type.

Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 drivers/gpu/drm/exynos/exynos_drm_ipp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_ipp.c b/drivers/gpu/drm/exynos/exynos_drm_ipp.c
index 26374e58c557..04702e974e81 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_ipp.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_ipp.c
@@ -428,7 +428,7 @@ enum drm_ipp_size_id {
 	IPP_LIMIT_BUFFER, IPP_LIMIT_AREA, IPP_LIMIT_ROTATED, IPP_LIMIT_MAX
 };
 
-static const enum drm_ipp_size_id limit_id_fallback[IPP_LIMIT_MAX][4] = {
+static const enum drm_exynos_ipp_limit_type limit_id_fallback[IPP_LIMIT_MAX][4] = {
 	[IPP_LIMIT_BUFFER]  = { DRM_EXYNOS_IPP_LIMIT_SIZE_BUFFER },
 	[IPP_LIMIT_AREA]    = { DRM_EXYNOS_IPP_LIMIT_SIZE_AREA,
 				DRM_EXYNOS_IPP_LIMIT_SIZE_BUFFER },
-- 
2.17.1
