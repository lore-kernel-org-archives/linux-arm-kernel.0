From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 17 Sep 2014 00:48:16 +0200
Subject: [PATCH 1/2] ARM: dts: rockchip: fix swapped Radxa Rock pinctrl
 references
Message-ID: <6217952.a0HdpFGHLC@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The host and otg regulator pinctrl settings got swapped, making the host
reference the otg pinctrl and the other way round. The actual pins are
correct (gpio0-3 for host and gpio2-31 for otg).

Reported-by: Naoki FUKAUMI <naobsd@gmail.com>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/boot/dts/rk3188-radxarock.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/rk3188-radxarock.dts b/arch/arm/boot/dts/rk3188-radxarock.dts
index 1be0c34..c08744d 100644
--- a/arch/arm/boot/dts/rk3188-radxarock.dts
+++ b/arch/arm/boot/dts/rk3188-radxarock.dts
@@ -70,7 +70,7 @@
 		enable-active-high;
 		gpio = <&gpio2 31 GPIO_ACTIVE_HIGH>;
 		pinctrl-names = "default";
-		pinctrl-0 = <&host_vbus_drv>;
+		pinctrl-0 = <&otg_vbus_drv>;
 		regulator-name = "otg-vbus";
 		regulator-min-microvolt = <5000000>;
 		regulator-max-microvolt = <5000000>;
@@ -93,7 +93,7 @@
 		enable-active-high;
 		gpio = <&gpio0 3 GPIO_ACTIVE_HIGH>;
 		pinctrl-names = "default";
-		pinctrl-0 = <&otg_vbus_drv>;
+		pinctrl-0 = <&host_vbus_drv>;
 		regulator-name = "host-pwr";
 		regulator-min-microvolt = <5000000>;
 		regulator-max-microvolt = <5000000>;
-- 
2.0.1
