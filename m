From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Sat, 21 Apr 2018 13:28:41 +0200
Subject: [PATCH V2 8/9] arm64: defconfig: Enable LAN and BT support for RPi 3
 B+
In-Reply-To: <1524310122-9439-1-git-send-email-stefan.wahren@i2se.com>
References: <1524310122-9439-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <1524310122-9439-9-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Raspberry Pi 3 B+ has a Microchip LAN7515 (connect via USB) and
a Cypress CYW43455 (connect via UART). This patch enables the necessary
drivers.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Reviewed-by: Eric Anholt <eric@anholt.net>
---
 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index ecf6137..8ac1feaf 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -159,6 +159,7 @@ CONFIG_BT_LEDS=y
 # CONFIG_BT_DEBUGFS is not set
 CONFIG_BT_HCIUART=m
 CONFIG_BT_HCIUART_LL=y
+CONFIG_BT_HCIUART_BCM=y
 CONFIG_CFG80211=m
 CONFIG_MAC80211=m
 CONFIG_MAC80211_LEDS=y
@@ -239,6 +240,7 @@ CONFIG_ROCKCHIP_PHY=y
 CONFIG_USB_PEGASUS=m
 CONFIG_USB_RTL8150=m
 CONFIG_USB_RTL8152=m
+CONFIG_USB_LAN78XX=m
 CONFIG_USB_USBNET=m
 CONFIG_USB_NET_DM9601=m
 CONFIG_USB_NET_SR9800=m
-- 
2.7.4
