From: jagan@amarulasolutions.com (Jagan Teki)
Date: Wed, 18 Jul 2018 16:24:51 +0530
Subject: [PATCH v3 11/18] drm/sun4i: Enable DesignWare HDMI for SUN50I
In-Reply-To: <20180718105458.22304-1-jagan@amarulasolutions.com>
References: <20180718105458.22304-1-jagan@amarulasolutions.com>
Message-ID: <20180718105458.22304-12-jagan@amarulasolutions.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allwinner SUN50I are now using DesignWare HDMI so enable
them as default. This can build DRM_SUN8I_DW_HDMI as module
since DRM in arm64 has module.

Making this as defult to SUN8I, may cause an issue while
loading since arm32 DRM built as static.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v3:
- skip SUN8I enablement, since it built statically for arm32
Changes for v2:
- Enable for SUN8I

 drivers/gpu/drm/sun4i/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/sun4i/Kconfig b/drivers/gpu/drm/sun4i/Kconfig
index cfa8b96273fb..5d0c450db148 100644
--- a/drivers/gpu/drm/sun4i/Kconfig
+++ b/drivers/gpu/drm/sun4i/Kconfig
@@ -52,6 +52,7 @@ config DRM_SUN6I_DSI
 
 config DRM_SUN8I_DW_HDMI
 	tristate "Support for Allwinner version of DesignWare HDMI"
+	default ARM64 && ARCH_SUNXI
 	depends on DRM_SUN4I
 	select DRM_DW_HDMI
 	help
-- 
2.17.1
