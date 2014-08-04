From: dianders@chromium.org (Doug Anderson)
Date: Mon,  4 Aug 2014 13:24:38 -0700
Subject: [PATCH] ARM: dts: Fix the sort ordering of EHCI and HSIC in
 rk3288.dtsi
Message-ID: <1407183878-17734-1-git-send-email-dianders@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The EHCI and HSIC device tree nodes were added in the wrong place.
Fix them.

Signed-off-by: Doug Anderson <dianders@chromium.org>
Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
---
I split this out from Kever's series so it can land.  The merge
conflict with his patch shouldn't be too hard to resolve.  Sorry for
messing up the sort order when I originally sent out the USB patches.
:(

 arch/arm/boot/dts/rk3288.dtsi | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index e7cb008..5950b0a 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -195,6 +195,26 @@
 		status = "disabled";
 	};
 
+	usb_host0_ehci: usb at ff500000 {
+		compatible = "generic-ehci";
+		reg = <0xff500000 0x100>;
+		interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru HCLK_USBHOST0>;
+		clock-names = "usbhost";
+		status = "disabled";
+	};
+
+	/* NOTE: ohci at ff520000 doesn't actually work on hardware */
+
+	usb_hsic: usb at ff5c0000 {
+		compatible = "generic-ehci";
+		reg = <0xff5c0000 0x100>;
+		interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru HCLK_HSIC>;
+		clock-names = "usbhost";
+		status = "disabled";
+	};
+
 	i2c0: i2c at ff650000 {
 		compatible = "rockchip,rk3288-i2c";
 		reg = <0xff650000 0x1000>;
@@ -251,26 +271,6 @@
 		status = "disabled";
 	};
 
-	usb_host0_ehci: usb at ff500000 {
-		compatible = "generic-ehci";
-		reg = <0xff500000 0x100>;
-		interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&cru HCLK_USBHOST0>;
-		clock-names = "usbhost";
-		status = "disabled";
-	};
-
-	/* NOTE: ohci at ff520000 doesn't actually work on hardware */
-
-	usb_hsic: usb at ff5c0000 {
-		compatible = "generic-ehci";
-		reg = <0xff5c0000 0x100>;
-		interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&cru HCLK_HSIC>;
-		clock-names = "usbhost";
-		status = "disabled";
-	};
-
 	gic: interrupt-controller at ffc01000 {
 		compatible = "arm,gic-400";
 		interrupt-controller;
-- 
2.0.0.526.g5318336
