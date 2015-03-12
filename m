From: heiko@sntech.de (Heiko Stuebner)
Date: Thu, 12 Mar 2015 21:46:06 +0100
Subject: [PATCH v3 2/2] ARM: dts: rockchip: add hdmi analog power supplies to
 rk3288 boards
In-Reply-To: <4184159.j0iXe39dFB@phil>
References: <4184159.j0iXe39dFB@phil>
Message-ID: <2410885.atPeD2Ud1D@phil>
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
+	vp-supply = <&vdd10_lcd>;
+	vph-supply = <&vcc18_lcd>;
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
+	vp-supply = <&vdd10_lcd>;
+	vph-supply = <&vcc18_lcd>;
 	ddc-i2c-bus = <&i2c5>;
 	status = "okay";
 };
-- 
2.1.4
