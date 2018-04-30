From: jagan@amarulasolutions.com (Jagan Teki)
Date: Mon, 30 Apr 2018 17:10:47 +0530
Subject: [PATCH 10/21] drm/sun4i: Enable DesignWare HDMI for Allwinner 64-bit
 SoCs
In-Reply-To: <20180430114058.5061-1-jagan@amarulasolutions.com>
References: <20180430114058.5061-1-jagan@amarulasolutions.com>
Message-ID: <20180430114058.5061-11-jagan@amarulasolutions.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allwinner 64-bit SoC like H5/A64 has DesignWare HDMI so
enable them as default.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 drivers/gpu/drm/sun4i/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/sun4i/Kconfig b/drivers/gpu/drm/sun4i/Kconfig
index eee6bc0eaf97..60468a779a63 100644
--- a/drivers/gpu/drm/sun4i/Kconfig
+++ b/drivers/gpu/drm/sun4i/Kconfig
@@ -42,6 +42,7 @@ config DRM_SUN4I_BACKEND
 
 config DRM_SUN8I_DW_HDMI
 	tristate "Support for Allwinner version of DesignWare HDMI"
+	default ARM64 && ARCH_SUNXI
 	depends on DRM_SUN4I
 	select DRM_DW_HDMI
 	help
-- 
2.14.3
