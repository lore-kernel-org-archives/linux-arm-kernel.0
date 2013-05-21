From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Tue, 21 May 2013 11:46:14 +0200
Subject: [PATCH 1/3] ARM: ux500: Enable MMC_UNSAFE_RESUME
In-Reply-To: <1369129576-28617-1-git-send-email-ulf.hansson@linaro.org>
References: <1369129576-28617-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <1369129576-28617-2-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable CONFIG_MMC_UNSAFE_RESUME to be accomplish a proper
suspend/resume cycle for SD/SDIO/(e)MMC.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 arch/arm/configs/u300_defconfig  |    1 +
 arch/arm/configs/u8500_defconfig |    1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm/configs/u300_defconfig b/arch/arm/configs/u300_defconfig
index 374000e..c839375 100644
--- a/arch/arm/configs/u300_defconfig
+++ b/arch/arm/configs/u300_defconfig
@@ -51,6 +51,7 @@ CONFIG_BACKLIGHT_CLASS_DEVICE=y
 # CONFIG_HID_SUPPORT is not set
 # CONFIG_USB_SUPPORT is not set
 CONFIG_MMC=y
+CONFIG_MMC_UNSAFE_RESUME=y
 CONFIG_MMC_CLKGATE=y
 CONFIG_MMC_ARMMMCI=y
 CONFIG_RTC_CLASS=y
diff --git a/arch/arm/configs/u8500_defconfig b/arch/arm/configs/u8500_defconfig
index c037aa1..f9e3f38 100644
--- a/arch/arm/configs/u8500_defconfig
+++ b/arch/arm/configs/u8500_defconfig
@@ -82,6 +82,7 @@ CONFIG_REGULATOR_GPIO=y
 CONFIG_USB_GADGET=y
 CONFIG_AB8500_USB=y
 CONFIG_MMC=y
+CONFIG_MMC_UNSAFE_RESUME=y
 CONFIG_MMC_CLKGATE=y
 CONFIG_MMC_ARMMMCI=y
 CONFIG_NEW_LEDS=y
-- 
1.7.10
