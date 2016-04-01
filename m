From: heiko@sntech.de (Heiko Stuebner)
Date: Fri, 01 Apr 2016 15:27:14 +0200
Subject: [PATCH v2 2/5] ARM: dts: rockchip: fix missing usbphy unit-names
In-Reply-To: <56FE6A4F.2010609@phytec.de>
References: <1459457651-4727-1-git-send-email-heiko@sntech.de>
 <1459457651-4727-3-git-send-email-heiko@sntech.de>
 <56FE6A4F.2010609@phytec.de>
Message-ID: <19745485.m78qU7o4un@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The usbphy subnodes do have a reg property but no unitname, add them.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
Hi Wadim,

thanks for catching this. I needed this change to make my veyron board
boot on 4.6-rc1 (it is in the spi-fixes branch already now), and seem to
have accidentially commited it after testing.

 arch/arm/boot/dts/rk3066a.dtsi | 4 ++--
 arch/arm/boot/dts/rk3188.dtsi  | 4 ++--
 arch/arm/boot/dts/rk3288.dtsi  | 6 +++---
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/rk3066a.dtsi b/arch/arm/boot/dts/rk3066a.dtsi
index cb0a552..c84a306 100644
--- a/arch/arm/boot/dts/rk3066a.dtsi
+++ b/arch/arm/boot/dts/rk3066a.dtsi
@@ -207,7 +207,7 @@
 		#size-cells = <0>;
 		status = "disabled";
 
-		usbphy0: usb-phy0 {
+		usbphy0: usb-phy at 17c {
 			#phy-cells = <0>;
 			reg = <0x17c>;
 			clocks = <&cru SCLK_OTGPHY0>;
@@ -215,7 +215,7 @@
 			#clock-cells = <0>;
 		};
 
-		usbphy1: usb-phy1 {
+		usbphy1: usb-phy at 188 {
 			#phy-cells = <0>;
 			reg = <0x188>;
 			clocks = <&cru SCLK_OTGPHY1>;
diff --git a/arch/arm/boot/dts/rk3188.dtsi b/arch/arm/boot/dts/rk3188.dtsi
index 9271833..c44c318 100644
--- a/arch/arm/boot/dts/rk3188.dtsi
+++ b/arch/arm/boot/dts/rk3188.dtsi
@@ -166,7 +166,7 @@
 		#size-cells = <0>;
 		status = "disabled";
 
-		usbphy0: usb-phy0 {
+		usbphy0: usb-phy at 10c {
 			#phy-cells = <0>;
 			reg = <0x10c>;
 			clocks = <&cru SCLK_OTGPHY0>;
@@ -174,7 +174,7 @@
 			#clock-cells = <0>;
 		};
 
-		usbphy1: usb-phy1 {
+		usbphy1: usb-phy at 11c {
 			#phy-cells = <0>;
 			reg = <0x11c>;
 			clocks = <&cru SCLK_OTGPHY1>;
diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index f445d19..ee4085d 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -967,7 +967,7 @@
 		#size-cells = <0>;
 		status = "disabled";
 
-		usbphy0: usb-phy0 {
+		usbphy0: usb-phy at 320 {
 			#phy-cells = <0>;
 			reg = <0x320>;
 			clocks = <&cru SCLK_OTGPHY0>;
@@ -975,7 +975,7 @@
 			#clock-cells = <0>;
 		};
 
-		usbphy1: usb-phy1 {
+		usbphy1: usb-phy at 334 {
 			#phy-cells = <0>;
 			reg = <0x334>;
 			clocks = <&cru SCLK_OTGPHY1>;
@@ -983,7 +983,7 @@
 			#clock-cells = <0>;
 		};
 
-		usbphy2: usb-phy2 {
+		usbphy2: usb-phy at 348 {
 			#phy-cells = <0>;
 			reg = <0x348>;
 			clocks = <&cru SCLK_OTGPHY2>;
-- 
2.6.4
