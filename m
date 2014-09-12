From: heiko@sntech.de (Heiko Stuebner)
Date: Sat, 13 Sep 2014 00:34:29 +0200
Subject: [PATCH 1/3] ARM: dts: rockchip: add operating points and armclk
 references
In-Reply-To: <1410561271-19197-1-git-send-email-heiko@sntech.de>
References: <1410561271-19197-1-git-send-email-heiko@sntech.de>
Message-ID: <1410561271-19197-2-git-send-email-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add basic OPP entries for current supported Rockchip SoCs.
The operating points are currently very conservative, so individual
boards may opt to redefine them.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
---
 arch/arm/boot/dts/rk3066a.dtsi | 12 +++++++++++-
 arch/arm/boot/dts/rk3188.dtsi  | 15 ++++++++++++++-
 arch/arm/boot/dts/rk3288.dtsi  | 19 ++++++++++++++++++-
 3 files changed, 43 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/rk3066a.dtsi b/arch/arm/boot/dts/rk3066a.dtsi
index 879a818..572c30b 100644
--- a/arch/arm/boot/dts/rk3066a.dtsi
+++ b/arch/arm/boot/dts/rk3066a.dtsi
@@ -26,11 +26,21 @@
 		#size-cells = <0>;
 		enable-method = "rockchip,rk3066-smp";
 
-		cpu at 0 {
+		cpu0: cpu at 0 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			next-level-cache = <&L2>;
 			reg = <0x0>;
+			operating-points = <
+				/* kHz    uV */
+				1008000 1075000
+				 816000 1025000
+				 600000 1025000
+				 504000 1000000
+				 312000  975000
+			>;
+			clock-latency = <40000>;
+			clocks = <&cru ARMCLK>;
 		};
 		cpu at 1 {
 			device_type = "cpu";
diff --git a/arch/arm/boot/dts/rk3188.dtsi b/arch/arm/boot/dts/rk3188.dtsi
index ee801a9..e237216 100644
--- a/arch/arm/boot/dts/rk3188.dtsi
+++ b/arch/arm/boot/dts/rk3188.dtsi
@@ -26,11 +26,24 @@
 		#size-cells = <0>;
 		enable-method = "rockchip,rk3066-smp";
 
-		cpu at 0 {
+		cpu0: cpu at 0 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			next-level-cache = <&L2>;
 			reg = <0x0>;
+			operating-points = <
+				/* kHz    uV */
+				1608000 1350000
+				1416000 1250000
+				1200000 1150000
+				1008000 1075000
+				 816000  975000
+				 600000  950000
+				 504000  925000
+				 312000  875000
+			>;
+			clock-latency = <40000>;
+			clocks = <&cru ARMCLK>;
 		};
 		cpu at 1 {
 			device_type = "cpu";
diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index 37a8ac8..7db8432 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -47,10 +47,27 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		cpu at 500 {
+		cpu0: cpu at 500 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a12";
 			reg = <0x500>;
+			operating-points = <
+				/* KHz    uV */
+				1608000 1350000
+				1512000 1300000
+				1416000 1200000
+				1200000 1100000
+				1008000 1050000
+				 816000 1000000
+				 696000  950000
+				 600000  900000
+				 408000  900000
+				 312000  900000
+				 216000  900000
+				 126000  900000
+			>;
+			clock-latency = <40000>;
+			clocks = <&cru ARMCLK>;
 		};
 		cpu at 501 {
 			device_type = "cpu";
-- 
2.0.1
