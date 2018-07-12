From: stefan@agner.ch (Stefan Agner)
Date: Thu, 12 Jul 2018 12:59:42 +0200
Subject: [PATCH 2/2] ARM: imx_v6_v7_defconfig: use MXSFB DRM driver
In-Reply-To: <20180712105942.25245-1-stefan@agner.ch>
References: <20180712105942.25245-1-stefan@agner.ch>
Message-ID: <20180712105942.25245-2-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the the DRM driver for MXSFB LCD controller (used in i.MX23/
i.MX28/i.MX6SX or i.MX7). Remove CONFIG_FB_MXS which will soon be
removed.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/configs/imx_v6_v7_defconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 200ebda47e0c..14de85178793 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -266,7 +266,8 @@ CONFIG_DRM_IMX_TVE=y
 CONFIG_DRM_IMX_LDB=y
 CONFIG_DRM_IMX_HDMI=y
 CONFIG_DRM_ETNAVIV=y
-CONFIG_FB_MXS=y
+CONFIG_DRM_MXSFB=y
+CONFIG_FB_MODE_HELPERS=y
 CONFIG_LCD_CLASS_DEVICE=y
 CONFIG_LCD_L4F00242T03=y
 CONFIG_LCD_PLATFORM=y
-- 
2.18.0
