From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 23 Oct 2012 10:19:58 +0200
Subject: [PATCH] arm: mvebu: add LED support in defconfig
Message-ID: <1350980398-6745-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The recently added support for the PlatHome Openblocks AX3 platform
requires the LED framework, so let's add it to mvebu_defconfig.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

---
This is 3.8 material
---
 arch/arm/configs/mvebu_defconfig |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/configs/mvebu_defconfig b/arch/arm/configs/mvebu_defconfig
index 3458752..b7ca617 100644
--- a/arch/arm/configs/mvebu_defconfig
+++ b/arch/arm/configs/mvebu_defconfig
@@ -26,6 +26,11 @@ CONFIG_SERIAL_OF_PLATFORM=y
 CONFIG_GPIOLIB=y
 CONFIG_GPIO_SYSFS=y
 # CONFIG_USB_SUPPORT is not set
+CONFIG_NEW_LEDS=y
+CONFIG_LEDS_CLASS=y
+CONFIG_LEDS_GPIO=y
+CONFIG_LEDS_TRIGGERS=y
+CONFIG_LEDS_TRIGGER_HEARTBEAT=y
 # CONFIG_IOMMU_SUPPORT is not set
 CONFIG_EXT2_FS=y
 CONFIG_EXT3_FS=y
-- 
1.7.9.5
