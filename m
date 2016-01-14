From: wxt@rock-chips.com (Caesar Wang)
Date: Thu, 14 Jan 2016 09:08:41 +0800
Subject: [PATCH] ARM: dts: rockchip: make more compatible for rk3036 SoCs
Message-ID: <1452733721-28110-1-git-send-email-wxt@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch will be better to support and compatible for rk3036.
Although some other SoCs drivers also can work for rk3036, that will
prevent some mutatin factors for drivers.

Signed-off-by: Caesar Wang <wxt@rock-chips.com>
---

 arch/arm/boot/dts/rk3036.dtsi | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/rk3036.dtsi b/arch/arm/boot/dts/rk3036.dtsi
index ee457a2..7897449 100644
--- a/arch/arm/boot/dts/rk3036.dtsi
+++ b/arch/arm/boot/dts/rk3036.dtsi
@@ -161,7 +161,7 @@
 	};
 
 	usb_otg: usb at 10180000 {
-		compatible = "rockchip,rk3288-usb", "rockchip,rk3066-usb",
+		compatible = "rockchip,rk3036-usb", "rockchip,rk3066-usb",
 				"snps,dwc2";
 		reg = <0x10180000 0x40000>;
 		interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
@@ -176,7 +176,7 @@
 	};
 
 	usb_host: usb at 101c0000 {
-		compatible = "rockchip,rk3288-usb", "rockchip,rk3066-usb",
+		compatible = "rockchip,rk3036-usb", "rockchip,rk3066-usb",
 				"snps,dwc2";
 		reg = <0x101c0000 0x40000>;
 		interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
@@ -211,7 +211,7 @@
 	};
 
 	emmc: dwmmc at 1021c000 {
-		compatible = "rockchip,rk3288-dw-mshc";
+		compatible = "rockchip,rk3036-dw-mshc", "rockchip,rk3288-dw-mshc";
 		reg = <0x1021c000 0x4000>;
 		interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
 		broken-cd;
@@ -327,7 +327,7 @@
 	};
 
 	i2c1: i2c at 20056000 {
-		compatible = "rockchip,rk3288-i2c";
+		compatible = "rockchip,rk3036-i2c", "rockchip,rk3288-i2c";
 		reg = <0x20056000 0x1000>;
 		interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
 		#address-cells = <1>;
@@ -340,7 +340,7 @@
 	};
 
 	i2c2: i2c at 2005a000 {
-		compatible = "rockchip,rk3288-i2c";
+		compatible = "rockchip,rk3036-i2c", "rockchip,rk3288-i2c";
 		reg = <0x2005a000 0x1000>;
 		interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
 		#address-cells = <1>;
@@ -395,7 +395,7 @@
 	};
 
 	i2c0: i2c at 20072000 {
-		compatible = "rockchip,rk3288-i2c";
+		compatible = "rockchip,rk3036-i2c", "rockchip,rk3288-i2c";
 		reg = <0x20072000 0x1000>;
 		interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
 		#address-cells = <1>;
-- 
1.9.1
