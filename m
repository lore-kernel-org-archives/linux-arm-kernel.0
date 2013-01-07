From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon,  7 Jan 2013 17:27:14 +0100
Subject: [PATCH 3.8-rc] arm: mvebu: add LEDs support to defconfig file
Message-ID: <1357576034-24193-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The OpenBlocks AX3-4 platform has several LEDs, so it sounds wise to
enable LED support in mvebu_defconfig. We anticipate that more
platforms using Marvell EBU SoCs will have LEDs in the future.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
This is 3.8-rc material.
---
 arch/arm/configs/mvebu_defconfig |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/configs/mvebu_defconfig b/arch/arm/configs/mvebu_defconfig
index 3ba35f1..6b9e95d 100644
--- a/arch/arm/configs/mvebu_defconfig
+++ b/arch/arm/configs/mvebu_defconfig
@@ -40,6 +40,11 @@ CONFIG_I2C_MV64XXX=y
 CONFIG_GPIOLIB=y
 CONFIG_GPIO_SYSFS=y
 # CONFIG_USB_SUPPORT is not set
+CONFIG_NEW_LEDS=y
+CONFIG_LEDS_CLASS=m
+CONFIG_LEDS_TRIGGERS=y
+CONFIG_LEDS_TRIGGER_TIMER=y
+CONFIG_LEDS_TRIGGER_HEARTBEAT=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_S35390A=y
 CONFIG_DMADEVICES=y
-- 
1.7.9.5
