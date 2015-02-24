From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 24 Feb 2015 15:02:30 +0000
Subject: [PATCH] ARM: vexpress: update CONFIG_USB_ISP1760 option
Message-ID: <1424790150-8450-1-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commt 7ef077a8ad35 ("usb: isp1760: Move driver from drivers/usb/host/
to drivers/usb/isp1760/") moved the isp1760 driver and changed the
Kconfig option. This makes CONFIG_USB_ISP1760_HCD not selectable
directly anymore. This results in driver being not compiled in when
using vexpress_defconfig and the USB is non-functional.

This patch updates the CONFIG_USB_ISP1760_HCD to CONFIG_USB_ISP1760 to
get back USB functional on vexpress platforms.

Cc: Liviu Dudau <liviu.dudau@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 arch/arm/configs/vexpress_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/configs/vexpress_defconfig b/arch/arm/configs/vexpress_defconfig
index f489fdaa19b8..37fe607a4ede 100644
--- a/arch/arm/configs/vexpress_defconfig
+++ b/arch/arm/configs/vexpress_defconfig
@@ -118,8 +118,8 @@ CONFIG_HID_ZEROPLUS=y
 CONFIG_USB=y
 CONFIG_USB_ANNOUNCE_NEW_DEVICES=y
 CONFIG_USB_MON=y
-CONFIG_USB_ISP1760_HCD=y
 CONFIG_USB_STORAGE=y
+CONFIG_USB_ISP1760=y
 CONFIG_MMC=y
 CONFIG_MMC_ARMMMCI=y
 CONFIG_NEW_LEDS=y
-- 
1.9.1
