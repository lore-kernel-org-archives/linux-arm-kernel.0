From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Fri, 30 Jan 2015 00:43:11 +0100
Subject: [PATCH 2/2] ARM: dts: rockchip: move the hdmi ddc-i2c-bus property to
 the actual boards
In-Reply-To: <3746086.qLJlieorB7@diego>
References: <3746086.qLJlieorB7@diego>
Message-ID: <7335328.BluQKWqSL0@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently the hdmi driver is using one of the soc i2c busses for ddc probing
and while documentation always specifies i2c5 as hdmi-i2c it could very well
be any other bus as well.

Therefore this is a property of the board and should be specified there.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/boot/dts/rk3288-evb.dtsi     | 1 +
 arch/arm/boot/dts/rk3288-firefly.dtsi | 1 +
 arch/arm/boot/dts/rk3288.dtsi         | 1 -
 3 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/rk3288-evb.dtsi b/arch/arm/boot/dts/rk3288-evb.dtsi
index 6857730..86ede58 100644
--- a/arch/arm/boot/dts/rk3288-evb.dtsi
+++ b/arch/arm/boot/dts/rk3288-evb.dtsi
@@ -105,6 +105,7 @@
 };
 
 &hdmi {
+	ddc-i2c-bus = <&i2c5>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/rk3288-firefly.dtsi b/arch/arm/boot/dts/rk3288-firefly.dtsi
index 6dcc5e9..e6f873a 100644
--- a/arch/arm/boot/dts/rk3288-firefly.dtsi
+++ b/arch/arm/boot/dts/rk3288-firefly.dtsi
@@ -180,6 +180,7 @@
 };
 
 &hdmi {
+	ddc-i2c-bus = <&i2c5>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index 1e75a0f..1141850 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -646,7 +646,6 @@
 		compatible = "rockchip,rk3288-dw-hdmi";
 		reg = <0xff980000 0x20000>;
 		reg-io-width = <4>;
-		ddc-i2c-bus = <&i2c5>;
 		rockchip,grf = <&grf>;
 		interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cru  PCLK_HDMI_CTRL>, <&cru SCLK_HDMI_HDCP>;
-- 
2.1.1
