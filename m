From: aford173@gmail.com (Adam Ford)
Date: Fri, 18 May 2018 13:09:53 -0500
Subject: [PATCH V2] ARM: davinci_all_defconfig: set CONFIG_BACKLIGHT_PWM=m
Message-ID: <20180518180953.9860-1-aford173@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The da850-evm came with an LCD with a backlight tied to a pwm. This
enables CONFIG_BACKLIGHT_PWM as a module so the PWM backlight can be
used to maintain brightness control of the backlight.

Signed-off-by: Adam Ford <aford173@gmail.com>
---

V2: Only enable CONFIG_BACKLIGHT_PWM and do not re-sync with savedefconfig

diff --git a/arch/arm/configs/davinci_all_defconfig b/arch/arm/configs/davinci_all_defconfig
index c302a04e8cbc..48d23956d898 100644
--- a/arch/arm/configs/davinci_all_defconfig
+++ b/arch/arm/configs/davinci_all_defconfig
@@ -153,6 +153,7 @@ CONFIG_TINYDRM_ST7586=m
 CONFIG_FB=y
 CONFIG_FIRMWARE_EDID=y
 CONFIG_FB_DA8XX=y
+CONFIG_BACKLIGHT_PWM=m
 CONFIG_FRAMEBUFFER_CONSOLE=y
 CONFIG_LOGO=y
 CONFIG_SOUND=m
-- 
2.17.0
