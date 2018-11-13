From: heiko@sntech.de (Heiko Stuebner)
Date: Tue, 13 Nov 2018 14:05:56 +0100
Subject: [PATCH 3/6] ARM: dts: rockchip: add cpu-core resets for rk3188
In-Reply-To: <20181113130559.31221-1-heiko@sntech.de>
References: <20181113130559.31221-1-heiko@sntech.de>
Message-ID: <20181113130559.31221-4-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Heiko Stuebner <heiko.stuebner@bq.com>

Specify the reset handles for each cpu core.

Signed-off-by: Heiko Stuebner <heiko.stuebner@bq.com>
---
 arch/arm/boot/dts/rk3188.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/rk3188.dtsi b/arch/arm/boot/dts/rk3188.dtsi
index 9d8c4c560e51..f1f7a36b46d4 100644
--- a/arch/arm/boot/dts/rk3188.dtsi
+++ b/arch/arm/boot/dts/rk3188.dtsi
@@ -26,6 +26,7 @@
 			clock-latency = <40000>;
 			clocks = <&cru ARMCLK>;
 			operating-points-v2 = <&cpu0_opp_table>;
+			resets = <&cru SRST_CORE0>;
 		};
 		cpu at 1 {
 			device_type = "cpu";
@@ -33,6 +34,7 @@
 			next-level-cache = <&L2>;
 			reg = <0x1>;
 			operating-points-v2 = <&cpu0_opp_table>;
+			resets = <&cru SRST_CORE1>;
 		};
 		cpu at 2 {
 			device_type = "cpu";
@@ -40,6 +42,7 @@
 			next-level-cache = <&L2>;
 			reg = <0x2>;
 			operating-points-v2 = <&cpu0_opp_table>;
+			resets = <&cru SRST_CORE2>;
 		};
 		cpu at 3 {
 			device_type = "cpu";
@@ -47,6 +50,7 @@
 			next-level-cache = <&L2>;
 			reg = <0x3>;
 			operating-points-v2 = <&cpu0_opp_table>;
+			resets = <&cru SRST_CORE3>;
 		};
 	};
 
-- 
2.18.0
