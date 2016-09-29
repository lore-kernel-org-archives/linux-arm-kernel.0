From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Thu, 29 Sep 2016 18:31:54 +0200
Subject: [PATCH 5/6] ARM: davinci: enable the LCDC DRM driver in defconfig
In-Reply-To: <1475166715-7857-1-git-send-email-bgolaszewski@baylibre.com>
References: <1475166715-7857-1-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <1475166715-7857-6-git-send-email-bgolaszewski@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With the device tree changes for tilcdc in place, we can now enable
the driver by default in the davinci_all defconfig file.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/configs/davinci_all_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/davinci_all_defconfig b/arch/arm/configs/davinci_all_defconfig
index 5e5dd6b..58d04f1 100644
--- a/arch/arm/configs/davinci_all_defconfig
+++ b/arch/arm/configs/davinci_all_defconfig
@@ -123,6 +123,8 @@ CONFIG_TPS6507X=y
 CONFIG_REGULATOR=y
 CONFIG_REGULATOR_FIXED_VOLTAGE=y
 CONFIG_REGULATOR_TPS6507X=y
+CONFIG_DRM=m
+CONFIG_DRM_TILCDC=m
 CONFIG_FB=y
 CONFIG_FIRMWARE_EDID=y
 CONFIG_FB_DA8XX=y
-- 
2.7.4
