From: jacob-chen@iotwrt.com (Jacob Chen)
Date: Sat,  1 Jul 2017 20:56:09 +0800
Subject: [PATCH 2/3] arm64: dts: rockchip: add gpu opp table for rk3399
In-Reply-To: <1498913770-16519-1-git-send-email-jacob-chen@iotwrt.com>
References: <1498913770-16519-1-git-send-email-jacob-chen@iotwrt.com>
Message-ID: <1498913770-16519-2-git-send-email-jacob-chen@iotwrt.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

midgard-t860 gpu in rk3399 support run in 800MHz.

Signed-off-by: Jacob Chen <jacob-chen@iotwrt.com>
---
 arch/arm64/boot/dts/rockchip/rk3399-opp.dtsi | 33 ++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-opp.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-opp.dtsi
index c83460d..3d88ba2 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-opp.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-opp.dtsi
@@ -110,6 +110,35 @@
 			opp-microvolt = <1200000>;
 		};
 	};
+
+	gpu_opp_table: opp-table2 {
+		compatible = "operating-points-v2";
+
+		opp-200000000 {
+			opp-hz = /bits/ 64 <200000000>;
+			opp-microvolt = <800000>;
+		};
+		opp-297000000 {
+			opp-hz = /bits/ 64 <297000000>;
+			opp-microvolt = <800000>;
+		};
+		opp-400000000 {
+			opp-hz = /bits/ 64 <400000000>;
+			opp-microvolt = <825000>;
+		};
+		opp-500000000 {
+			opp-hz = /bits/ 64 <500000000>;
+			opp-microvolt = <875000>;
+		};
+		opp-600000000 {
+			opp-hz = /bits/ 64 <600000000>;
+			opp-microvolt = <925000>;
+		};
+		opp-800000000 {
+			opp-hz = /bits/ 64 <800000000>;
+			opp-microvolt = <1100000>;
+		};
+	};
 };
 
 &cpu_l0 {
@@ -135,3 +164,7 @@
 &cpu_b1 {
 	operating-points-v2 = <&cluster1_opp>;
 };
+
+&gpu {
+	operating-points-v2 = <&gpu_opp_table>;
+};
-- 
2.7.4
