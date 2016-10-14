From: gabriel.fernandez@st.com (gabriel.fernandez at st.com)
Date: Fri, 14 Oct 2016 11:18:16 +0200
Subject: [PATCH v2 3/6] arm: stmf32: Enable SYSCON
In-Reply-To: <1476436699-21879-1-git-send-email-gabriel.fernandez@st.com>
References: <1476436699-21879-1-git-send-email-gabriel.fernandez@st.com>
Message-ID: <1476436699-21879-4-git-send-email-gabriel.fernandez@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gabriel Fernandez <gabriel.fernandez@st.com>

The clock drivers needs to disable the power domain write protection
using syscon/regmap to enable RTC clock.

Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
---
 arch/arm/configs/stm32_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/stm32_defconfig b/arch/arm/configs/stm32_defconfig
index 1e5ec2a..ed1c0881 100644
--- a/arch/arm/configs/stm32_defconfig
+++ b/arch/arm/configs/stm32_defconfig
@@ -49,6 +49,7 @@ CONFIG_SERIAL_STM32=y
 CONFIG_SERIAL_STM32_CONSOLE=y
 # CONFIG_HW_RANDOM is not set
 # CONFIG_HWMON is not set
+CONFIG_MFD_SYSCON=y
 # CONFIG_USB_SUPPORT is not set
 CONFIG_NEW_LEDS=y
 CONFIG_LEDS_CLASS=y
-- 
1.9.1
