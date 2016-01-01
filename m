From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 01 Jan 2016 15:38:53 +0100
Subject: [PATCH 2/3] drm: arm-hdlcd: remove COMMON_CLK_SCPI select
In-Reply-To: <4194408.X82ccDjh5X@wuerfel>
References: <4194408.X82ccDjh5X@wuerfel>
Message-ID: <3381082.HCMeGm07UJ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The hdlcd driver has no build-time dependency on the SCPI clock
and the bogus 'select' causes a warning when SCPI is disabled:

warning: (DRM_HDLCD) selects COMMON_CLK_SCPI which has unmet direct dependencies (COMMON_CLK && (ARM_SCPI_PROTOCOL || COMPILE_TEST))

This removes the select statement.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
Found two more bugs in the same driver, so this is now a patch series

diff --git a/drivers/gpu/drm/arm/Kconfig b/drivers/gpu/drm/arm/Kconfig
index 2f4d3b7fb871..81ea7802ca50 100644
--- a/drivers/gpu/drm/arm/Kconfig
+++ b/drivers/gpu/drm/arm/Kconfig
@@ -9,7 +9,6 @@ config DRM_HDLCD
 	tristate "ARM HDLCD"
 	depends on DRM_ARM
 	depends on COMMON_CLK
-	select COMMON_CLK_SCPI
 	select DRM_KMS_CMA_HELPER
 	select DRM_GEM_CMA_HELPER
 	help
