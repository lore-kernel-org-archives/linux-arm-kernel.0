From: heiko@sntech.de (Heiko Stuebner)
Date: Sat,  6 Sep 2014 01:06:11 +0200
Subject: [PATCH 08/11] ARM: dts: rockchip: add operating points and armclk
 references
In-Reply-To: <1409958374-30937-1-git-send-email-heiko@sntech.de>
References: <1409958374-30937-1-git-send-email-heiko@sntech.de>
Message-ID: <1409958374-30937-9-git-send-email-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add basic OPP entries for current supported Rockchip SoCs.
The operating points are currently very conservative, so individual
boards may opt to redefine them.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/boot/dts/rk3066a.dtsi | 12 +++++++++++-
 arch/arm/boot/dts/rk3188.dtsi  | 15 ++++++++++++++-
 arch/arm/boot/dts/rk3288.dtsi  | 17 ++++++++++++++++-
 3 files changed, 41 insertions(+), 3 deletions(-)

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
index 5950b0a..9275a47 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -40,10 +40,25 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		cpu at 500 {
+		cpu0: cpu at 500 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a12";
 			reg = <0x500>;
+			operating-points = <
+				/* KHz    uV */
+				1416000 1150000
+				1200000 1050000
+				1008000 1000000
+				816000  950000
+				696000  900000
+				600000  850000
+				408000  850000
+				312000  850000
+				216000  850000
+				126000  850000
+			>;
+			clock-latency = <40000>;
+			clocks = <&cru ARMCLK>;
 		};
 		cpu at 501 {
 			device_type = "cpu";
-- 
2.0.1
