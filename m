From: jernej.skrabec@siol.net (Jernej Skrabec)
Date: Thu,  1 Mar 2018 22:34:39 +0100
Subject: [PATCH v3 13/16] drm/sun4i: Allow building on arm64
In-Reply-To: <20180301213442.16677-1-jernej.skrabec@siol.net>
References: <20180301213442.16677-1-jernej.skrabec@siol.net>
Message-ID: <20180301213442.16677-14-jernej.skrabec@siol.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

64-bit ARM SoCs from Allwinner have DE2/TCON/HDMI periphery which
is compatible to 32-bit SoCs, so allow building DRM driver for
arm64 architecture.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/sun4i/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/Kconfig b/drivers/gpu/drm/sun4i/Kconfig
index 7327da3bc94f..eee6bc0eaf97 100644
--- a/drivers/gpu/drm/sun4i/Kconfig
+++ b/drivers/gpu/drm/sun4i/Kconfig
@@ -1,6 +1,6 @@
 config DRM_SUN4I
 	tristate "DRM Support for Allwinner A10 Display Engine"
-	depends on DRM && ARM && COMMON_CLK
+	depends on DRM && (ARM || ARM64) && COMMON_CLK
 	depends on ARCH_SUNXI || COMPILE_TEST
 	select DRM_GEM_CMA_HELPER
 	select DRM_KMS_HELPER
-- 
2.16.2
