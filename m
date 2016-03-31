From: heiko@sntech.de (Heiko Stuebner)
Date: Thu, 31 Mar 2016 15:50:38 +0200
Subject: [PATCH] ARM: dts: rockchip: move rk3036 memory definition to board
 files
Message-ID: <1459432238-6469-1-git-send-email-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The amount of available memory is clearly a board-specific value, so
the core per-soc dtsi should not define a default of any sort.
Therefore move the memory-nodes to the two board files.

Also fix the amount of memory on Kylin (512MB instead of 1GB).
While in most cases the bootloader will override this with the
actual amount of memory, there is no need to keep known wrong values
in the board-dts.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/boot/dts/rk3036-evb.dts   | 5 +++++
 arch/arm/boot/dts/rk3036-kylin.dts | 5 +++++
 arch/arm/boot/dts/rk3036.dtsi      | 5 -----
 3 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/rk3036-evb.dts b/arch/arm/boot/dts/rk3036-evb.dts
index b3d6ec8..8db9e9b 100644
--- a/arch/arm/boot/dts/rk3036-evb.dts
+++ b/arch/arm/boot/dts/rk3036-evb.dts
@@ -45,6 +45,11 @@
 / {
 	model = "Rockchip RK3036 Evaluation board";
 	compatible = "rockchip,rk3036-evb", "rockchip,rk3036";
+
+	memory {
+		device_type = "memory";
+		reg = <0x60000000 0x40000000>;
+	};
 };
 
 &emac {
diff --git a/arch/arm/boot/dts/rk3036-kylin.dts b/arch/arm/boot/dts/rk3036-kylin.dts
index 6251d10..819d608 100644
--- a/arch/arm/boot/dts/rk3036-kylin.dts
+++ b/arch/arm/boot/dts/rk3036-kylin.dts
@@ -46,6 +46,11 @@
 	model = "Rockchip RK3036 KylinBoard";
 	compatible = "rockchip,rk3036-kylin", "rockchip,rk3036";
 
+	memory {
+		device_type = "memory";
+		reg = <0x60000000 0x20000000>;
+	};
+
 	leds: gpio-leds {
 		compatible = "gpio-leds";
 
diff --git a/arch/arm/boot/dts/rk3036.dtsi b/arch/arm/boot/dts/rk3036.dtsi
index d0f4bb7..eb44a33 100644
--- a/arch/arm/boot/dts/rk3036.dtsi
+++ b/arch/arm/boot/dts/rk3036.dtsi
@@ -63,11 +63,6 @@
 		spi = &spi;
 	};
 
-	memory {
-		device_type = "memory";
-		reg = <0x60000000 0x40000000>;
-	};
-
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
-- 
2.6.4
