From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 10 Dec 2015 13:40:00 +0100
Subject: [PATCH 3/4] ARM: realview: add generic config options
Message-ID: <1449751200-13520-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds a few features that are available on some
or all of the RealView but never made it into the defconfig
file:

- High-resolution timers
- Perf events and HW perf events from the PMU
- MTD AFS partition handling
- MTD ROM partition handling
- USB and ISP1760 USB driver

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/configs/realview_defconfig | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/configs/realview_defconfig b/arch/arm/configs/realview_defconfig
index 923df191c674..56ea47427eca 100644
--- a/arch/arm/configs/realview_defconfig
+++ b/arch/arm/configs/realview_defconfig
@@ -1,6 +1,8 @@
 # CONFIG_SWAP is not set
 CONFIG_SYSVIPC=y
+CONFIG_HIGH_RES_TIMERS=y
 CONFIG_LOG_BUF_SHIFT=14
+CONFIG_PERF_EVENTS=y
 CONFIG_SLAB=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
@@ -28,10 +30,12 @@ CONFIG_IP_PNP_BOOTP=y
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_MTD=y
 CONFIG_MTD_CMDLINE_PARTS=y
+CONFIG_MTD_AFS_PARTS=y
 CONFIG_MTD_BLOCK=y
 CONFIG_MTD_CFI=y
 CONFIG_MTD_CFI_INTELEXT=y
 CONFIG_MTD_CFI_AMDSTD=y
+CONFIG_MTD_ROM=y
 CONFIG_MTD_PHYSMAP=y
 CONFIG_ARM_CHARLCD=y
 CONFIG_NETDEVICES=y
@@ -61,7 +65,8 @@ CONFIG_SND_MIXER_OSS=y
 CONFIG_SND_PCM_OSS=y
 # CONFIG_SND_DRIVERS is not set
 CONFIG_SND_ARMAACI=y
-# CONFIG_USB_SUPPORT is not set
+CONFIG_USB=y
+CONFIG_USB_ISP1760=y
 CONFIG_MMC=y
 CONFIG_MMC_ARMMMCI=y
 CONFIG_NEW_LEDS=y
-- 
2.4.3
