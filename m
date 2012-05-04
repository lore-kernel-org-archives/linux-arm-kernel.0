From: lee.jones@linaro.org (Lee Jones)
Date: Fri,  4 May 2012 19:23:14 +0100
Subject: [PATCH 04/15] ARM: ux500: CONFIG: Compile in support for leds-gpio
In-Reply-To: <1336155805-18554-1-git-send-email-lee.jones@linaro.org>
References: <1336155805-18554-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1336155805-18554-5-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Code exists in the mop500 board file (used for HREF and
Snowball) to initialise Snowball's user LED via the
leds-gpio driver. However, the driver isn't currently
built when using the default configuration file. This
patch aims to change that behavior.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/configs/u8500_defconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/u8500_defconfig b/arch/arm/configs/u8500_defconfig
index 7e84f45..00571b7 100644
--- a/arch/arm/configs/u8500_defconfig
+++ b/arch/arm/configs/u8500_defconfig
@@ -85,6 +85,7 @@ CONFIG_NEW_LEDS=y
 CONFIG_LEDS_CLASS=y
 CONFIG_LEDS_LM3530=y
 CONFIG_LEDS_LP5521=y
+CONFIG_LEDS_GPIO=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_AB8500=y
 CONFIG_RTC_DRV_PL031=y
-- 
1.7.9.5
