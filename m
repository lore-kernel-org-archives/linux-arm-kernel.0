From: fabio.baltieri@linaro.org (Fabio Baltieri)
Date: Thu, 21 Mar 2013 13:31:53 +0100
Subject: [PATCH v3] ARM: ux500: select WATCHDOG and MUSB for ux500
In-Reply-To: <1363864186-11514-1-git-send-email-fabio.baltieri@linaro.org>
References: <1363864186-11514-1-git-send-email-fabio.baltieri@linaro.org>
Message-ID: <1363869113-19610-1-git-send-email-fabio.baltieri@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable ux500 specific USB and watchdog drivers by default on
u8500_defconfig.

Signed-off-by: Fabio Baltieri <fabio.baltieri@linaro.org>
---

Hi again Linus,

seems like this is being harder than I thought...  In v2 I had a
duplicated CONFIG_AB8500_USB symbol that was giving a warning in make
u8500_defconfig, this version fixes it.  Sorry about that, I'm trying to
keep this patch minimal, but maybe it's time for a real update to the
savedefconfig output.

Thanks,
Fabio

 arch/arm/configs/u8500_defconfig | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/configs/u8500_defconfig b/arch/arm/configs/u8500_defconfig
index 426270f..ecde6868 100644
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
@@ -80,7 +81,13 @@ CONFIG_REGULATOR_AB8500=y
 CONFIG_REGULATOR_FIXED_VOLTAGE=y
 CONFIG_REGULATOR_GPIO=y
 # CONFIG_HID_SUPPORT is not set
+CONFIG_USB=y
+CONFIG_USB_MUSB_HDRC=y
+CONFIG_USB_MUSB_UX500=y
+CONFIG_USB_PHY=y
 CONFIG_USB_GADGET=y
+CONFIG_USB_GADGET_MUSB_HDRC=y
+CONFIG_USB_ETH=m
 CONFIG_AB8500_USB=y
 CONFIG_MMC=y
 CONFIG_MMC_CLKGATE=y
-- 
1.8.1.3
