From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 25 Oct 2012 10:57:10 +0100
Subject: [PATCH 7/8] ARM: ux500: CONFIG: Enable GPIO Regulators
In-Reply-To: <1351159031-25391-1-git-send-email-lee.jones@linaro.org>
References: <1351159031-25391-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1351159031-25391-8-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It is the intention to convert the MMC voltage changing from
GPIO flipping to using a proper GPIO regulator interface. A
prerequisite of that is to enable the GPIO regulator
functionality. As this affects all ux5x0 based boards we'll
do it here instead of in the Kconfigs.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/configs/u8500_defconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/u8500_defconfig b/arch/arm/configs/u8500_defconfig
index 0575d8a..50d3c22 100644
--- a/arch/arm/configs/u8500_defconfig
+++ b/arch/arm/configs/u8500_defconfig
@@ -76,6 +76,7 @@ CONFIG_AB8500_CORE=y
 CONFIG_REGULATOR=y
 CONFIG_REGULATOR_AB8500=y
 CONFIG_REGULATOR_FIXED_VOLTAGE=y
+CONFIG_REGULATOR_GPIO=y
 # CONFIG_HID_SUPPORT is not set
 CONFIG_USB_GADGET=y
 CONFIG_AB8500_USB=y
-- 
1.7.9.5
