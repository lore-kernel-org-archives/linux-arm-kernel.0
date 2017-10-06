From: zajec5@gmail.com (=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?=)
Date: Fri,  6 Oct 2017 10:52:35 +0200
Subject: [PATCH] ARM: dts: BCM5301X: Specify USB ports for USB LED of Luxul
 XWR-1200
Message-ID: <20171006085235.13508-1-zajec5@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rafa? Mi?ecki <rafal@milecki.pl>

This info can be used by operating system to setup LED behavior.

Reported-by: Dan Haab <dhaab@luxul.com>
Signed-off-by: Rafa? Mi?ecki <rafal@milecki.pl>
---
 arch/arm/boot/dts/bcm47081-luxul-xwr-1200.dts | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/bcm47081-luxul-xwr-1200.dts b/arch/arm/boot/dts/bcm47081-luxul-xwr-1200.dts
index c544ab302012..ba1c19b1b3eb 100644
--- a/arch/arm/boot/dts/bcm47081-luxul-xwr-1200.dts
+++ b/arch/arm/boot/dts/bcm47081-luxul-xwr-1200.dts
@@ -57,7 +57,8 @@
 		usb {
 			label = "bcm53xx:green:usb";
 			gpios = <&chipcommon 8 GPIO_ACTIVE_LOW>;
-			linux,default-trigger = "none";
+			trigger-sources = <&ohci_port2>, <&ehci_port2>;
+			linux,default-trigger = "usbport";
 		};
 
 		status {
-- 
2.11.0
