From: mporter@linaro.org (Matt Porter)
Date: Tue,  4 Feb 2014 07:19:11 -0500
Subject: [PATCH 5/6] ARM: configs: bcm_defconfig: enable bcm59056 regulator
 support
In-Reply-To: <1391516352-32359-1-git-send-email-mporter@linaro.org>
References: <1391516352-32359-1-git-send-email-mporter@linaro.org>
Message-ID: <1391516352-32359-6-git-send-email-mporter@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable BCM59056 MFD and regulator drivers to manage voltage
regulators on BCM281xx platforms.

Signed-off-by: Tim Kryger <tim.kryger@linaro.org>
Signed-off-by: Matt Porter <mporter@linaro.org>
Reviewed-by: Markus Mayer <markus.mayer@linaro.org>
---
 arch/arm/configs/bcm_defconfig | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/configs/bcm_defconfig b/arch/arm/configs/bcm_defconfig
index 2519d6d..35752cc 100644
--- a/arch/arm/configs/bcm_defconfig
+++ b/arch/arm/configs/bcm_defconfig
@@ -79,6 +79,13 @@ CONFIG_HW_RANDOM=y
 CONFIG_I2C=y
 CONFIG_I2C_CHARDEV=y
 # CONFIG_HWMON is not set
+CONFIG_MFD_BCM59056=y
+CONFIG_REGULATOR=y
+CONFIG_REGULATOR_FIXED_VOLTAGE=y
+CONFIG_REGULATOR_VIRTUAL_CONSUMER=y
+CONFIG_REGULATOR_USERSPACE_CONSUMER=y
+CONFIG_REGULATOR_BCM59056=y
+
 CONFIG_VIDEO_OUTPUT_CONTROL=y
 CONFIG_FB=y
 CONFIG_BACKLIGHT_LCD_SUPPORT=y
-- 
1.8.4
