From: fabrice.gasnier@st.com (Fabrice Gasnier)
Date: Fri, 2 Dec 2016 14:57:00 +0100
Subject: [PATCH 1/3] ARM: configs: stm32: enable ADC driver
In-Reply-To: <1480687022-12851-1-git-send-email-fabrice.gasnier@st.com>
References: <1480687022-12851-1-git-send-email-fabrice.gasnier@st.com>
Message-ID: <1480687022-12851-2-git-send-email-fabrice.gasnier@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ADC driver depends on REGULATOR and IIO that are not yet selected.
Current hardware boards (like stm32f429i-eval) is using fixed
regulators.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 arch/arm/configs/stm32_defconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/configs/stm32_defconfig b/arch/arm/configs/stm32_defconfig
index a60b5cb..92ccc3c 100644
--- a/arch/arm/configs/stm32_defconfig
+++ b/arch/arm/configs/stm32_defconfig
@@ -49,6 +49,8 @@ CONFIG_SERIAL_STM32=y
 CONFIG_SERIAL_STM32_CONSOLE=y
 # CONFIG_HW_RANDOM is not set
 # CONFIG_HWMON is not set
+CONFIG_REGULATOR=y
+CONFIG_REGULATOR_FIXED_VOLTAGE=y
 # CONFIG_USB_SUPPORT is not set
 CONFIG_NEW_LEDS=y
 CONFIG_LEDS_CLASS=y
@@ -57,6 +59,9 @@ CONFIG_LEDS_TRIGGERS=y
 CONFIG_LEDS_TRIGGER_HEARTBEAT=y
 CONFIG_DMADEVICES=y
 CONFIG_STM32_DMA=y
+CONFIG_IIO=y
+CONFIG_STM32_ADC_CORE=y
+CONFIG_STM32_ADC=y
 # CONFIG_FILE_LOCKING is not set
 # CONFIG_DNOTIFY is not set
 # CONFIG_INOTIFY_USER is not set
-- 
1.9.1
