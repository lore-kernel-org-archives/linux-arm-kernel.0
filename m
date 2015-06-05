From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Fri, 05 Jun 2015 19:07:34 +0200
Subject: [PATCH v4 3/3] ARM: dts: rockchip: add hdmi analog power supplies to
 rk3288 boards
In-Reply-To: <1707049.JEvfTcofKv@diego>
References: <1707049.JEvfTcofKv@diego>
Message-ID: <2174509.z9PNBvxjWd@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the recently added hdmi power supplies to evb and firefly boards.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
changes since v3:
- add entries for popmetal board

 arch/arm/boot/dts/rk3288-evb.dtsi     | 2 ++
 arch/arm/boot/dts/rk3288-firefly.dtsi | 2 ++
 arch/arm/boot/dts/rk3288-popmetal.dts | 2 ++
 3 files changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288-evb.dtsi b/arch/arm/boot/dts/rk3288-evb.dtsi
index 844a6fb..a57fbe3 100644
--- a/arch/arm/boot/dts/rk3288-evb.dtsi
+++ b/arch/arm/boot/dts/rk3288-evb.dtsi
@@ -172,6 +172,8 @@
 };
 
 &hdmi {
 	ddc-i2c-bus = <&i2c5>;
+	vp-supply = <&vdd10_lcd>;
+	vph-supply = <&vcc18_lcd>;
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/rk3288-firefly.dtsi b/arch/arm/boot/dts/rk3288-firefly.dtsi
index 0b42372..68068d9 100644
--- a/arch/arm/boot/dts/rk3288-firefly.dtsi
+++ b/arch/arm/boot/dts/rk3288-firefly.dtsi
@@ -196,6 +196,8 @@
 };
 
 &hdmi {
 	ddc-i2c-bus = <&i2c5>;
+	vp-supply = <&vdd10_lcd>;
+	vph-supply = <&vcc18_lcd>;
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/rk3288-popmetal.dts b/arch/arm/boot/dts/rk3288-popmetal.dts
index d582811..98f4d77 100644
--- a/arch/arm/boot/dts/rk3288-popmetal.dts
+++ b/arch/arm/boot/dts/rk3288-popmetal.dts
@@ -141,6 +141,8 @@
 
 &hdmi {
 	ddc-i2c-bus = <&i2c5>;
+	vp-supply = <&vdd10_lcd>;
+	vph-supply = <&vcc18_lcd>;
 	status = "okay";
 };
 
-- 
2.1.4
