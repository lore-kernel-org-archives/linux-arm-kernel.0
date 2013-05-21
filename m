From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Tue, 21 May 2013 11:46:15 +0200
Subject: [PATCH 2/3] ARM: ux500: Don't use MMC_CLKGATE
In-Reply-To: <1369129576-28617-1-git-send-email-ulf.hansson@linaro.org>
References: <1369129576-28617-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <1369129576-28617-3-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since ARMMMCI host driver now supports clock gating through runtime PM
CONFIG_MMC_CLKGATE is not needed anymore.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 arch/arm/configs/u300_defconfig  |    1 -
 arch/arm/configs/u8500_defconfig |    1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/arm/configs/u300_defconfig b/arch/arm/configs/u300_defconfig
index c839375..ffe2db8 100644
--- a/arch/arm/configs/u300_defconfig
+++ b/arch/arm/configs/u300_defconfig
@@ -52,7 +52,6 @@ CONFIG_BACKLIGHT_CLASS_DEVICE=y
 # CONFIG_USB_SUPPORT is not set
 CONFIG_MMC=y
 CONFIG_MMC_UNSAFE_RESUME=y
-CONFIG_MMC_CLKGATE=y
 CONFIG_MMC_ARMMMCI=y
 CONFIG_RTC_CLASS=y
 # CONFIG_RTC_HCTOSYS is not set
diff --git a/arch/arm/configs/u8500_defconfig b/arch/arm/configs/u8500_defconfig
index f9e3f38..45d9087 100644
--- a/arch/arm/configs/u8500_defconfig
+++ b/arch/arm/configs/u8500_defconfig
@@ -83,7 +83,6 @@ CONFIG_USB_GADGET=y
 CONFIG_AB8500_USB=y
 CONFIG_MMC=y
 CONFIG_MMC_UNSAFE_RESUME=y
-CONFIG_MMC_CLKGATE=y
 CONFIG_MMC_ARMMMCI=y
 CONFIG_NEW_LEDS=y
 CONFIG_LEDS_CLASS=y
-- 
1.7.10
