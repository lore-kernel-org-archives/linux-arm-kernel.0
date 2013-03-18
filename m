From: fabio.baltieri@linaro.org (Fabio Baltieri)
Date: Mon, 18 Mar 2013 12:00:57 +0100
Subject: [PATCH] ARM: ux500: select WATCHDOG and MUSB for ux500
Message-ID: <1363604457-17112-1-git-send-email-fabio.baltieri@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable ux500 specific USB and watchdog drivers by default on
u8500_defconfig.

Signed-off-by: Fabio Baltieri <fabio.baltieri@linaro.org>
---

Hello Linus,

ux500 watchdog support was introduced during this merge window and USB
was fixed too, so I'm sending a defconfig update to enable those two
drivers by default, so that those get some more testing.

Thanks,
Fabio

 arch/arm/configs/u8500_defconfig | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/configs/u8500_defconfig b/arch/arm/configs/u8500_defconfig
index 426270f..92b1347 100644
--- a/arch/arm/configs/u8500_defconfig
+++ b/arch/arm/configs/u8500_defconfig
@@ -71,6 +71,7 @@ CONFIG_GPIO_TC3589X=y
 # CONFIG_AB8500_BATTERY_THERM_ON_BATCTRL is not set
 CONFIG_THERMAL=y
 CONFIG_CPU_THERMAL=y
+CONFIG_WATCHDOG=y
 CONFIG_MFD_STMPE=y
 CONFIG_MFD_TC3589X=y
 CONFIG_AB5500_CORE=y
@@ -80,7 +81,12 @@ CONFIG_REGULATOR_AB8500=y
 CONFIG_REGULATOR_FIXED_VOLTAGE=y
 CONFIG_REGULATOR_GPIO=y
 # CONFIG_HID_SUPPORT is not set
+CONFIG_USB=y
+CONFIG_USB_MUSB_HDRC=y
+CONFIG_USB_MUSB_UX500=y
 CONFIG_USB_GADGET=y
+CONFIG_USB_GADGET_MUSB_HDRC=y
+CONFIG_USB_ETH=m
 CONFIG_AB8500_USB=y
 CONFIG_MMC=y
 CONFIG_MMC_CLKGATE=y
-- 
1.8.1.3
