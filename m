From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 21 Mar 2016 09:50:37 +0100
Subject: [PATCH] ARM: u8500_defconfig: turn on the Synaptics RMI4 driver
Message-ID: <1458550237-11607-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Ux500 boards may have an RMI4 unit, and the DT fragments for
them have been merged upstream. Add it to the defconfig.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ARM SoC folks: please apply this directly for v4.6 so our defconfig
is in sync with available upstream drivers.
---
 arch/arm/configs/u8500_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/configs/u8500_defconfig b/arch/arm/configs/u8500_defconfig
index 07055eacbb0f..a691d590fbd1 100644
--- a/arch/arm/configs/u8500_defconfig
+++ b/arch/arm/configs/u8500_defconfig
@@ -63,6 +63,9 @@ CONFIG_INPUT_TOUCHSCREEN=y
 CONFIG_TOUCHSCREEN_BU21013=y
 CONFIG_INPUT_MISC=y
 CONFIG_INPUT_AB8500_PONKEY=y
+CONFIG_RMI4_CORE=y
+CONFIG_RMI4_I2C=y
+CONFIG_RMI4_F11=y
 # CONFIG_SERIO is not set
 CONFIG_VT_HW_CONSOLE_BINDING=y
 # CONFIG_LEGACY_PTYS is not set
-- 
2.4.3
