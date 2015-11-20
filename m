From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 19 Nov 2015 17:05:27 -0800
Subject: [PATCH 20/29] ARM: shmobile: r8a7794: Add DU node to device tree
In-Reply-To: <cover.1447981420.git.horms+renesas@verge.net.au>
References: <cover.1447981420.git.horms+renesas@verge.net.au>
Message-ID: <46c4f13d04d729fa79f7df2dd1978f9fc0ee6d6a.1447981420.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Add the DU device with a disabled state. Boards that want to enable the
DU need to specify the output topology.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7794.dtsi | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7794.dtsi b/arch/arm/boot/dts/r8a7794.dtsi
index b70e4061d8b1..4075a0a3d5c1 100644
--- a/arch/arm/boot/dts/r8a7794.dtsi
+++ b/arch/arm/boot/dts/r8a7794.dtsi
@@ -750,6 +750,34 @@
 		};
 	};
 
+	du: display at feb00000 {
+		compatible = "renesas,du-r8a7794";
+		reg = <0 0xfeb00000 0 0x40000>;
+		reg-names = "du";
+		interrupts = <0 256 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 268 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp7_clks R8A7794_CLK_DU0>,
+			 <&mstp7_clks R8A7794_CLK_DU0>;
+		clock-names = "du.0", "du.1";
+		status = "disabled";
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port at 0 {
+				reg = <0>;
+				du_out_rgb0: endpoint {
+				};
+			};
+			port at 1 {
+				reg = <1>;
+				du_out_rgb1: endpoint {
+				};
+			};
+		};
+	};
+
 	clocks {
 		#address-cells = <2>;
 		#size-cells = <2>;
-- 
2.1.4
