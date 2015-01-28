From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 28 Jan 2015 14:48:09 +0100
Subject: [PATCH] drm: msm: add missing dependencies on OF and COMMON_CLK
In-Reply-To: <1422452889-415782-1-git-send-email-arnd@arndb.de>
References: <1422452889-415782-1-git-send-email-arnd@arndb.de>
Message-ID: <1422452889-415782-6-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The msm gpu drivers depend on both the DT mechanism and the
common clk handling code, if they are not enabled, we get
a number of build errors:

In file included from drivers/gpu/drm/msm/hdmi/hdmi.h:27:0,
                 from drivers/gpu/drm/msm/hdmi/hdmi_bridge.c:18:
drivers/gpu/drm/msm/msm_drv.h:45:24: fatal error: mach/board.h: No such file or directory
 #include <mach/board.h>
                        ^

drivers/gpu/drm/msm/hdmi/hdmi_phy_8960.c:503:2: error: implicit declaration of function 'devm_clk_register' [-Werror=implicit-function-declaration]

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/drivers/gpu/drm/msm/Kconfig b/drivers/gpu/drm/msm/Kconfig
index 5b2a1ff95d3d..bacbbb70f679 100644
--- a/drivers/gpu/drm/msm/Kconfig
+++ b/drivers/gpu/drm/msm/Kconfig
@@ -3,6 +3,7 @@ config DRM_MSM
 	tristate "MSM DRM"
 	depends on DRM
 	depends on ARCH_QCOM || (ARM && COMPILE_TEST)
+	depends on OF && COMMON_CLK
 	select REGULATOR
 	select DRM_KMS_HELPER
 	select DRM_PANEL
