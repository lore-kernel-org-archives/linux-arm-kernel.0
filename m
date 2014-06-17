From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Tue, 17 Jun 2014 20:08:56 -0300
Subject: [PATCH] ARM: mvebu: enable Dove SoC in mvebu_v7_defconfig
Message-ID: <1403046536-18563-1-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since commit:

commit d93003e8e4e1fbbc8a06ec561a63f5aa105a4c45
Author: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Date:   Thu Apr 24 22:58:30 2014 +0100

    ARM: 8042/1: iwmmxt: allow to build iWMMXt on Marvell PJ4B

fixed the error that prevented Dove SoC from being built with
the rest of the mvebu SoCs, we can now add it to the defconfig.

In addition, this commit enables SERIAL_OF_PLATFORM, which is required
to have UART on some of the boards.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 arch/arm/configs/mvebu_v7_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/mvebu_v7_defconfig b/arch/arm/configs/mvebu_v7_defconfig
index e11170e..b0bfefa 100644
--- a/arch/arm/configs/mvebu_v7_defconfig
+++ b/arch/arm/configs/mvebu_v7_defconfig
@@ -14,6 +14,7 @@ CONFIG_MACH_ARMADA_370=y
 CONFIG_MACH_ARMADA_375=y
 CONFIG_MACH_ARMADA_38X=y
 CONFIG_MACH_ARMADA_XP=y
+CONFIG_MACH_DOVE=y
 CONFIG_NEON=y
 # CONFIG_CACHE_L2X0 is not set
 # CONFIG_SWP_EMULATE is not set
@@ -52,6 +53,7 @@ CONFIG_INPUT_EVDEV=y
 CONFIG_KEYBOARD_GPIO=y
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_SERIAL_OF_PLATFORM=y
 CONFIG_I2C=y
 CONFIG_SPI=y
 CONFIG_SPI_ORION=y
-- 
1.9.1
