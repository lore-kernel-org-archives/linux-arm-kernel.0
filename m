From: stefan@agner.ch (Stefan Agner)
Date: Thu, 12 Jul 2018 12:59:41 +0200
Subject: [PATCH 1/2] ARM: mxs_defconfig: use MXSFB DRM driver
Message-ID: <20180712105942.25245-1-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the the DRM driver for MXSFB LCD controller (used in i.MX23/
i.MX28/i.MX6SX or i.MX7). Remove CONFIG_FB_MXS which will soon be
removed.

Note that this does not remove CONFIG_FB. CONFIG_FB gets selected
implicity by CONFIG_DRM/CONFIG_DRM_KMS_FB_HELPER.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/configs/mxs_defconfig | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/configs/mxs_defconfig b/arch/arm/configs/mxs_defconfig
index a508eb302e7a..148226e36152 100644
--- a/arch/arm/configs/mxs_defconfig
+++ b/arch/arm/configs/mxs_defconfig
@@ -94,8 +94,9 @@ CONFIG_STMP3XXX_RTC_WATCHDOG=y
 CONFIG_MFD_MXS_LRADC=y
 CONFIG_REGULATOR=y
 CONFIG_REGULATOR_FIXED_VOLTAGE=y
-CONFIG_FB=y
-CONFIG_FB_MXS=y
+CONFIG_DRM=y
+CONFIG_DRM_MXSFB=y
+CONFIG_FB_MODE_HELPERS=y
 CONFIG_BACKLIGHT_LCD_SUPPORT=y
 CONFIG_LCD_CLASS_DEVICE=y
 CONFIG_BACKLIGHT_CLASS_DEVICE=y
-- 
2.18.0
