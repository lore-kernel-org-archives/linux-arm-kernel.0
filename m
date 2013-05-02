From: arnd@arndb.de (Arnd Bergmann)
Date: Thu,  2 May 2013 17:16:10 +0200
Subject: [PATCH, RFC 06/22] gpu/drm: host1x: add dependency on Tegra
In-Reply-To: <1367507786-505303-1-git-send-email-arnd@arndb.de>
References: <1367507786-505303-1-git-send-email-arnd@arndb.de>
Message-ID: <1367507786-505303-7-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

While we try to make drivers platform independent, this driver currently
calls into an exported interface that is only provided on its own
platform, so we have to add the dependency.

drivers/built-in.o: In function `tegra_crtc_prepare':
 drivers/gpu/host1x/drm/dc.c:650: undefined reference to `tegra_periph_reset_deassert'
drivers/built-in.o: In function `tegra_output_hdmi_disable':
 drivers/gpu/host1x/drm/hdmi.c:840: undefined reference to `tegra_periph_reset_assert'
drivers/built-in.o: In function `tegra_output_hdmi_enable':
 drivers/gpu/host1x/drm/hdmi.c:651: undefined reference to `tegra_periph_reset_assert'
 drivers/gpu/host1x/drm/hdmi.c:653: undefined reference to `tegra_periph_reset_deassert'

Cc: Thierry Reding <thierry.reding@avionic-design.de>
Cc: Arto Merilainen <amerilainen@nvidia.com>
Cc: Terje Bergstrom <tbergstrom@nvidia.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/host1x/drm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/host1x/drm/Kconfig b/drivers/gpu/host1x/drm/Kconfig
index 69853a4..5a6a5cd 100644
--- a/drivers/gpu/host1x/drm/Kconfig
+++ b/drivers/gpu/host1x/drm/Kconfig
@@ -1,6 +1,7 @@
 config DRM_TEGRA
 	bool "NVIDIA Tegra DRM"
 	depends on DRM
+	depends on ARCH_TEGRA
 	select DRM_KMS_HELPER
 	select FB_SYS_FILLRECT
 	select FB_SYS_COPYAREA
-- 
1.8.1.2
