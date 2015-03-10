From: heiko@sntech.de (Heiko Stuebner)
Date: Tue, 10 Mar 2015 22:46:12 +0100
Subject: [PATCH v2 2/2] ARM: dts: rockchip: add hdmi analog power supplies to
 rk3288 boards
In-Reply-To: <2265807.RXHBN9kUi4@phil>
References: <2265807.RXHBN9kUi4@phil>
Message-ID: <8697545.hEXqZSJ3TS@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the recently added hdmi power supplies to evb and firefly boards.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/boot/dts/rk3288-evb.dtsi     | 2 ++
 arch/arm/boot/dts/rk3288-firefly.dtsi | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288-evb.dtsi b/arch/arm/boot/dts/rk3288-evb.dtsi
index 5e895a5..edd45a0 100644
--- a/arch/arm/boot/dts/rk3288-evb.dtsi
+++ b/arch/arm/boot/dts/rk3288-evb.dtsi
@@ -118,6 +118,8 @@
 };
 
 &hdmi {
+	avdd1v0-supply = <&vdd10_lcd>;
+	avdd1v8-supply = <&vcc18_lcd>;
 	ddc-i2c-bus = <&i2c5>;
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/rk3288-firefly.dtsi b/arch/arm/boot/dts/rk3288-firefly.dtsi
index e6f873a..09fcded 100644
--- a/arch/arm/boot/dts/rk3288-firefly.dtsi
+++ b/arch/arm/boot/dts/rk3288-firefly.dtsi
@@ -180,6 +180,8 @@
 };
 
 &hdmi {
+	avdd1v0-supply = <&vdd10_lcd>;
+	avdd1v8-supply = <&vcc18_lcd>;
 	ddc-i2c-bus = <&i2c5>;
 	status = "okay";
 };
-- 
2.1.4
