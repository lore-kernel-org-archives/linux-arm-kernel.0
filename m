From: 21cnbao@gmail.com (Barry Song)
Date: Sun,  9 Jun 2013 11:25:38 +0800
Subject: [PATCH 3/3] arm/dts: atlas6: fix the stuff of USB controller and phy
In-Reply-To: <1370748338-13210-1-git-send-email-Baohua.Song@csr.com>
References: <1370748338-13210-1-git-send-email-Baohua.Song@csr.com>
Message-ID: <1370748338-13210-4-git-send-email-Baohua.Song@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rong Wang <Rong.Wang@csr.com>

this patch fixes the USB stuff in atlas6.dtsi, and matches with
sirfsoc usb controller and phy drivers to work.

Signed-off-by: Rong Wang <Rong.Wang@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 arch/arm/boot/dts/atlas6.dtsi |   18 ++++++++++--------
 1 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/atlas6.dtsi b/arch/arm/boot/dts/atlas6.dtsi
index 7d1a279..a84b760 100644
--- a/arch/arm/boot/dts/atlas6.dtsi
+++ b/arch/arm/boot/dts/atlas6.dtsi
@@ -643,18 +643,20 @@
 			#size-cells = <1>;
 			ranges = <0xb8000000 0xb8000000 0x40000>;
 
-			usb0: usb at b00e0000 {
-				compatible = "chipidea,ci13611a-prima2";
-				reg = <0xb8000000 0x10000>;
-				interrupts = <10>;
-				clocks = <&clks 40>;
+			usbphy: usbphy at b8010200 {
+				compatible = "sirf,ci13xxx-usbphy";
+				reg = <0xb8010200 0x100>;
+				clocks = <&clks 39>;
 			};
 
-			usb1: usb at b00f0000 {
-				compatible = "chipidea,ci13611a-prima2";
-				reg = <0xb8010000 0x10000>;
+			usbcontroller: usbcontroller at b8010000 {
+				compatible = "sirf,ci13xxx-usbcontroller";
+				reg = <0xb8010000 0x200>;
 				interrupts = <11>;
 				clocks = <&clks 41>;
+				resets = <&rstc 9>;
+				vbus-gpios = <&gpio 0 14>;
+				sirf,ci13xxx-usbphy = <&usbphy>;
 			};
 
 			security at b00f0000 {
-- 
1.7.5.4
