From: heiko.stuebner@collabora.com (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 02 Dec 2015 19:03:56 +0100
Subject: [PATCH] ARM: dts: rockchip: add devicetree node to veyron minnie
Message-ID: <2165846.YmcBK0foD2@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Minnie provides an elan,ekth3500 touchscreen over the display,
so add the necessary node to enable it.

Signed-off-by: Heiko Stuebner <heiko.stuebner@collabora.com>
---
 arch/arm/boot/dts/rk3288-veyron-minnie.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288-veyron-minnie.dts b/arch/arm/boot/dts/rk3288-veyron-minnie.dts
index 85f0373..699beb0 100644
--- a/arch/arm/boot/dts/rk3288-veyron-minnie.dts
+++ b/arch/arm/boot/dts/rk3288-veyron-minnie.dts
@@ -121,6 +121,18 @@
 	clock-frequency = <400000>;
 	i2c-scl-falling-time-ns = <50>;
 	i2c-scl-rising-time-ns = <300>;
+
+	touchscreen at 10 {
+		compatible = "elan,ekth3500";
+		reg = <0x10>;
+		interrupt-parent = <&gpio2>;
+		interrupts = <14 IRQ_TYPE_EDGE_FALLING>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&touch_int &touch_rst>;
+		reset-gpios = <&gpio2 15 GPIO_ACTIVE_LOW>;
+		vcc33-supply = <&vcc33_touch>;
+		vccio-supply = <&vcc33_touch>;
+	};
 };
 
 &rk808 {
-- 
2.6.1
