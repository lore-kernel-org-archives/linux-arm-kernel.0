From: jagan@amarulasolutions.com (Jagan Teki)
Date: Mon, 30 Apr 2018 17:10:50 +0530
Subject: [PATCH 13/21] drm/sun4i: Enable DE2 Mixer for Allwinner 64-bit SoCs
In-Reply-To: <20180430114058.5061-1-jagan@amarulasolutions.com>
References: <20180430114058.5061-1-jagan@amarulasolutions.com>
Message-ID: <20180430114058.5061-14-jagan@amarulasolutions.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allwinner 64-bit SoC like H5/A64 has DE2 Mixer so enable them
as default.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 drivers/gpu/drm/sun4i/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/Kconfig b/drivers/gpu/drm/sun4i/Kconfig
index 60468a779a63..95ae04964756 100644
--- a/drivers/gpu/drm/sun4i/Kconfig
+++ b/drivers/gpu/drm/sun4i/Kconfig
@@ -52,7 +52,7 @@ config DRM_SUN8I_DW_HDMI
 
 config DRM_SUN8I_MIXER
 	tristate "Support for Allwinner Display Engine 2.0 Mixer"
-	default MACH_SUN8I
+	default MACH_SUN8I || (ARM64 && ARCH_SUNXI)
 	help
 	  Choose this option if you have an Allwinner SoC with the
 	  Allwinner Display Engine 2.0, which has a mixer to do some
-- 
2.14.3
