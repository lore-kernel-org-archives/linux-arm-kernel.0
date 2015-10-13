From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 13 Oct 2015 10:27:08 +0900
Subject: [PATCH 4/4] ARM: multi_v7_defconfig: Enable Maxim 77693 LED and haptic
 drivers
In-Reply-To: <1444699628-3774-1-git-send-email-k.kozlowski@samsung.com>
References: <1444699628-3774-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1444699628-3774-4-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable support for:
1. Haptic motor driver on Trats2 board (Maxim 77693) and Note 4 (Maxim
   77843);
2. LED driver on Trats2 board (Maxim 77693).

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 arch/arm/configs/multi_v7_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 0b2b474649a2..fbe7d93ce5b3 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -248,6 +248,7 @@ CONFIG_TOUCHSCREEN_ST1232=m
 CONFIG_TOUCHSCREEN_STMPE=y
 CONFIG_TOUCHSCREEN_SUN4I=y
 CONFIG_INPUT_MISC=y
+CONFIG_INPUT_MAX77693_HAPTIC=m
 CONFIG_INPUT_MAX8997_HAPTIC=m
 CONFIG_INPUT_MPU3050=y
 CONFIG_INPUT_AXP20X_PEK=y
@@ -570,8 +571,10 @@ CONFIG_MMC_SH_MMCIF=y
 CONFIG_MMC_SUNXI=y
 CONFIG_NEW_LEDS=y
 CONFIG_LEDS_CLASS=y
+CONFIG_LEDS_CLASS_FLASH=m
 CONFIG_LEDS_GPIO=y
 CONFIG_LEDS_PWM=y
+CONFIG_LEDS_MAX77693=m
 CONFIG_LEDS_MAX8997=m
 CONFIG_LEDS_TRIGGERS=y
 CONFIG_LEDS_TRIGGER_TIMER=y
-- 
1.9.1
