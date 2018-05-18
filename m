From: jagan@amarulasolutions.com (Jagan Teki)
Date: Fri, 18 May 2018 15:15:28 +0530
Subject: [PATCH v2 18/26] drm/sun4i: Enable DesignWare HDMI for SUN8I and
 SUN50I
In-Reply-To: <20180518094536.17201-1-jagan@amarulasolutions.com>
References: <20180518094536.17201-1-jagan@amarulasolutions.com>
Message-ID: <20180518094536.17201-19-jagan@amarulasolutions.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allwinner SoC like SUN8I and SUN50I are now using DesignWare HDMI
so enable them as default.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v2:
- Enable for SUN8I

 drivers/gpu/drm/sun4i/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/sun4i/Kconfig b/drivers/gpu/drm/sun4i/Kconfig
index a84120025197..c10617c1f84b 100644
--- a/drivers/gpu/drm/sun4i/Kconfig
+++ b/drivers/gpu/drm/sun4i/Kconfig
@@ -52,6 +52,7 @@ config DRM_SUN6I_DSI
 
 config DRM_SUN8I_DW_HDMI
 	tristate "Support for Allwinner version of DesignWare HDMI"
+	default MACH_SUN8I || (ARM64 && ARCH_SUNXI)
 	depends on DRM_SUN4I
 	select DRM_DW_HDMI
 	help
-- 
2.14.3
