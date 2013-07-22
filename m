From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Mon, 22 Jul 2013 10:00:14 +0530
Subject: [PATCH v2 1/1] ARM: EXYNOS: Update CONFIG_ARCH_NR_GPIO for Exynos
Message-ID: <1374467414-25801-1-git-send-email-sachin.kamat@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With the recent cleanup in Exynos platform code notably commits
17859bec ("ARM: EXYNOS: Do not select legacy Kconfig symbols any
more") and b9222210 ("ARM: EXYNOS: Remove mach/gpio.h"), the definition
of ARCH_NR_GPIOS got removed. This started causing problems on SoCs like
Exynos4412 which have more than the default number of GPIOs. Thus define
this number in KConfig file. Without this patch we get the following errors
during boot:

gpiochip_add: gpios 251..258 (gpv0) failed to register
samsung-pinctrl 106e0000.pinctrl: failed to register gpio_chip gpv0,
error code: -22
samsung-pinctrl: probe of 106e0000.pinctrl failed with error -22

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Tomasz Figa <t.figa@samsung.com>
---
Changes since v1:
* Changed default number to 285 (as required by 4412).
---
 arch/arm/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index ba412e0..f4841a2 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1605,6 +1605,7 @@ config ARCH_NR_GPIO
 	default 392 if ARCH_U8500
 	default 352 if ARCH_VT8500
 	default 288 if ARCH_SUNXI
+	default 285 if ARCH_EXYNOS
 	default 264 if MACH_H4700
 	default 0
 	help
-- 
1.7.9.5
