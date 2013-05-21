From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Tue, 21 May 2013 11:46:16 +0200
Subject: [PATCH 3/3] ARM: ux500: Disable MMC_BLOCK_BOUNCE
In-Reply-To: <1369129576-28617-1-git-send-email-ulf.hansson@linaro.org>
References: <1369129576-28617-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <1369129576-28617-4-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since ARMMMCI can do scatter-gather we don't need CONFIG_MMC_BLOCK_BOUNCE.
Explicity disable it since it's default enabled, to skip unnecessarry
bounce buffer copying.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 arch/arm/configs/u300_defconfig  |    1 +
 arch/arm/configs/u8500_defconfig |    1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm/configs/u300_defconfig b/arch/arm/configs/u300_defconfig
index ffe2db8..9c7941d 100644
--- a/arch/arm/configs/u300_defconfig
+++ b/arch/arm/configs/u300_defconfig
@@ -52,6 +52,7 @@ CONFIG_BACKLIGHT_CLASS_DEVICE=y
 # CONFIG_USB_SUPPORT is not set
 CONFIG_MMC=y
 CONFIG_MMC_UNSAFE_RESUME=y
+# CONFIG_MMC_BLOCK_BOUNCE is not set
 CONFIG_MMC_ARMMMCI=y
 CONFIG_RTC_CLASS=y
 # CONFIG_RTC_HCTOSYS is not set
diff --git a/arch/arm/configs/u8500_defconfig b/arch/arm/configs/u8500_defconfig
index 45d9087..8fe6293 100644
--- a/arch/arm/configs/u8500_defconfig
+++ b/arch/arm/configs/u8500_defconfig
@@ -83,6 +83,7 @@ CONFIG_USB_GADGET=y
 CONFIG_AB8500_USB=y
 CONFIG_MMC=y
 CONFIG_MMC_UNSAFE_RESUME=y
+# CONFIG_MMC_BLOCK_BOUNCE is not set
 CONFIG_MMC_ARMMMCI=y
 CONFIG_NEW_LEDS=y
 CONFIG_LEDS_CLASS=y
-- 
1.7.10
