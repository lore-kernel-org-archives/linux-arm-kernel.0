From: dianders@chromium.org (Douglas Anderson)
Date: Fri, 23 Oct 2015 11:28:10 -0700
Subject: [PATCH 3/4] ARM: dts: rockchip: Enable the USB phys as reset
 providers on rk3288
In-Reply-To: <1445624891-31680-1-git-send-email-dianders@chromium.org>
References: <1445624891-31680-1-git-send-email-dianders@chromium.org>
Message-ID: <1445624891-31680-4-git-send-email-dianders@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As per the change to the rk3288 USB phy driver, we can now enable the
PHYs as reset providers.  Do so.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
 arch/arm/boot/dts/rk3288.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index 906e938..4f76805 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -778,6 +778,7 @@
 
 		usbphy0: usb-phy0 {
 			#phy-cells = <0>;
+			#reset-cells = <0>;
 			reg = <0x320>;
 			clocks = <&cru SCLK_OTGPHY0>;
 			clock-names = "phyclk";
@@ -785,6 +786,7 @@
 
 		usbphy1: usb-phy1 {
 			#phy-cells = <0>;
+			#reset-cells = <0>;
 			reg = <0x334>;
 			clocks = <&cru SCLK_OTGPHY1>;
 			clock-names = "phyclk";
@@ -792,6 +794,7 @@
 
 		usbphy2: usb-phy2 {
 			#phy-cells = <0>;
+			#reset-cells = <0>;
 			reg = <0x348>;
 			clocks = <&cru SCLK_OTGPHY2>;
 			clock-names = "phyclk";
-- 
2.6.0.rc2.230.g3dd15c0
