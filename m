From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Fri, 13 Apr 2018 19:27:56 +0200
Subject: [PATCH 7/9] ARM: multi_v7_defconfig: Enable LAN and BT support for
 RPi 3 B+
In-Reply-To: <1523640478-4448-1-git-send-email-stefan.wahren@i2se.com>
References: <1523640478-4448-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <1523640478-4448-8-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Raspberry Pi 3 B+ has a Microchip LAN7515 (connect via USB) and
a Cypress CYW43455 (connect via UART). This patch enables the necessary
drivers.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 arch/arm/configs/multi_v7_defconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index e6b3c96..88a07d6 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -187,6 +187,8 @@ CONFIG_B53_MMAP_DRIVER=m
 CONFIG_B53_SRAB_DRIVER=m
 CONFIG_CAN_SUN4I=y
 CONFIG_BT=m
+CONFIG_BT_HCIUART=m
+CONFIG_BT_HCIUART_BCM=y
 CONFIG_BT_MRVL=m
 CONFIG_BT_MRVL_SDIO=m
 CONFIG_CFG80211=m
@@ -280,6 +282,7 @@ CONFIG_FIXED_PHY=y
 CONFIG_ROCKCHIP_PHY=y
 CONFIG_USB_PEGASUS=y
 CONFIG_USB_RTL8152=m
+CONFIG_USB_LAN78XX=m
 CONFIG_USB_USBNET=y
 CONFIG_USB_NET_SMSC75XX=y
 CONFIG_USB_NET_SMSC95XX=y
@@ -360,6 +363,7 @@ CONFIG_SERIAL_ST_ASC=y
 CONFIG_SERIAL_ST_ASC_CONSOLE=y
 CONFIG_SERIAL_STM32=y
 CONFIG_SERIAL_STM32_CONSOLE=y
+CONFIG_SERIAL_DEV_BUS=y
 CONFIG_HVC_DRIVER=y
 CONFIG_VIRTIO_CONSOLE=y
 CONFIG_I2C_CHARDEV=y
-- 
2.7.4
