From: marex@denx.de (Marek Vasut)
Date: Thu,  5 May 2016 22:33:14 +0200
Subject: [PATCH] ARM: socfpga: Update socfpga_defconfig
Message-ID: <1462480394-8084-1-git-send-email-marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the following bits:

CONFIG_TOUCHSCREEN_STMPE
 - STMPE touchscreen support, needed on MCVEVK as it contains the
   chip. This also enables the STMPE MFD device and touchscreen
   input support.

CONFIG_USB_STORAGE
 - USB storage support is often used, so enable it.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Dinh Nguyen <dinguyen@opensource.altera.com>
---
 arch/arm/configs/socfpga_defconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/configs/socfpga_defconfig b/arch/arm/configs/socfpga_defconfig
index e277dc6..9e1e096 100644
--- a/arch/arm/configs/socfpga_defconfig
+++ b/arch/arm/configs/socfpga_defconfig
@@ -59,6 +59,8 @@ CONFIG_NETDEVICES=y
 CONFIG_STMMAC_ETH=y
 CONFIG_MICREL_PHY=y
 CONFIG_INPUT_EVDEV=y
+CONFIG_INPUT_TOUCHSCREEN=y
+CONFIG_TOUCHSCREEN_STMPE=y
 # CONFIG_SERIO_SERPORT is not set
 CONFIG_SERIO_AMBAKMI=y
 CONFIG_LEGACY_PTY_COUNT=16
@@ -78,9 +80,11 @@ CONFIG_SENSORS_LTC2978=y
 CONFIG_SENSORS_LTC2978_REGULATOR=y
 CONFIG_WATCHDOG=y
 CONFIG_DW_WATCHDOG=y
+CONFIG_MFD_STMPE=y
 CONFIG_REGULATOR=y
 CONFIG_REGULATOR_FIXED_VOLTAGE=y
 CONFIG_USB=y
+CONFIG_USB_STORAGE=y
 CONFIG_USB_DWC2=y
 CONFIG_NOP_USB_XCEIV=y
 CONFIG_USB_GADGET=y
-- 
2.7.0
