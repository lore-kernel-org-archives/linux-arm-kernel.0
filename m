From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 07 Dec 2015 09:59:54 +0900
Subject: [PATCH] ARM: multi_v7_defconfig: Enable fan,
 sensors and audio for Odroid XU3
Message-ID: <1449449994-10110-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For Odroid XU3-family enable the:
 - PWM fan (to control the CPU fan using thermal subsystem),
 - TI INA231 sensors (provide power measurements of big.LITTLE cores,
   DRAM and GPU),
 - Samsung sound (for Odroid XU3 and Snow as well).

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 arch/arm/configs/multi_v7_defconfig | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index f6a2557b55df..419f9413402c 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -390,7 +390,8 @@ CONFIG_POWER_RESET_RMOBILE=y
 CONFIG_SENSORS_LM90=y
 CONFIG_SENSORS_LM95245=y
 CONFIG_SENSORS_NTC_THERMISTOR=m
-CONFIG_THERMAL=y
+CONFIG_SENSORS_PWM_FAN=m
+CONFIG_SENSORS_INA2XX=m
 CONFIG_CPU_THERMAL=y
 CONFIG_ROCKCHIP_THERMAL=y
 CONFIG_RCAR_THERMAL=y
@@ -521,10 +522,13 @@ CONFIG_SND_HDA_INPUT_BEEP=y
 CONFIG_SND_HDA_PATCH_LOADER=y
 CONFIG_SND_HDA_CODEC_REALTEK=m
 CONFIG_SND_HDA_CODEC_HDMI=m
-CONFIG_SND_USB_AUDIO=y
+CONFIG_SND_USB_AUDIO=m
 CONFIG_SND_SOC=m
 CONFIG_SND_ATMEL_SOC=m
 CONFIG_SND_ATMEL_SOC_WM8904=m
+CONFIG_SND_SOC_SAMSUNG=m
+CONFIG_SND_SOC_SNOW=m
+CONFIG_SND_SOC_ODROIDX2=m
 CONFIG_SND_SOC_SH4_FSI=m
 CONFIG_SND_SOC_RCAR=m
 CONFIG_SND_SOC_RSRC_CARD=m
-- 
1.9.1
