From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 10 Jul 2015 19:37:33 +0900
Subject: [PATCH v2 2/2] drm/rockchip: Drop owner assignment from
 platform_driver
In-Reply-To: <1436524653-29132-1-git-send-email-k.kozlowski@samsung.com>
References: <1436524653-29132-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1436524653-29132-3-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

platform_driver does not need to set an owner because
platform_driver_register() will set it.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

---
Changes since v1:
1. Split owner removal from rockchip to separate patch (spotted by Mark
   Yao).
---
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
index 01b558fe3695..9a0c2911272a 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
@@ -555,7 +555,6 @@ static struct platform_driver rockchip_drm_platform_driver = {
 	.probe = rockchip_drm_platform_probe,
 	.remove = rockchip_drm_platform_remove,
 	.driver = {
-		.owner = THIS_MODULE,
 		.name = "rockchip-drm",
 		.of_match_table = rockchip_drm_dt_ids,
 		.pm = &rockchip_drm_pm_ops,
-- 
1.9.1
