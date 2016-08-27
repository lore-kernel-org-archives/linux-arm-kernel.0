From: wens@csie.org (Chen-Yu Tsai)
Date: Sat, 27 Aug 2016 15:55:44 +0800
Subject: [PATCH v2 8/8] ARM: dts: sun9i: a80-optimus: Disable EHCI1
In-Reply-To: <20160827075544.26316-1-wens@csie.org>
References: <20160827075544.26316-1-wens@csie.org>
Message-ID: <20160827075544.26316-9-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

EHCI1 provides an HSIC interface. This interface is exposed on the
board through two pins among the GPIO header.

With the PHY now powered up and responding, enabling the interface when
nothing is connected results in a lot of error messages:

	usb 2-1: device descriptor read/64, error -71
	usb 2-1: device descriptor read/64, error -71
	usb 2-1: new high-speed USB device number 3 using ehci-platform
	usb 2-1: device descriptor read/64, error -71
	usb 2-1: device descriptor read/64, error -71
	usb 2-1: new high-speed USB device number 4 using ehci-platform
	usb 2-1: device not accepting address 4, error -71
	usb 2-1: new high-speed USB device number 5 using ehci-platform
	usb 2-1: device not accepting address 5, error -71
	usb usb2-port1: unable to enumerate USB device

Disable it by default, but leave the entries in the board DTS.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
Changes since v1: none
---
 arch/arm/boot/dts/sun9i-a80-optimus.dts | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/sun9i-a80-optimus.dts b/arch/arm/boot/dts/sun9i-a80-optimus.dts
index d805cb50b5c8..ceb6ef15d669 100644
--- a/arch/arm/boot/dts/sun9i-a80-optimus.dts
+++ b/arch/arm/boot/dts/sun9i-a80-optimus.dts
@@ -112,7 +112,8 @@
 };
 
 &ehci1 {
-	status = "okay";
+	/* Enable if HSIC peripheral is connected */
+	status = "disabled";
 };
 
 &ehci2 {
@@ -484,7 +485,8 @@
 
 &usbphy2 {
 	phy-supply = <&reg_bldo4>;
-	status = "okay";
+	/* Enable if HSIC peripheral is connected */
+	status = "disabled";
 };
 
 &usbphy3 {
-- 
2.9.3
