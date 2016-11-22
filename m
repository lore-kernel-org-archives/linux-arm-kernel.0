From: khilman@baylibre.com (Kevin Hilman)
Date: Tue, 22 Nov 2016 11:45:51 -0800
Subject: [PATCH 4/4] ARM: davinci_all_defconfig: enable video capture as
 modules
In-Reply-To: <20161122194551.3420-1-khilman@baylibre.com>
References: <20161122194551.3420-1-khilman@baylibre.com>
Message-ID: <20161122194551.3420-5-khilman@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable media support and V4L2 capture, along with video decoders used
on da850 platforms.

Tested on da850-lcdk.

Signed-off-by: Kevin Hilman <khilman@baylibre.com>
---
 arch/arm/configs/davinci_all_defconfig | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/configs/davinci_all_defconfig b/arch/arm/configs/davinci_all_defconfig
index 5e5dd6bc5ed9..fd05bc35fb36 100644
--- a/arch/arm/configs/davinci_all_defconfig
+++ b/arch/arm/configs/davinci_all_defconfig
@@ -123,6 +123,12 @@ CONFIG_TPS6507X=y
 CONFIG_REGULATOR=y
 CONFIG_REGULATOR_FIXED_VOLTAGE=y
 CONFIG_REGULATOR_TPS6507X=y
+CONFIG_MEDIA_SUPPORT=m
+CONFIG_MEDIA_CAMERA_SUPPORT=y
+CONFIG_V4L_PLATFORM_DRIVERS=y
+CONFIG_VIDEO_DAVINCI_VPIF_CAPTURE=m
+# CONFIG_MEDIA_SUBDRV_AUTOSELECT is not set
+CONFIG_VIDEO_TVP514X=m
 CONFIG_FB=y
 CONFIG_FIRMWARE_EDID=y
 CONFIG_FB_DA8XX=y
-- 
2.9.3
