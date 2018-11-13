From: heiko@sntech.de (Heiko Stuebner)
Date: Tue, 13 Nov 2018 14:05:58 +0100
Subject: [PATCH 5/6] ARM: dts: rockchip: update cpu supplies on rk3188
In-Reply-To: <20181113130559.31221-1-heiko@sntech.de>
References: <20181113130559.31221-1-heiko@sntech.de>
Message-ID: <20181113130559.31221-6-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Heiko Stuebner <heiko.stuebner@bq.com>

cpu0-supply in cpu0 is deprecated, instead each cpu-core is supposed to
list its supply separately. With the added cpu core phandles, update
existing rk3188 boards accordingly.

Signed-off-by: Heiko Stuebner <heiko.stuebner@bq.com>
---
 arch/arm/boot/dts/rk3188-px3-evb.dts   | 14 +++++++++++++-
 arch/arm/boot/dts/rk3188-radxarock.dts | 14 +++++++++++++-
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/rk3188-px3-evb.dts b/arch/arm/boot/dts/rk3188-px3-evb.dts
index 375129b62102..9ae65c767c90 100644
--- a/arch/arm/boot/dts/rk3188-px3-evb.dts
+++ b/arch/arm/boot/dts/rk3188-px3-evb.dts
@@ -44,7 +44,19 @@
 };
 
 &cpu0 {
-	cpu0-supply = <&vdd_cpu>;
+	cpu-supply = <&vdd_cpu>;
+};
+
+&cpu1 {
+	cpu-supply = <&vdd_cpu>;
+};
+
+&cpu2 {
+	cpu-supply = <&vdd_cpu>;
+};
+
+&cpu3 {
+	cpu-supply = <&vdd_cpu>;
 };
 
 &emmc {
diff --git a/arch/arm/boot/dts/rk3188-radxarock.dts b/arch/arm/boot/dts/rk3188-radxarock.dts
index 0e5e4cf3d84c..9175b58c244a 100644
--- a/arch/arm/boot/dts/rk3188-radxarock.dts
+++ b/arch/arm/boot/dts/rk3188-radxarock.dts
@@ -153,7 +153,19 @@
 };
 
 &cpu0 {
-	cpu0-supply = <&vdd_arm>;
+	cpu-supply = <&vdd_arm>;
+};
+
+&cpu1 {
+	cpu-supply = <&vdd_arm>;
+};
+
+&cpu2 {
+	cpu-supply = <&vdd_arm>;
+};
+
+&cpu3 {
+	cpu-supply = <&vdd_arm>;
 };
 
 &gpu {
-- 
2.18.0
