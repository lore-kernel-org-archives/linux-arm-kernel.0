From: heiko@sntech.de (Heiko Stuebner)
Date: Tue, 13 Nov 2018 14:05:57 +0100
Subject: [PATCH 4/6] ARM: dts: rockchip: add phandles to secondary cpu cores
In-Reply-To: <20181113130559.31221-1-heiko@sntech.de>
References: <20181113130559.31221-1-heiko@sntech.de>
Message-ID: <20181113130559.31221-5-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Heiko Stuebner <heiko.stuebner@bq.com>

Add phandles to secondary cpu cores as we may need to reference these
down the road as well.

Signed-off-by: Heiko Stuebner <heiko.stuebner@bq.com>
---
 arch/arm/boot/dts/rk3188.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/rk3188.dtsi b/arch/arm/boot/dts/rk3188.dtsi
index f1f7a36b46d4..4acb501dd3f8 100644
--- a/arch/arm/boot/dts/rk3188.dtsi
+++ b/arch/arm/boot/dts/rk3188.dtsi
@@ -28,7 +28,7 @@
 			operating-points-v2 = <&cpu0_opp_table>;
 			resets = <&cru SRST_CORE0>;
 		};
-		cpu at 1 {
+		cpu1: cpu at 1 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			next-level-cache = <&L2>;
@@ -36,7 +36,7 @@
 			operating-points-v2 = <&cpu0_opp_table>;
 			resets = <&cru SRST_CORE1>;
 		};
-		cpu at 2 {
+		cpu2: cpu at 2 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			next-level-cache = <&L2>;
@@ -44,7 +44,7 @@
 			operating-points-v2 = <&cpu0_opp_table>;
 			resets = <&cru SRST_CORE2>;
 		};
-		cpu at 3 {
+		cpu3: cpu at 3 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			next-level-cache = <&L2>;
-- 
2.18.0
